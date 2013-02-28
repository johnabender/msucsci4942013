//
//  Assignment_5ViewController.m
//  Assignment5
//
//  Created by Andrew Wilson on 2/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

#import "Assignment_5ViewController.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

@interface Assignment_5ViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@end

@implementation Assignment_5ViewController

@synthesize name;
@synthesize password;
@synthesize weatherVariable;
NSMutableArray *weather;
NSString *weatherVariableSelected;

-(IBAction)doneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    //---create an array containing the weather values---
    weather = [[NSMutableArray alloc] init];
    [weather addObject:@"crainsfc"];
    [weather addObject:@"csnowsfc"];
    [weather addObject:@"apcpsfc"];
    [weather addObject:@"tmax2m"];
    [weather addObject:@"tmin2m"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    
    [self performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//---Number of components in the Picker View---
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//---number of items(rows) in the picker View---
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [weather count];
}

//---populating the picker view---
- (NSString *) pickerView:(UIPickerView *)pickerView
              titleForRow:(NSInteger)row
             forComponent:(NSInteger)component {
    return [weather objectAtIndex:row];
}

//---the item selected by the user---
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    weatherVariableSelected = [weather objectAtIndex:row];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadValues:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    name.text = [defaults objectForKey:@"name"];
    password.text = [defaults objectForKey:@"password"];
    
    //---find the index of the array for the color saved---
    weatherVariableSelected = [[NSString alloc] initWithString:
                               [defaults objectForKey:@"weatherVariable"]];
    int se1Index = [weather indexOfObject:weatherVariableSelected];
    
    //---display the saved color in the Picker view---
    [weatherVariable selectRow:se1Index inComponent:0 animated:YES];
    
}

- (IBAction)saveValues:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name.text forKey:@"name"];
    [defaults setObject:password.text forKey:@"password"];
    [defaults setObject:weatherVariableSelected forKey:@"weather"];
    [defaults synchronize];
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Values Saved"
                               message:@"Values Saved"
                              delegate:nil
                     cancelButtonTitle:@"Done"
                     otherButtonTitles:nil];
    [alert show];
}
@end
