//
//  FairJSExportProtocol.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/7.


#import <Foundation/Foundation.h>
#import "FairDefine.h"

/// JS相关协议
@protocol FairJSExportDelegate <NSObject>

/**
 JS 异步调用 Dart
 */
- (void)FairExecuteDartFunctionAsync:(NSDictionary *)dic callBack:(FairCallback)callback;

/**
 JS 同步调用 Dart
 */
- (void)FairExecuteDartFunctionSync:(NSDictionary *)dic;

@end


@interface FairJSExportProtocol : NSObject

@end
