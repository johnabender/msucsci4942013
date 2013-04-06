//
//  MSuViewController.m
//  PubCrawl
//
//  Created by John Bender on 4/6/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "MSuViewController.h"
#import <MapKit/MapKit.h>
#import "MSUBarLocations.h"
#import "MSUMapAnnotation.h"

@interface MSuViewController () <MKMapViewDelegate>
{
    __weak IBOutlet MKMapView *mapView;
}

@end

@implementation MSuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    MKCoordinateSpan span;
    span.longitudeDelta = 0.005;
    span.latitudeDelta = 0.005;

    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:47. longitude:-122.];

    MKCoordinateRegion region;
    region.span = span;
    region.center = currentLocation.coordinate;
    mapView.region = region;

    mapView.centerCoordinate = currentLocation.coordinate;
    mapView.showsUserLocation = TRUE;
    mapView.userTrackingMode = MKUserTrackingModeFollow;

    NSArray *barLocations = [MSUBarLocations barLocations];
    for( NSDictionary *bar in barLocations ) {
        MSUMapAnnotation *annotation = [[MSUMapAnnotation alloc] initWithBarDict:bar];
        [mapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
