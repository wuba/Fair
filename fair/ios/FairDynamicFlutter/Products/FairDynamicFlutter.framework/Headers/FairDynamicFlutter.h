/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import <Foundation/Foundation.h>

#if defined(__cplusplus)
#define FAIR_FFI_EXTERN extern "C" __attribute__((visibility("default"))) __attribute__((used))
#else
#define FAIR_FFI_EXTERN extern __attribute__((visibility("default"))) __attribute__((used))
#endif


/// 同步方法调用
FAIR_FFI_EXTERN const char *invokeJSCommonFuncSync(char *args);

/// FFI协议
@protocol FAIRFFIProtocol <NSObject>

/// 同步方法调用
/// @param args 参数
- (const char *)executeScriptSyncImpl:(char *)args;

@end

@interface FairDynamicFlutter : NSObject

@property (nonatomic, weak) id<FAIRFFIProtocol> delegate;

+ (instancetype)sharedInstance;

@end
