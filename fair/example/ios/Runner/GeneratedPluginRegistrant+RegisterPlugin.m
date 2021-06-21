//
//  GeneratedPluginRegistrant+RegisterPlugin.m
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/5/17.
//

#import "GeneratedPluginRegistrant+RegisterPlugin.h"
#include <objc/message.h>
//#import "FairDynamicJSPlugin.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

@implementation GeneratedPluginRegistrant (RegisterPlugin)

+ (void)load {
    
    Method originalMethod = class_getClassMethod(self.class, @selector(registerWithRegistry:));
    Method customMethod = class_getClassMethod(self.class, @selector(customRegisterWithRegistry:));
    method_exchangeImplementations(originalMethod, customMethod);
}


+ (void)customRegisterWithRegistry:(NSObject<FlutterPluginRegistry>*)registrar {
    
    Class class = NSClassFromString(@"FairDynamicJSPlugin");
    SEL sel =NSSelectorFromString(@"registerWithRegistrar:");
    if ([class respondsToSelector:sel]) {
        SuppressPerformSelectorLeakWarning(
                                           [class performSelector:sel withObject:[registrar registrarForPlugin:@"FairDynamicJSPlugin"]];
        );
    }
    [self customRegisterWithRegistry:registrar];
}


@end
