/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

/* 主要负责Dart及Native的通信 */

#import <Foundation/Foundation.h>
#import <FairDynamicFlutter/FairDynamicFlutter.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "FairDefine.h"
#import <Flutter/FlutterPlugin.h>

/// Flutter 调用 Native 的类型
typedef NS_ENUM(NSUInteger, K_FLUTTER_TO_NATIVE_TYPE) {
    /// 注入数据
    K_FLUTTER_TO_NATIVE_TYPE_INJECTIONDATA,
    /// 调用JS方法
    K_FLUTTER_TO_NATIVE_TYPE_EXCUTEJS,
};

@class FlutterBasicMessageChannel;

@protocol FairDartBridgeExecuteJS <NSObject>

/// 释放JS页面
- (void)disposePage:(NSString *)pageName;

/// 注入JS
- (void)injectionJSScriptWtihJSScript:(NSString *)JSScript callback:(FairCallback)callBack;

/// 异步执行JS
- (void)executeJSFunctionAsync:(NSString *)functionName params:(NSArray *)params callback:(FairCallback)callBack;

/// 同步执行JS
- (JSValue *)executeJSFunctionSync:(NSString *)functionName params:(NSArray *)params;

@end

@interface FairDartBridge : NSObject<FAIRFFIProtocol>

@property (nonatomic, weak) id<FairDartBridgeExecuteJS> delegate;

/// 单例
FairSingletonH();

/// 通过channel像dart传输数据
- (void)sendMessageToDart:(NSString *)message callback:(FairCallback)callback;

/// 设置channel
- (void)setDartChannelWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;

@end
