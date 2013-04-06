//
//  MSUMapAnnotation.h
//  PubCrawl
//
//  Created by John Bender on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MSUMapAnnotation : NSObject <MKAnnotation>
{
   NSDictionary *barDict;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

-(id) initWithBarDict:(NSDictionary*)dict;

@end
