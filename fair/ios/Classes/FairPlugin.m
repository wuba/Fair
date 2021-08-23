/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

#import "FairPlugin.h"
#import "FairProcessManager.h"

@implementation FairPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"fair"
                                           binaryMessenger:[registrar messenger]];
    FairPlugin* instance = [[FairPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    [[FairProcessManager sharedInstance] startFairProcessWithRegistrar:registrar];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  result(FlutterMethodNotImplemented);
}

@end
