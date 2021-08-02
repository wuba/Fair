/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import <Foundation/Foundation.h>

@interface NSObject (FairExtented)

/// 实现传入多参数
- (id)performSelector:(SEL)selector onThread:(NSThread *)thr waitUntilDone:(BOOL)wait withObjects:(id)object,...;

@end

/// 用于判断接受非空对象的类
@interface FairEndMark : NSObject

+ (instancetype)end;

@end
