//
//  FairDynamicFlutter.m
//  FairDynamicFlutter
//
//  Created by 单鹏涛 on 2021/5/12.
//

#import "FairDynamicFlutter.h"

/// 调用该方法前，需主动设置executeScriptSyncImpl
/// @param args 参数
/// @return 返回值
const char *invokeJSCommonFuncSync(char *args) {
    if ([FairDynamicFlutter sharedInstance].delegate &&
        [[FairDynamicFlutter sharedInstance].delegate respondsToSelector:@selector(executeScriptSyncImpl:)]) {
        return [[FairDynamicFlutter sharedInstance].delegate executeScriptSyncImpl:args];
    }
    return "";
}

@implementation FairDynamicFlutter

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
