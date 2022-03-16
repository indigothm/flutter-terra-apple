#import "TerraAppleHealthPlugin.h"
#if __has_include(<terra_apple_health/terra_apple_health-Swift.h>)
#import <terra_apple_health/terra_apple_health-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "terra_apple_health-Swift.h"
#endif

@implementation TerraAppleHealthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTerraAppleHealthPlugin registerWithRegistrar:registrar];
}
@end
