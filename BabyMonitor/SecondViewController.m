//
//  SecondViewController.m
//  BabyMonitor
//
//  Created by Al Pascual on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController

@synthesize sensitiveProgress;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set phone number and progress here
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"phone"] != nil )
    {       
        NSString *sensitiveTemp = [myPrefs stringForKey:@"sensitive"];
        
        [self.sensitiveProgress setValue:[sensitiveTemp floatValue]];
        
    }
    
    // Create a view of the standard size at the bottom of the screen.
    /*bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            0.0,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a14e2275b5b8cc7";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];*/
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}



/*-(void) viewWillDisappear:(BOOL)animated {
    //---removes the notifications for keyboard---
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillShowNotification 
     object:nil];
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillHideNotification 
     object:nil];
}*/

- (IBAction) savePressed
{
    //---removes the notifications for keyboard---
    /*[[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillShowNotification 
     object:nil];
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillHideNotification 
     object:nil];*/
    
    // Save
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    
    NSString *progressText = [[NSString alloc] initWithFormat:@"%f", self.sensitiveProgress.value];
    
    [myPrefs setObject:progressText forKey:@"sensitive"];
        
    //SessionManager *sharedSessionManager = [SessionManager sharedSessionManager];
    //sharedSessionManager.singletonString = self.phoneNumber.text;
    
    [self resignFirstResponder];
 
    [self.sensitiveProgress resignFirstResponder];
    [self resignFirstResponder];
    
    NSArray *arrWindows = [[UIApplication sharedApplication] windows];
    if ([arrWindows count] > 1) {
        UIWindow *keyboardWindow = [arrWindows objectAtIndex:1];
        [keyboardWindow setHidden:YES];
    }
}

@end
