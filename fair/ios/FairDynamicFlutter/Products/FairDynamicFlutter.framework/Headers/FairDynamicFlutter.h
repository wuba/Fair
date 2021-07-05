//
//  FairDynamicFlutter.h
//  FairDynamicFlutter
//
//  Created by 单鹏涛 on 2021/5/12.
//

#import <Foundation/Foundation.h>

#if defined(__cplusplus)
#define FAIR_FFI_EXTERN extern "C" __attribute__((visibility("default"))) __attribute__((used))
#else
#define FAIR_FFI_EXTERN extern __attribute__((visibility("default"))) __attribute__((used))
#endif

/// 使用dart:ffi，实现dart->js的同步调用

/// 同步属性回调
FAIR_FFI_EXTERN const char *invokeJSCommonFuncSync(char *args);

/// FFI协议
@protocol FAIRFFIProtocol <NSObject>

/// 同步属性调用
/// @param args 参数
- (const char *)executeScriptSyncImpl:(char *)args;

@end

@interface FairDynamicFlutter : NSObject

@property (nonatomic, weak) id<FAIRFFIProtocol> delegate;

+ (instancetype)sharedInstance;

@end
