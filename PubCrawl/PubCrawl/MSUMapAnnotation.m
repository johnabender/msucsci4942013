//
//  MSUMapAnnotation.m
//  PubCrawl
//
//  Created by John Bender on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUMapAnnotation.h"

@implementation MSUMapAnnotation

-(id) initWithBarDict:(NSDictionary*)dict
{
   self = [super init];
   if( self ) {
      barDict = dict;
   }
   return self;
}


-(NSString*)title
{
   return [barDict objectForKey:@"name"];
}


-(NSString*)subtitle
{
   return @"a bar";
}


-(CLLocationCoordinate2D) coordinate
{
   return ((CLLocation*)[barDict objectForKey:@"location"]).coordinate;
}

@end
