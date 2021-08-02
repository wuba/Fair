/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

/*  主要负责JS及Native的通信 */

#import <Foundation/Foundation.h>
#import "FairJSExportProtocol.h"
#import "FairDefine.h"

@interface FairJSBridge : NSObject

/// JS相关协议
@property (nonatomic, weak) id<FairJSExportDelegate> delegate;

/// 单例
FairSingletonH()

#pragma mark -  执行JS注入到Native

/// 异步注入到Native的JS的某个JS文件
/// @param jsFilePath      JS文件的路径
/// @param callback           执行完成的回调，可为空
- (void)evaluateScriptWithJSFileAsync:(NSString *)jsFilePath callback:(FairCallback)callback;

/// 异步注入到Native的JS的某段代码或逻辑
/// @param jsScript            如 funtion test(a){…} 则需传入 test(a) 或 function test(a){…}
/// @param callback            执行完成的回调，可为空
- (void)evaluateScriptWithJSScriptAsync:(NSString *)jsScript callback:(FairCallback)callback;

/// 同步注入到Native的JS的某段代码或逻辑
/// @param jsFilePath      JS文件的路径
- (JSValue *)evaluateScriptWithJSFileSync:(NSString *)jsFilePath;

/// 同步注入到Native的JS的某段代码或逻辑
/// @param jsScript            如 funtion test(a){…} 则需传入 test(a) 或 function test(a){…}
/// @return              返回值可为空
- (JSValue *)evaluateScriptWithJSScriptSync:(NSString *)jsScript;

#pragma mark -  执行JS某个方法

/// 异步调用JS的某个方法
/// @param functionName     如  funtion test(a){…} 则需要传入 test
/// @param callback              回调可为空
- (void)invokeJSFunctionAsync:(NSString *)functionName params:(NSArray *)params callback:(FairCallback)callback;

/// 同步调用JS的某个方法
/// @param functionName     如  funtion test(a){…} 则需要传入 test
/// @return              返回值可为空
- (JSValue *)invokeJSFunctionSync:(NSString *)functionName params:(NSArray *)params;

#pragma mark -  通过JSValue直接执行这个JS方法

/// 通过JSValue直接执行这个JS方法
/// @param function     如  funtion test(a){…}
- (void)invokeJSFunction:(JSValue *)function param:(id)param;

#pragma mark -  释放

/// 释放JS页面
/// @param pageName     JS页面名称
- (void)disposePage:(NSString *)pageName;

@end
