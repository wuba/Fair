/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import "NSObject+FairExtented.h"

@implementation NSObject (FairExtented)

- (id)performSelector:(SEL)selector onThread:(NSThread *)thr waitUntilDone:(BOOL)wait withObjects:(id)object,...
{
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    if (signature == nil) {
       NSLog(@"--- 使用实例方法调用 为nil ---");
       signature = [self methodSignatureForSelector:selector];
       if (signature == nil) {
           NSLog(@"使用类方法调用 也为nil， 此时return");
           return nil;
       }
    }
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    // 设置调用方法
    [invocation setSelector:selector];
    // 设置参数
    NSUInteger argCount = signature.numberOfArguments;
    // 参数必须从第2个索引开始，因为前两个已经被target和_cmd使用
    argCount = argCount > 2 ? argCount - 2 : 0;

    va_list args;
    va_start (args, object);
    int index = 0;
    // 这种方式暂时屏蔽
//    [invocation setArgument:&object atIndex:index + 2];
//    for (int i = 1; i < argCount; i++) {
//        id tmpObject = va_arg(args, id);
//        [invocation setArgument:&tmpObject atIndex:i + 2];
//    }
    for (id tmpObject = object; (id)tmpObject != [FairEndMark end]; tmpObject = va_arg(args, id)) {
        // 防止越界
        if (index >= argCount) break;
        // 去掉self,_cmd所以从2开始
        [invocation setArgument:&tmpObject atIndex:index + 2];
        index++;
    }
    va_end (args);
    
    // 保存对象
    [invocation retainArguments];
    

    if ([thr isMainThread]) {
        // 主线程时可以返回值，否则不支持
        [invocation invoke];
        
        //获取返回值
         id returnValue = nil;
         if (signature.methodReturnLength != 0 && signature.methodReturnLength) {
            [invocation getReturnValue:&returnValue];
         }
        
         return returnValue;
    }
    else {
        [invocation performSelector:@selector(invoke) onThread:thr withObject:nil waitUntilDone:wait];
    }
    
    return nil;
}

@end

@implementation FairEndMark

+ (instancetype)end {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}

@end
