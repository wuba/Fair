/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import "FairDynamicFlutter.h"

/// 同步方法调用，通过executeScriptSyncImpl进行回调
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
