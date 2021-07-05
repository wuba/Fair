//
//  FairDartModel.h
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/18.
//

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
