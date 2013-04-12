//
//  IPViewController.m
//  imagepicker-demo
//
//  Created by John Bender on 4/12/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "IPViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "UIImage+GeneralResize.h"


typedef enum {
    ImagePickerModePhoto,
    ImagePickerModeVideo
} ImagePickerMode;


@interface IPViewController ()
{
    ImagePickerMode imagePickerMode;
}

-(IBAction) pressedCaptureVideo;
-(IBAction) pressedCaptureImage;

@end

@implementation IPViewController

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

-(IBAction) pressedCaptureImage
{
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        BOOL cameraAvailable = NO;
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        for( NSString *mediaType in availableMedia )
            if( [mediaType isEqualToString:(__bridge NSString*)kUTTypeImage] )
                cameraAvailable = YES;

        if( cameraAvailable )
        {
            UIImagePickerController *picker = [UIImagePickerController new];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = @[(__bridge NSString*)kUTTypeImage];
            picker.delegate = (id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)self;

            imagePickerMode = ImagePickerModePhoto;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else
            DLog( @"camera can't capture images" );
    }
    else
        DLog( @"no camera available" );
}

-(IBAction) pressedCaptureVideo
{
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        BOOL cameraAvailable = NO;
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        for( NSString *mediaType in availableMedia )
            if( [mediaType isEqualToString:(__bridge NSString*)kUTTypeMovie] )
                cameraAvailable = YES;

        if( cameraAvailable )
        {
            UIImagePickerController *picker = [UIImagePickerController new];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = @[(__bridge NSString*)kUTTypeMovie];
            picker.delegate = (id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)self;

            imagePickerMode = ImagePickerModeVideo;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else
            DLog( @"camera can't capture movies" );
    }
    else
        DLog( @"no camera available" );
}


#pragma mark - Image picker delegate

-(void) imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];

    switch( imagePickerMode ) {
        case ImagePickerModePhoto:
        {
            UIImage *img = info[UIImagePickerControllerOriginalImage];
            UIImage *thumbnail = [img resizedImage:CGSizeMake( 100., 100. )
                              interpolationQuality:kCGInterpolationDefault];
            NSData *imgData = UIImagePNGRepresentation( img );
            break;
        }
        case ImagePickerModeVideo:
        {
            NSURL *videoURL = info[UIImagePickerControllerMediaURL];
            UIImage *thumbnail = [self videoThumbnailForVideoURL:videoURL];
            NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
            break;
        }
    }
}



-(UIImage*) videoThumbnailForVideoURL:(NSURL*)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    CGImageRef i = [generator copyCGImageAtTime:CMTimeMake( 0, 1 ) actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:i];
    //CFRelease( i ); // crashes, otherwise I'd think we still own this object
    return [thumbnail resizedImage:CGSizeMake( 100., 100. )
              interpolationQuality:kCGInterpolationDefault];
}

@end
