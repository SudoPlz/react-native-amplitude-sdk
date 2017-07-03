#import "AmplitudeSDK.h"
#import "Amplitude-iOS/Amplitude.h"
#import "AMPRevenue.h"

@implementation AmplitudeSDKiOS

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initialize:(NSString* )writeKey)
{
  [Amplitude instance].trackingSessionEvents = YES;
  [[Amplitude instance] initializeApiKey: writeKey];
}

RCT_EXPORT_METHOD(setUserId:(NSString *)userId)
{
  [[Amplitude instance] setUserId:userId];
}

RCT_EXPORT_METHOD(setUserProperties:(NSDictionary *)properties)
{
  [[Amplitude instance] setUserProperties:properties];
}

RCT_EXPORT_METHOD(logEvent:(NSString *)event)
{
  [[Amplitude instance] logEvent: event];
}

RCT_EXPORT_METHOD(logEventWithProps:(NSString *)eventKey properties:(NSDictionary *)properties)
{
  [[Amplitude instance] logEvent: eventKey withEventProperties: properties];
}

RCT_EXPORT_METHOD(logRevenue:(NSString *)productIdentifier quantity:(int)quantity price:(double)price receipt:(NSString*)receipt)
{
  AMPRevenue *revenue = [[[AMPRevenue revenue] setProductIdentifier:productIdentifier] setQuantity: quantity];
  [revenue setPrice:[NSNumber numberWithDouble:price]];
  [revenue setReceipt:[receipt dataUsingEncoding:NSUTF8StringEncoding]];
  [[Amplitude instance] logRevenueV2:revenue];
}

@end
