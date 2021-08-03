/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import <Foundation/Foundation.h>
#import "FairDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>

/// JS相关协议
@protocol FairJSExportDelegate <NSObject>

/// JS 异步调用 Dart
/// @param data    传递的JS数据到dart
/// @param callback    用于回调到JS
- (void)FairExecuteDartFunctionAsync:(NSString *)data callback:(JSValue *)callback;

/// JS 同步调用 Dart
/// @param data    传递的JS数据到dart
/// @param callback    用于回调到JS
- (void)FairExecuteDartFunctionSync:(NSString *)data callback:(JSValue *)callback;

@end


@interface FairJSExportProtocol : NSObject

@end
