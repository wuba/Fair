//
//  FairDartBridge.m
//  FairDynamicFlutter
//
//  Created by LiHao on 2021/6/9.
//

#import "FairDartBridge.h"
#import "FairDefine.h"
#import <Flutter/Flutter.h>
#import "FairDartModel.h"

@interface FairDartBridge ()

/// js注入通道
@property (nonatomic, strong) FlutterMethodChannel *flutterMethodChannel;
/// Fair的flutter通道
@property (nonatomic, strong) FlutterBasicMessageChannel *flutterBasicMessageChannel;
/// binaryMessenger
@property (nonatomic, weak) NSObject<FlutterBinaryMessenger> *binaryMessenger;

@end

@implementation FairDartBridge

FairSingletonM(FairDartBridge);

- (void)sendMessageToDart:(NSString *)message {
    [self.flutterBasicMessageChannel sendMessage:message];
}

- (void)setDartChannel {
    // 设置同步执行代理
    [FairDynamicFlutter sharedInstance].delegate = self;
    
    self.binaryMessenger = (id <FlutterBinaryMessenger>)[UIApplication sharedApplication].delegate.window.rootViewController;
    // 设置从flutter拿到的js脚本的通道
    self.flutterMethodChannel = [FlutterMethodChannel methodChannelWithName:FairMessageChannelInjectionID binaryMessenger:self.binaryMessenger];
    // 设置Flutter通信通道代理
    self.flutterBasicMessageChannel = [[FlutterBasicMessageChannel alloc] initWithName:FairMessageChannelExecuteID binaryMessenger:self.binaryMessenger codec:[FlutterStringCodec sharedInstance]];
    
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
            if ([strongSelf.delegate respondsToSelector:@selector(injectionJSScriptWtihFilePath: callback:)]) {
#warning 测试代码，后期会直接加载JS语句
#ifdef DEBUG
                if ([model.path containsString:@"lib_src_page_sample_page_with_logic2"]) {
                    model.path = @"lib_src_page_sample_page_with_logic2.js";
                }
                else {
                    model.path = @"lib_src_page_sample_page_with_logic.js";
                }
#endif
                [strongSelf.delegate injectionJSScriptWtihFilePath:model.path callback:^(id result, NSError *error) {
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
        obj = [self.delegate executeJSFunctionSync:FairExecuteJSFunction params:@[[NSString stringWithFormat:@"%s", args]]];
    }
    NSString *result = [NSString stringWithFormat:@"%@", obj.toString];
    FairLog(@"result:%@", result);
    return result.UTF8String;
}

@end
