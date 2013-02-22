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

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(void) refreshWeather
{
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    if( [json length] == 0 ) {
#if DEBUG
        DLog( @"using fake data..." );
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fake-data" ofType:@"json"];
        json = [NSData dataWithContentsOfFile:filePath];
#else
        ALog( @"server returned nothing" );
        return;
#endif
    }

    NSError* error = nil;
    id collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];

    if (error)
    {
        ALog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }

    NSMutableDictionary *currentForecast = [NSMutableDictionary new];
    for( NSDictionary *variable in collections ) {
        //NSArray *predictions = [EWWeatherPrediction newWeatherPredictionsFromDictionary:variable];
        //currentForecast[variable[@"variable"]] = predictions;
        DLog( @"%@", variable[@"variable"] );
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:currentForecast];
}


@end
