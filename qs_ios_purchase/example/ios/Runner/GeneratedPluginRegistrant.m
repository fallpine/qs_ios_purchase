//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<integration_test/IntegrationTestPlugin.h>)
#import <integration_test/IntegrationTestPlugin.h>
#else
@import integration_test;
#endif

#if __has_include(<qs_ios_purchase/QsIosPurchasePlugin.h>)
#import <qs_ios_purchase/QsIosPurchasePlugin.h>
#else
@import qs_ios_purchase;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [IntegrationTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntegrationTestPlugin"]];
  [QsIosPurchasePlugin registerWithRegistrar:[registry registrarForPlugin:@"QsIosPurchasePlugin"]];
}

@end
