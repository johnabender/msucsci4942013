//
//  MSuLocationManager.m
//  PubCrawl
//
//  Created by John Bender on 4/6/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "MSuLocationManager.h"
#import "MSUBarLocations.h"

static const CGFloat barLocationRadiusMeters = 25.;

static MSuLocationManager *instance = nil;

@implementation MSuLocationManager

+(MSuLocationManager*) locationManager
{
    if( instance == nil )
        instance = [MSuLocationManager new];
    return instance;
}


-(id) init
{
    self = [super init];
    if( self ) {
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        locationManager.purpose = @"Never miss a bar again!";

        [self startLocationServices];
    }
    return self;
}


-(void) startLocationServices
{
	BOOL result = YES;

	if (locationManager.location == nil)
	{
		NSLog(@"location is nil");
		result = NO;
	}
	else if (![CLLocationManager locationServicesEnabled])
	{
		NSLog(@"location services not enabled");
		result = NO;
	}
	else if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized)
	{
		NSLog(@"location services not authorized");
		result = NO;
	}

	if (!result)
	{
		[locationManager startUpdatingLocation];
	}
}


-(void) startMonitoringRegions
{
    // see whether this is going to work
    BOOL monitoring = NO;
    if ( [CLLocationManager regionMonitoringAvailable] ) {
        if ( [CLLocationManager regionMonitoringEnabled] ) {
            if( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized ) {
                monitoring = YES;
            } else {
                NSLog( @"app is not authorized for location monitoring" );
            }
        } else {
            NSLog( @"region monitoring is not enabled" );
        }
    } else {
        NSLog( @"region monitoring is not available" );
    }
    if( !monitoring ) return;
    NSLog( @"starting region monitoring" );

    NSArray *barLocations = [MSUBarLocations barLocations];
    for( NSDictionary *bar in barLocations ) {
        CLLocation *barLocation = bar[@"location"];
        NSString *barName = bar[@"name"];

        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:barLocation.coordinate
                                                                   radius:barLocationRadiusMeters
                                                               identifier:barName];

        [locationManager startMonitoringForRegion:region
                                  desiredAccuracy:kCLLocationAccuracyBest];
    }
}


#pragma mark - Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //NSLog( @"location updated" );
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog( @"location manager failed: %@", error );
}


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog( @"entered region %@", region );
    NSDictionary *barDict = [MSUBarLocations barDictNearestCoordinate:region.center];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"barNearby" object:barDict];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
}

- (void)   locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
                 withError:(NSError *)error
{
    NSLog( @"region monitoring failed for region %@: %@", region, error );
    [locationManager stopMonitoringForRegion:region];
}
@end
