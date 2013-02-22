//
//  WJViewController.m
//  weather-json
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "WJViewController.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";


@interface WJViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];

    [self performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


-(void) refreshWeather
{
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    if( [json length] == 0 ) {
#if DEBUG
        NSLog( @"using fake data..." );
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fake-data" ofType:@"json"];
        json = [NSData dataWithContentsOfFile:filePath];
#else
        NSLog( @"server returned nothing" );
        return;
#endif
    }

    NSError* error = nil;
    id collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];

    if (error)
    {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }

    NSMutableDictionary *currentForecast = [NSMutableDictionary new];
    for( NSDictionary *variable in collections ) {
        //NSArray *predictions = [EWWeatherPrediction newWeatherPredictionsFromDictionary:variable];
        //currentForecast[variable[@"variable"]] = predictions;
        NSLog( @"%@", variable[@"variable"] );
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:currentForecast];
}


-(void) weatherRefreshed:(NSNotification*)note
{
    [spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
