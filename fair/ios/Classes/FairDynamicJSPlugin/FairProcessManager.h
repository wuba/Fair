//
//  FairProcessManager.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/8.
//
//  Fair通信流程管理类
//

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

