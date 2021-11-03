/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import "FairJSBridge.h"
#import "FairJSExportProtocol.h"
#import "NSObject+FairExtented.h"

@interface FairJSBridge ()

/// JS上下文
@property (nonatomic, strong) JSContext *context;

/// 用于处理JS通信的线程
@property (nonatomic, strong) NSThread *jsThread;

@end

@implementation FairJSBridge

FairSingletonM(FairJSBridge)
- (instancetype)init {
    if (self = [super init]) {
//        self.jsExportDelegate = [FairJSBridge sharedInstance];
    }
    return self;
}

#pragma mark -  执行JS注入到Native

- (void)evaluateScriptWithJSFileAsync:(NSString *)jsFilePath callback:(FairCallback)callback
{
    NSString *jsString = [self obtainJSScriptWithJSFile:jsFilePath];
    [self evaluateScriptWithJSScriptAsync:jsString callback:callback];
}

- (void)evaluateScriptWithJSScriptAsync:(NSString *)jsScript callback:(FairCallback)callback
{
    if (!jsScript) {
        return;
    }
    
    if ([NSThread currentThread] != self.jsThread) {
        [self performSelector:@selector(evaluateScript:callback:) onThread:self.jsThread waitUntilDone:NO withObjects:jsScript, callback, [FairEndMark end]];
    }
    else {
        [self evaluateScript:jsScript callback:callback];
    }
}

- (JSValue *)evaluateScriptWithJSFileSync:(NSString *)jsFilePath
{
    NSString *jsScript = [self obtainJSScriptWithJSFile:jsFilePath];
    return [self evaluateScriptWithJSScriptSync:jsScript];
}

- (JSValue *)evaluateScriptWithJSScriptSync:(NSString *)jsScript
{
    if (!jsScript) {
        return nil;
    }
    
    return [self evaluateScript:jsScript callback:nil];
}

- (JSValue *)evaluateScript:(NSString *)jsScript callback:(FairCallback)callback
{
    JSValue *jsValue = [self.context evaluateScript:jsScript];
    if (callback) {
        callback(jsValue, nil);
    }
    return jsValue;
}

#pragma mark -  执行JS某个方法

- (void)invokeJSFunctionAsync:(NSString *)functionName params:(NSArray *)params callback:(FairCallback)callback
{
    if ([NSThread currentThread] != self.jsThread) {

        [self performSelector:@selector(invokeJSFunctionOnJSThread:params:callback:) onThread:self.jsThread waitUntilDone:NO withObjects:functionName, params, callback, [FairEndMark end]];
    }
    else {
        [self invokeJSFunctionOnJSThread:functionName params:params callback:callback];
    }
}

- (JSValue *)invokeJSFunctionSync:(NSString *)functionName params:(NSArray *)params
{
    return [self invokeJSFunctionOnJSThread:functionName params:params callback:nil];
}

- (JSValue *)invokeJSFunctionOnJSThread:(NSString *)functionName params:(NSArray *)params callback:(FairCallback)callback
{
    JSValue *jsValue = self.context[functionName];
    
    JSValue *value = [jsValue callWithArguments:params];

    if (callback) {
        callback(value, nil);
    }
    return value;
}

#pragma mark -  通过JSValue直接执行这个JS方法

- (void)invokeJSFunction:(JSValue *)function param:(id)param
{
    if (!function || !param) {
        FairLog(@"数据异常,无法执行：%@-%@", function, param);
        return;
    }
    NSArray *params;
    if (FAIR_IS_NOT_EMPTY_STRING(param)) {
        params = @[param];
    }
    else if ([param isKindOfClass:[NSArray class]]) {
        params = param;
    }
    else {
        params = @[];
    }
    
    if ([NSThread currentThread] != self.jsThread) {

        [self performSelector:@selector(invokeJSFunctionOnJSThread:params:) onThread:self.jsThread waitUntilDone:NO withObjects:function, params, [FairEndMark end]];
    }
    else {
        [self invokeJSFunctionOnJSThread:function params:params];
    }

}

- (JSValue *)invokeJSFunctionOnJSThread:(JSValue *)function params:(NSArray *)params
{
    JSValue *value = [function callWithArguments:params];
    return value;
}

#pragma mark -  释放

- (void)disposePage:(NSString *)pageName
{
    if (FAIR_IS_NOT_EMPTY_STRING(pageName)) {
        self.context[pageName] = nil;
    }
}

#pragma mark - Other Method

/// 通过JS文件获取JS脚本字符串
- (NSString *)obtainJSScriptWithJSFile:(NSString *)jsFilePath
{
    NSString *jsPath;
    if ([jsFilePath containsString:@"."]) {
        jsPath = [[NSBundle mainBundle] pathForResource:jsFilePath
                                                 ofType:nil];
    }
    else {
        jsPath = [[NSBundle mainBundle] pathForResource:jsFilePath
                                                 ofType:@"js"];

    }
    NSError *error = nil;
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    if (error) {
        FairLog(@"js加载出错：%@", error.description);
        return nil;
    }
    
    return jsString;
}

/// 任意类型数据转换为字符串
- (NSString *)convertStringWithData:(id)data
{
    NSString *result;
    if ([data isKindOfClass:[NSDictionary class]] || [data isKindOfClass:[NSArray class]]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
        if (error) {
            result = @"";
        }
        else {
            result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] ;
        }
    }
    else if ([data isKindOfClass:[NSString class]]) {
        result = data;
    }
    else {
        result = @"";
    }
    return result;
}

/// 线程保活
- (void)runRunLoopThread {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        [runLoop run];
    }
}

#pragma mark - get

- (JSContext *)context {
    if (!_context) {
        _context = [[JSContext alloc] init];
        
        // 打印异常
        _context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
        {
            context.exception = exceptionValue;
            FairLog(@"exceptionValue:%@", exceptionValue);
        };
        
        /**
         * 以 block 形式关联 JavaScript function
         */
        // 打印日志 - JS
        _context[@"console"][@"log"] = ^(JSValue *value)
        {
            FairLog(@"%@", value);
        };

        // 打印日志 - Dart
        _context[@"print"] = ^(JSValue *value)
        {
            FairLog(@"%@", value);
        };
        
        // 调试用，注意：js的alert会阻塞进程，导致卡住OC的主线程，所以拦截alert进行原生弹窗
        _context[@"alert"] = ^(NSString *str) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
            });
        };
        
        FairWeakSelf(weakSelf);
        
        // JS 异步调用 Dart
        _context[FairExecuteDartFunctionAsync] = ^(id receiver, JSValue *callback) {
            FairStrongObject(strongSelf, weakSelf)
            
            NSString *data = [strongSelf convertStringWithData:receiver];
            if ([strongSelf.delegate respondsToSelector:@selector(FairExecuteDartFunctionAsync:callback:)]) {
                [strongSelf.delegate FairExecuteDartFunctionAsync:data callback:callback];
            }
        };
        
        // JS 同步调用 Dart
        _context[FairExecuteDartFunctionSync] = ^(id receiver, JSValue *callback) {
            FairStrongObject(strongSelf, weakSelf)
            
            NSString *data = [strongSelf convertStringWithData:receiver];
            if ([strongSelf.delegate respondsToSelector:@selector(FairExecuteDartFunctionSync: callback:)]) {
                [strongSelf.delegate FairExecuteDartFunctionSync:data callback:callback];
            }
        };
    }
    return _context;
}

- (NSThread *)jsThread
{
    if (!_jsThread) {
        _jsThread = [[NSThread alloc] initWithTarget:[FairJSBridge sharedInstance] selector:@selector(runRunLoopThread) object:nil];
        _jsThread.name = FairJSThreadName;
        _jsThread.qualityOfService = NSOperationQualityOfServiceUserInteractive;
        [_jsThread start];
    }
    return _jsThread;
}

@end
