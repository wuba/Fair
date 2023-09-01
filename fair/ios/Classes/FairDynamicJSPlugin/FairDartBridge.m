/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import "FairDartBridge.h"
#import "FairDefine.h"
#import <Flutter/Flutter.h>
#import "FairDartModel.h"

@interface FairDartBridge ()

/// js注入通道
@property (nonatomic, strong) FlutterMethodChannel *flutterMethodChannel;
/// Fair的flutter通道
@property (nonatomic, strong) FlutterBasicMessageChannel *flutterBasicMessageChannel;
/// fair回调通道
@property (nonatomic, strong) FlutterBasicMessageChannel *flutterCallbackMessageChannel;
/// binaryMessenger
@property (nonatomic, weak) NSObject<FlutterBinaryMessenger> *binaryMessenger;

@end

@implementation FairDartBridge

FairSingletonM(FairDartBridge);

- (void)sendMessageToDart:(NSString *)message callback:(FairCallback)callback {
    [self.flutterBasicMessageChannel sendMessage:message reply:^(id reply) {
        if (callback && FAIR_IS_NOT_EMPTY_STRING(reply)) {
            callback(reply, nil);
        }
    }];
}

- (void)setDartChannelWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    // 设置同步执行代理
    [FairDynamicFlutter sharedInstance].delegate = self;
    
    self.binaryMessenger = (id <FlutterBinaryMessenger>)registrar.messenger;
    // 设置从flutter拿到的js脚本的通道
    self.flutterMethodChannel = [FlutterMethodChannel methodChannelWithName:FairMessageChannelInjectionID binaryMessenger:self.binaryMessenger];
    // 设置Flutter通信通道代理
    self.flutterBasicMessageChannel = [[FlutterBasicMessageChannel alloc] initWithName:FairMessageChannelExecuteID
                                                                       binaryMessenger:self.binaryMessenger
                                                                                 codec:[FlutterStringCodec sharedInstance]];
    
    self.flutterCallbackMessageChannel = [[FlutterBasicMessageChannel alloc] initWithName:FairBasicMessageChannelExecuteID
                                                                          binaryMessenger:self.binaryMessenger
                                                                                    codec:[FlutterStringCodec sharedInstance]];
    
    [self setDartListener];
    
}

// 用来监听dart对native的调用
- (void)setDartListener {
    // 注入js
    FairWeakSelf(weakSelf);
    [self.flutterMethodChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterReply callback) {
        FairStrongObject(strongSelf, weakSelf);
        
        // 获取字典数据
        NSString *method = call.method;
        FairDartModel *model = [strongSelf obtainModelWithMessage:call.arguments];
        
        // 加载js
        if ([method isEqualToString:@"loadMainJs"]) {
            if ([strongSelf.delegate respondsToSelector:@selector(injectionJSScriptWtihJSScript: callback:)]) {
                [strongSelf.delegate injectionJSScriptWtihJSScript:model.path callback:^(id result, NSError *error) {
                    JSValue *value = result;
                    if (value && [value isKindOfClass:[JSValue class]]) {
                        NSString *str = value.toString;
                        if([str isEqualToString:@"undefined"]){
                            NSMutableDictionary *result=[NSMutableDictionary dictionary];
                            result[@"status"] = @"error";
                            result[@"errorInfo"]=@"load JavaScript error";
                            result[@"lineNumber"]=@-1;
                            
                            NSError *error = nil;
                            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&error];
                            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                              
                            
                            callback(jsonStr);
                            return;
                        }
                    }
                    callback(@"success");
                }];
            }
        }
        // 释放js
        else if ([method isEqualToString:@"releaseMainJs"]) {
            if ([strongSelf.delegate respondsToSelector:@selector(disposePage:)] && FAIR_IS_NOT_EMPTY_STRING(model.pageName)) {
                [strongSelf.delegate disposePage:model.pageName];
            }
        }
    }];
    // 执行js
    [self.flutterBasicMessageChannel setMessageHandler:^(id message, FlutterReply callback) {
        FairStrongObject(strongSelf, weakSelf);
        
        FairLog(@"%@", message);

        if (strongSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(executeJSFunctionAsync:params:callback:)]) {
            NSArray *params = message && [message isKindOfClass:[NSString class]] ? @[message] : @[];
            [strongSelf.delegate executeJSFunctionAsync:FairExecuteJSFunction params:params callback:^(id result, NSError *error) {
                FairLog(@"%@", result);
                JSValue *value = result;
                if (value && [value isKindOfClass:[JSValue class]]) {
                    NSString *str = value.toString;
                    FairLog(@"%@", str);
                    if (![str isEqualToString:@"undefined"] && FAIR_IS_NOT_EMPTY_STRING(str)) {
                        callback(str);
                    }
                }
            }];
        }
    }];
    
    [self.flutterCallbackMessageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        FairStrongObject(strongSelf, weakSelf);
        FairLog(@"%@", message);
        
        if (strongSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(executeJSFunctionAsync:params:callback:)]) {
            NSArray *params = message && [message isKindOfClass:[NSString class]] ? @[message] : @[];
            [strongSelf.delegate executeJSFunctionAsync:FairExecuteJSFunction params:params callback:^(id result, NSError *error) {
                FairLog(@"%@", result);
                JSValue *value = result;
                if (value && [value isKindOfClass:[JSValue class]]) {
                    NSString *str = value.toString;
                    FairLog(@"%@", str);
                    if (![str isEqualToString:@"undefined"] && FAIR_IS_NOT_EMPTY_STRING(str)) {
                        callback(str);
                    }
                }
            }];
        }
    }];
}

#pragma mark - Other Method

/// 通过message获取字典
- (FairDartModel *)obtainModelWithMessage:(id)message
{
    FairLog(@"%@", message);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if ([message isKindOfClass:[NSString class]]){
        NSError *error = nil;
        NSString *json = (NSString *)message;
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            FairLog(@"%@", error.description);
            return nil;
        }
    }
    else if ([message isKindOfClass:[NSDictionary class]]) {
        dic = [NSMutableDictionary dictionaryWithDictionary:message];
    }
    
    FairDartModel *model = [[FairDartModel alloc] initWithDictionary:dic];
    
    return model;
}

#pragma mark - FAIRFFIProtocol

- (const char *)executeScriptSyncImpl:(char *)args
{
    JSValue *obj;
    if (self.delegate && [self.delegate respondsToSelector:@selector(executeJSFunctionSync:params:)]) {
        
        NSString *str = [NSString stringWithUTF8String:args];
        obj = [self.delegate executeJSFunctionSync:FairExecuteJSFunction params:@[str]];
    }
    NSString *result = [NSString stringWithFormat:@"%@", obj.toString];
    FairLog(@"result:%@", result);
    if([result isEqualToString:@"undefined"]){
        //取args中的funcName字段
        //arg ===> "{\"pageName\":\"null#0\",\"type\":\"method\",\"args\":{\"funcName\":\"_getAuth\",\"args\":null}}"
        NSString *str = [NSString stringWithUTF8String:args];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *args = dic[@"args"];
        NSString *funcName = args[@"funcName"];
        
        FairLog(@"invoke funcName:%@",funcName);
        
        NSString *errorResult = [NSString stringWithFormat:@"Runtime error while invoke JavaScript method:%@()", funcName];
        
        return errorResult.UTF8String;
    }
    return result.UTF8String;
}

@end
