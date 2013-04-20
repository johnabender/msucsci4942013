//
//  ARViewController.m
//  ar-demo
//
//  Created by John Bender on 4/19/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "ARViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>

static const CGFloat tileSize = 100.;
static const CGFloat tileSpacing = 100.;
static const CGFloat sphereSize = 640.; // arbitrary units

@interface ARViewController ()
{
    AVCaptureSession *captureSession;
    CMMotionManager *motionManager;
    NSTimer *motionTimer;

    __weak IBOutlet UILabel *label;
}
@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // add tiles
    for( NSInteger x = -sphereSize; x < sphereSize + self.view.frame.size.width; x += tileSize + tileSpacing ) {
        for( NSInteger y = -sphereSize; y < sphereSize + self.view.frame.size.height; y += tileSize + tileSpacing ) {
            CGRect frame = CGRectMake( x, y, tileSize, tileSize );
            UIView *v = [[UIView alloc] initWithFrame:frame];
            CGFloat r = (x + sphereSize)/(self.view.frame.size.width + 2.*sphereSize);
            CGFloat g = 1.;
            CGFloat b = (y + sphereSize)/(self.view.frame.size.height + 2.*sphereSize);
            v.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.8];
            v.layer.cornerRadius = tileSize/2.;
            [self.view addSubview:v];
        }
    }

    // find camera
    AVCaptureDevice *cameraDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *currentVideoInput = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:nil];

    // start capture session
    captureSession = [AVCaptureSession new];
    [captureSession addInput:currentVideoInput];
    [captureSession startRunning];

    // make camera preview layer
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];

    // initialize motion manager
    motionManager = [CMMotionManager new];
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical];

    // start animation timer
    motionTimer = [NSTimer scheduledTimerWithTimeInterval:1./30.
                                                   target:self
                                                 selector:@selector(motionTimer:)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [captureSession stopRunning];
    captureSession = nil;

    [motionManager stopDeviceMotionUpdates];
    motionManager = nil;

    [motionTimer invalidate];
    motionTimer = nil;
}


-(void) motionTimer:(NSTimer*)timer
{
    CMDeviceMotion *motion = motionManager.deviceMotion;
    label.text = [NSString stringWithFormat:@"y=%.3f\np=%.3f\nr=%.3f", motion.attitude.yaw, motion.attitude.pitch, motion.attitude.roll];

    for( UIView *v in self.view.subviews ) {
        if( [v class] == [UIView class] ) {
            v.layer.transform = CATransform3DMakeTranslation( sphereSize*motion.attitude.roll, sphereSize*motion.attitude.pitch, 0. );
            //v.layer.transform = CATransform3DMakeRotation( motion.attitude.pitch, 1., 0., 0. );
        }
    }
}

@end
