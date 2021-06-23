//
//  FairJSExportProtocol.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/7.


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
