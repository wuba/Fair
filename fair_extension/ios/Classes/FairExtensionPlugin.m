#import "FairExtensionPlugin.h"
#if __has_include(<fair_extension/fair_extension-Swift.h>)
#import <fair_extension/fair_extension-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fair_extension-Swift.h"
#endif

@implementation FairExtensionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFairExtensionPlugin registerWithRegistrar:registrar];
}
@end
