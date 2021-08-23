/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

/*  Fair通信流程管理类 */

#import <Foundation/Foundation.h>
#import <FairDynamicFlutter/FairDynamicFlutter.h>
#import "FairJSBridge.h"
#import <Flutter/FlutterPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface FairProcessManager : NSObject <FairJSExportDelegate>

+ (FairProcessManager *)sharedInstance;

/// 开始Fair流程
- (void)startFairProcessWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;

@end

NS_ASSUME_NONNULL_END

