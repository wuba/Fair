/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import <Foundation/Foundation.h>

/// Dart --> Native通信的数据源
@interface FairDartModel : NSObject

/// 参数
@property (nonatomic, strong) NSString *pageName;

/// 文件路径
@property (nonatomic, strong) NSString *path;

/// 字典转model
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
