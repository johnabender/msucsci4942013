//
//  MSuLocationManager.h
//  PubCrawl
//
//  Created by John Bender on 4/6/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MSuLocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

+(MSuLocationManager*) locationManager;

-(void) startMonitoringRegions;

@end
