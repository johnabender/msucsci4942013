//
//  Assignment_5ViewController.m
//  Assignment5
//
//  Created by Andrew Wilson on 2/28/13.
//  Copyright (c) 2013 Andrew Wilson. All rights reserved.
//

// The list of variables should be read from the server, not hard-coded.
// And why are you using NSUserDefaults? The data are coming from the server, not
// from disk.
// No date picker.
// No text view.
// No display of weather data.
// 25%

#import "Assignment_5ViewController.h"


@interface Assignment_5ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak IBOutlet UIActivityIndicatorView *spinner;
    __weak IBOutlet UIPickerView *picker;
    __weak IBOutlet UITextView *textView;
}

@end

@implementation Assignment_5ViewController

@synthesize weatherVariable;
@synthesize pageControl;
@synthesize imageView1, imageView2;
@synthesize valuesText;

NSMutableArray *weather;
NSMutableArray *weatherValues;

NSString *weatherVariableSelected;
NSString *valueVariable;
                                         
static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

-(IBAction)doneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    //---initialize the first imageview to display an image---
    [imageView1 setImage:[UIImage imageNamed: @"sun.jpeg"]];
    tempImageView = imageView2;
    
    //---make the first imageview visible and hide the second---
    [imageView1 setHidden:NO];
    [imageView2 setHidden:YES];
    
    //---add the event handler for the page control---
    [pageControl addTarget:self
                    action:@selector(pageTurning:)
          forControlEvents:UIControlEventValueChanged];
    
    //---create a weather values array---
    weatherValues = [[NSMutableArray alloc] init];
    
    //---create an array containing the weather values---
    weather = [[NSMutableArray alloc] init];
    
    prevPage = 0;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    
    [self performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(IBAction)buttonClicked:(id)sender {
    //---add the view of the view controller to the current view-
    if(export==nil)
    {
        export = [[Export alloc] initWithNibName:@"Export" bundle:nil];
    }
    [self.view addSubview:export.view];
}

//---when the page control's value is changed---
- (void) pageTurning: (UIPageControl *) pageController {
    //---get the page number you can turn to---
    NSInteger nextPage = [pageController currentPage];
    switch(nextPage) {
        case 0:
            [tempImageView setImage:
             [UIImage imageNamed:@"sun.jpeg"]];
            break;
        case 1:
            [tempImageView setImage:
             [UIImage imageNamed:@"snowing.jpeg"]];
            break;
        case 2:
            [tempImageView setImage:
             [UIImage imageNamed:@"cloud.jpeg"]];
            break;
        default:
            break;
            
    }
    
    //---switch the two imageview views---
    if(tempImageView.tag == 0) { //---imageView1---
        tempImageView = imageView2;
        bgImageView = imageView1;
    }
    else {
        //---imageView2---
        tempImageView = imageView1;
        bgImageView = imageView2;
    }
    
    UIViewAnimationOptions transitionOption;
    
    if(nextPage > prevPage)
        //---if moving from left to right---
        transitionOption = UIViewAnimationOptionTransitionFlipFromLeft;
    else
        //---if moving from right to left---
        transitionOption = UIViewAnimationOptionTransitionFlipFromRight;
    
    //---animate by flipping the images---
    [UIView transitionWithView:tempImageView
                      duration:2.5
                       options:transitionOption
                    animations:^{
                        [tempImageView setHidden:YES];
                    }completion:NULL];
    
    [UIView transitionWithView:bgImageView
                      duration:2.5
                       options:transitionOption
                    animations:^{
                        [tempImageView setHidden:NO];
                    }completion:NULL];
    
    prevPage = nextPage;
}


//---Number of components in the Picker View---
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//---number of items(rows) in the picker View---
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"%u", [weather count]);
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

//--Refreshing the weather picker---
-(void) refreshWeather
{
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    if( [json length] == 0 ) {
        NSLog( @"server returned nothing" );
        return;
    }
    
    NSError* error = nil;
    id collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }
    
    NSMutableDictionary *currentForecast = [NSMutableDictionary new];
    for(NSDictionary *variable in collections ) {
        NSLog(@"%@", variable[@"variable"]);
        NSLog(@"%@", variable[@"values"]);
        [weatherValues addObject:variable[@"values"]];
        [weather addObject:variable[@"variable"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:currentForecast];
}


-(void) weatherRefreshed:(NSNotification*)note
{
    [spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [picker reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadValues:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    valuesText.text = [defaults objectForKey:@"valuesText"];
    
    //---find the index of the array for the weather saved---
    weatherVariableSelected = [[NSString alloc] initWithString:
                               [defaults objectForKey:@"weatherVariable"]];
    int se1Index = [weather indexOfObject:weatherVariableSelected];
    
    //---find the index of the array for the weather saved---
    valueVariable = [[NSString alloc] initWithString:
                               [defaults objectForKey:@"valueVariable"]];
    int setIndex2 = [weatherValues indexOfObject:valueVariable];
    
    //---display the saved values in the textView---
    weatherValues = [weatherValues valueForKey:@"valueVariable"];
    valuesText.text = [weatherValues objectAtIndex:setIndex2];
    
    //---display the saved color in the Picker view---
    [weatherVariable selectRow:se1Index inComponent:0 animated:YES];
    
}

//---number of items(rows) in the text View---
- (NSInteger) textView:(UITextView *)textView numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"%u", [weather count]);
    return [weather count];
}
//---the item selected by the user---
- (void) textView:(UITextView *)textView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    weatherVariableSelected = [weather objectAtIndex:row];
}

- (IBAction)saveValues:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:valuesText.text forKey:@"valuesText"];
    [defaults setObject:weatherVariableSelected forKey:@"weather"];
    [defaults synchronize];
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Values Saved"
                               message:@"Congratz, your app doesn't work"
                              delegate:nil
                     cancelButtonTitle:@"Done"
                     otherButtonTitles:nil];
    [alert show];
}
@end
