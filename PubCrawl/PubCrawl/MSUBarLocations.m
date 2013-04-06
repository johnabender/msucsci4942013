//
//  MSUBarLocations.m
//  drivingtest
//
//  Created by John Bender on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUBarLocations.h"

@implementation MSUBarLocations

+(NSDictionary*) barDictForName:(NSString*)name
{
   if( [name isEqualToString:@"The Baxter"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.679337 longitude:-111.039233], @"location",
              nil];
//    return {@"name": name,
//            @"location": [[CLLocation alloc] initWithLatitude:45.679337 longitude:-111.039233]};
   else if( [name isEqualToString:@"Plonk"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.679322 longitude:-111.035971], @"location",
              nil];
   else if( [name isEqualToString:@"Crystal"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.679352 longitude:-111.03492], @"location",
              nil];
   else if( [name isEqualToString:@"The Rocking R"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.679307 longitude:-111.033825], @"location",
              nil];
   else if( [name isEqualToString:@"The Zebra"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.679427 longitude:-111.032259], @"location",
              nil];
   else if( [name isEqualToString:@"Montana Ale Works"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.679367 longitude:-111.028161], @"location",
              nil];
   else if( [name isEqualToString:@"The Cat's Paw"] )
      return [NSDictionary dictionaryWithObjectsAndKeys:
              name, @"name",
              [[CLLocation alloc] initWithLatitude:45.687282 longitude:-111.0465471], @"location",
              nil];
   return nil;
}


+(NSArray*) barNames
{
   return [NSArray arrayWithObjects:@"The Baxter", @"Plonk", @"Crystal",
           @"The Rocking R", @"The Zebra", @"Montana Ale Works",
           @"The Cat's Paw", nil];
}


+(NSArray*) barLocations
{
   NSMutableArray *arr = [NSMutableArray array];
   for( NSString *name in [MSUBarLocations barNames] )
      [arr addObject:[MSUBarLocations barDictForName:name]];
   return [NSArray arrayWithArray:arr];
}


+(NSDictionary*) barDictNearestCoordinate:(CLLocationCoordinate2D)coordinate
{
   double nearestDist = 1000000.;
   NSDictionary *nearestDict = nil;
   for( NSDictionary *barDict in [MSUBarLocations barLocations] )
   {
      CLLocation *barLocation = [barDict objectForKey:@"location"];
      double thisDist = sqrt( (barLocation.coordinate.latitude - coordinate.latitude)*
                              (barLocation.coordinate.latitude - coordinate.latitude) +
                              (barLocation.coordinate.longitude - coordinate.longitude)*
                              (barLocation.coordinate.longitude - coordinate.longitude) );
      if( thisDist < nearestDist )
      {
         nearestDist = thisDist;
         nearestDict = barDict;
      }
   }
   return nearestDict;
}

@end
