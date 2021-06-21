//
//  FairDefine.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/8.
//
//  管理常量及通用宏函数的定义
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
/// 调试状态
#define FairLog(formatString,...) NSLog(@"[Fair]:\n\tFile:%@, \n\tFunction:%s, \n\tLine:%d >>\n\t" formatString, [[NSString stringWithUTF8String:__FILE__] lastPathComponent] , __func__, __LINE__, ##__VA_ARGS__)
#else
/// 发布状态
#define FairLog(...)
#endif

/// 弱引用
#define FairWeakSelf(weakSelf) __weak typeof(self) weakSelf = self;
#define FairWeakObject(weakObj, obj) __weak typeof(obj) weakObj = obj;
/// 强引用
#define FairStrongObject(strongObj, obj) __strong typeof(obj) strongObj = obj;

/// h中的单例
#define FairSingletonH() + (instancetype)sharedInstance;
/// m中的单例，需要传入类
#define FairSingletonM(name) \
\
static id _FairInstance = nil;\
+ (instancetype)sharedInstance{\
    if (_FairInstance == nil) {\
        _FairInstance = [[self alloc] init]; \
    } \
    return _FairInstance; \
}\
+ (instancetype)allocWithZone:(NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _FairInstance = [super allocWithZone:zone];\
    });\
    return _FairInstance;\
}\
- (id)copyWithZone:(NSZone *)zone {\
    return [name sharedInstance];\
}\
- (id)mutableCopyWithZone:(NSZone *)zone {\
    return [name sharedInstance];\
}\

/// 字符串是否不空
#define FAIR_IS_NOT_EMPTY_STRING(string) (string != nil && [string isKindOfClass:[NSString class]] && ![string isKindOfClass:[NSNull class]] && ![@"" isEqualToString:string] && ![@"NULL" isEqualToString:[string uppercaseString]] && ![@"null" isEqualToString:string] && ![@"(null)" isEqualToString:string] && ![@"<null>" isEqualToString:string])

/// 字符串为空
#define FAIR_IS_EMPTY_STRING(string) !((string != nil && [string isKindOfClass:[NSString class]] && ![string isKindOfClass:[NSNull class]] && ![@"" isEqualToString:string] && ![@"NULL" isEqualToString:[string uppercaseString]] && ![@"null" isEqualToString:string] && ![@"(null)" isEqualToString:string] && ![@"<null>" isEqualToString:string] ))

/// 转换为安全字符串
#define FAIR_SAFE_STRING(string) ((string && (STRING_IS_NOT_EMPTY(string) || [string isKindOfClass:[NSNumber class]])) ? [NSString stringWithFormat:@"%@", string] : @"")

/// Dart -> Native 用来注入JS方法的通道
extern NSString * const FairMessageChannelInjectionID;

/// Dart -- > Native 用来注入JS的方法
extern NSString * const FairMessageChannelInjectionFunction;

/// Dart -- > Native 用来注入JS的业务代码
extern NSString * const FairMessageChannelLoadJSFileType;

/// Dart -> Native 用来执行JS方法的通道
extern NSString * const FairMessageChannelExecuteID;

/// Dart -- > JS  用来执行JS的方法
extern NSString * const FairExecuteJSFunction;

/// Dart -- > Native 同步调用JS的方法
//extern NSString * const FairSyncExecuteJSFunction;

/// Dart -- > Native 调用方法的类型
extern NSString * const FairMessageChannelMethodType;

/// JS函数调用的线程
extern NSString * const FairJSThreadName;

/// JS 更新 Dart
extern NSString * const FairUpdateDartFunction;

/// JS 异步调用 Dart
extern NSString * const FairExecuteDartFunctionAsync;

/// JS 同步调用 Dart 
extern NSString * const FairExecuteDartFunctionSync;


/// 结果回调
typedef void (^FairCallback)(id result, NSError *error);

@interface FairDefine : NSObject


@end
