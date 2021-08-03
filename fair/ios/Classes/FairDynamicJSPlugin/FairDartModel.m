/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import "FairDartModel.h"

@implementation FairDartModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (dic && [dic isKindOfClass:[NSDictionary class]]) {
            self.pageName = [dic objectForKey:@"pageName"] ? : @"";
            self.path = [dic objectForKey:@"path"] ? : @"";
        }
        
    }
    return self;
}

@end
