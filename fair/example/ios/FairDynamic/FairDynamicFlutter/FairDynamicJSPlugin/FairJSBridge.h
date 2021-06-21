//
//  FairJSBridge.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/7.
//
//  主要负责JS及Native的通信
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
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
/// @param jsScript            如 funtion test(a){…} 则需传入 test(a) 或 fuction test(a){…}
/// @param callback            执行完成的回调，可为空
- (void)evaluateScriptWithJSScriptAsync:(NSString *)jsScript callback:(FairCallback)callback;

/// 同步注入到Native的JS的某段代码或逻辑
/// @param jsFilePath      JS文件的路径
- (JSValue *)evaluateScriptWithJSFileSync:(NSString *)jsFilePath;

/// 同步注入到Native的JS的某段代码或逻辑
/// @param jsScript            如 funtion test(a){…} 则需传入 test(a) 或 fuction test(a){…}
/// @return              返回值可为空
- (JSValue *)evaluateScriptWithJSScriptSync:(NSString *)jsScript;

#pragma mark -  执行JS某个方法

/// 异步调用JS的某个方法
/// @param functionName     如  funtion test(a){…} 则需要传入 test
/// @param callback              回调可为空
- (void)invokeJSFuctionAsync:(NSString *)functionName params:(NSArray *)params callback:(FairCallback)callback;

/// 同步调用JS的某个方法
/// @param functionName     如  funtion test(a){…} 则需要传入 test
/// @return              返回值可为空
- (JSValue *)invokeJSFuctionSync:(NSString *)functionName params:(NSArray *)params;

@end
