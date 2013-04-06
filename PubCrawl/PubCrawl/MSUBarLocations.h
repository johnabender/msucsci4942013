//
//  MSUBarLocations.h
//  drivingtest
//
//  Created by John Bender on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface MSUBarLocations : NSObject

+(NSArray*) barLocations;
+(NSDictionary*) barDictNearestCoordinate:(CLLocationCoordinate2D)coordinate;

@end
