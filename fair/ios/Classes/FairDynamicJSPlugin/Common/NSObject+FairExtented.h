//
//  NSObject+FairExtented.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/11.
//

#import <Foundation/Foundation.h>

@interface NSObject (FairExtented)

/// 实现传入多参数
- (id)performSelector:(SEL)selector onThread:(NSThread *)thr waitUntilDone:(BOOL)wait withObjects:(id)object,...;

@end

/// 用于判断接受非空对象的类
@interface FairEndMark : NSObject

+ (instancetype)end;

@end
