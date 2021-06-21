//
//  FairDynamicJSPlugin.h
//  FairDynamicFlutter
//
//  Created by 单鹏涛 on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <FairDynamicFlutter/FairDynamicFlutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface FairDynamicJSPlugin : NSObject <FlutterPlugin>

/// JS方法通道
@property (nonatomic, strong) FlutterBasicMessageChannel *jsFlutterBasicMessageChannel;

/// binaryMessenger
@property (nonatomic, weak) NSObject<FlutterBinaryMessenger> *binaryMessenger;

@end

NS_ASSUME_NONNULL_END
