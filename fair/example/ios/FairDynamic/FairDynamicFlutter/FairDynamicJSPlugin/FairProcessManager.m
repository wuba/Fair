//
//  FairProcessManager.m
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/8.
//
//  Fair流程管理
//

#import "FairProcessManager.h"
#import "FairDartBridge.h"
#import "FairJSBridge.h"

@interface FairProcessManager()<FairDartBridgeExecuteJS>


@end

@implementation FairProcessManager


+ (FairProcessManager *)sharedInstance {
    
    static FairProcessManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FairProcessManager alloc] init];
    });
    return sharedInstance;
}

/// 开始Fair的整个流程
- (void)startFairProcess
{
    // 设置和dart的通信
    [[FairDartBridge sharedInstance] setDartChannel];
    
    // 设置dart调用js的delegate
    [FairDartBridge sharedInstance].delegate = self;
    
    // 设置native调用js的delegate
    [FairJSBridge sharedInstance].delegate = self;

    // 设置执行js的执行环境
    [[FairJSBridge sharedInstance] evaluateScriptWithJSFileAsync:@"main" callback:nil];
    // 后续可能会废弃
//    NSString *testJS = @"loadData({_count: 5,\n_onTapText: function () {\nthis._count = this._count + 1;console.log(this._count);\n this.setData({_count: this._count})\n}})";
//    [[FairJSBridge sharedInstance] evaluateScriptWithJSScriptAsync:testJS callback:nil];
}

#pragma mark - protocol FairDartBridgeExecuteJS

/// 同步执行JS
- (JSValue *)executeJSFunctionSync:(NSString *)functionName params:(NSArray *)params {
    return [[FairJSBridge sharedInstance] invokeJSFuctionSync:functionName params:params];
}

/// 异步执行JS
- (void)executeJSFunctionAsync:(NSString *)functionName params:(NSArray *)params callback:(FairCallback)callback {
    [[FairJSBridge sharedInstance] invokeJSFuctionAsync:functionName params:params callback:callback];
}

/// Dart 注入到 JS
- (void)injectionJSScriptWtihFilePath:(NSString *)filePath callback:(FairCallback)callback
{
    FairLog(@"%@", filePath);
    // 异步注入到JSContext里
    [[FairJSBridge sharedInstance] evaluateScriptWithJSFileAsync:filePath callback:callback];
}

#pragma mark - FairJSExportDelegate

/// JS 异步调用 Dart
- (void)FairExecuteDartFunctionAsync:(NSDictionary *)dic callBack:(FairCallback)callback
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;

    [[FairDartBridge sharedInstance] sendMessageToDart:result];

    if (callback) {
        callback(result, nil);
    }
}


/// JS 同步调用 Dart
- (void)FairExecuteDartFunctionSync:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;

    [[FairDartBridge sharedInstance] sendMessageToDart:result];
}

@end
