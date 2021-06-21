//
//  FairDartModel.m
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/18.
//

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
