//
//  FairDynamicJSPlugin.m
//  FairDynamicFlutter
//
//  Created by 单鹏涛 on 2021/5/13.
//

#import "FairDynamicJSPlugin.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "FairProcessManager.h"
#import "FairDefine.h"

@implementation FairDynamicJSPlugin

static FairDynamicJSPlugin *fairDynamicJSPlugin = nil;
static JSContext *context = nil;

+ (FairDynamicJSPlugin *)shareInstance {
    return fairDynamicJSPlugin;
}

/// 注册
/// @param registrar 注册者
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    // 启动Fair
    [[FairProcessManager sharedInstance] startFairProcessWithRegistrar:registrar];

}
/// 释放
- (void)dispose {

}

@end
