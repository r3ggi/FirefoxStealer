#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property CLLocationManager* locationManager;
@property CLLocationDegrees longtitude;
@property CLLocationDegrees latitude;

@end

NS_ASSUME_NONNULL_END
