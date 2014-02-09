//
//  FirstViewController.m
//  BabyMonitor
//
//  Created by Al Pascual on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController

@synthesize progress, startButton, voltmeterView;
@synthesize sound;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //UIColor *greenColor = [UIColor colorWithRed:29.0/255.0 green:207.0/255.0 blue:0.0 alpha:1.0];
//    UIColor *redColor = [UIColor colorWithRed:245.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
//    
//    self.sector3 = [SAMultisectorSector sectorWithColor:redColor maxValue:100.0];
//   
//    self.sector3.tag = 2;
//    self.sector3.endValue = 1.0;
// 
//    [self.multisectorControl addSector:self.sector3];
    
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
    
    // Old monitor
    self.voltmeterView.textLabel.text = @"Snore";
	self.voltmeterView.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:18.0];
	self.voltmeterView.lineWidth = 2.5;
	self.voltmeterView.minorTickLength = 5;
	self.voltmeterView.needle.width = 1.0;
	self.voltmeterView.textLabel.textColor = [UIColor colorWithRed:0.7 green:1.0 blue:1.0 alpha:1.0];
    self.voltmeterView.maxNumber = 10.0;
    
    self.voltmeterView.value = 0;
    
    //self.sound = [[SoundManager alloc] init];
    
}

- (void)levelTimerCallback2:(NSTimer *)timer {

    double ave = [[SCListener sharedListener] averagePower];
    
    [progress setProgress:ave];
    self.voltmeterView.value = ave * 10;
    self.sector3.endValue = ave * 10;
    
    
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"sensitive"] != nil )
    {
        NSString *tempSensitive = [myPrefs stringForKey:@"sensitive"];
        float sensitiveFloat = [tempSensitive floatValue];
        if ( sensitiveFloat < ave)
        {
            //TODO 
            NSLog(@"Baby voice detected with sensitive"); 
            [self makeTheCall:2];
        }
        if (ave > 0.65)
        {
            //TODO 
            NSLog(@"Baby voice detected");
            [self makeTheCall:1];
        }
    }
	if (ave > 0.65)
    {
        //TODO 
		NSLog(@"Baby voice detected");
        [self makeTheCall:1];
    }

}
- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
	
    
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
	double lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
    
    NSLog(@"Result: %f Average input: %f Peak input: %f", lowPassResults, [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
    
    // top 0.050000
    // buttom 0.009000
    
    lowPassResults = lowPassResults * 16;
    if ( lowPassResults > 9.0 )
        lowPassResults = lowPassResults - 10;
    
    NSLog(@"Now lowPassResult is: %f", lowPassResults);
    
    [progress setProgress:lowPassResults];
    self.voltmeterView.value = lowPassResults * 10;
    
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"sensitive"] != nil )
    {
        NSString *tempSensitive = [myPrefs stringForKey:@"sensitive"];
        float sensitiveFloat = [tempSensitive floatValue];
        if ( sensitiveFloat < lowPassResults)
        {
            //TODO 
            NSLog(@"Baby voice detected with sensitive"); 
            [self makeTheCall:2];
        }
        if (lowPassResults > 0.65)
        {
            //TODO 
            NSLog(@"Baby voice detected");
            [self makeTheCall:1];
        }
    }
	if (lowPassResults > 0.65)
    {
        //TODO 
		NSLog(@"Baby voice detected");
        [self makeTheCall:1];
    }
}

// Calling here
-(void) makeTheCall:(NSInteger)type
{
    SCListener *listener = [SCListener sharedListener];
    
    // We can temporarily stop returning levels
    [listener pause];
    
    
    /*NSString *phoneTemp = nil;
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"phone"] != nil )
         phoneTemp = [myPrefs stringForKey:@"phone"];
    else
    {
        SessionManager *sharedSessionManager = [SessionManager sharedSessionManager];
        phoneTemp = sharedSessionManager.singletonString;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneTemp]]];
     
     */
    
    // Buzz or make a sound here: TODO
    if ( type == 1 )
    {
        //buzz
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        //levelTimer = [NSTimer scheduledTimerWithTimeInterval: timeInterval target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        // Sounds
        int ran = arc4random() % 4;
        
        if ( ran == 3 )
            [self.sound addSoundToQueue:@"final"];
        
        else
            [self.sound addSoundToQueue:@"first"];
        
        [self.sound playQueue];
    }
    
    [listener listen]; // Quick.
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



-(IBAction) startMonitoring
{
    if ( [self.startButton.titleLabel.text isEqualToString:@"Start Monitoring"] )
    {
        self.startButton.titleLabel.text = @"Stop Monitoring";
        [self.startButton setTitle: @"Stop Monitoring" forState: UIControlStateNormal];
        [self.startButton setTitle: @"Stop Monitoring" forState: UIControlStateApplication];
        [self.startButton setTitle: @"Stop Monitoring" forState: UIControlStateHighlighted];
        [self.startButton setTitle: @"Stop Monitoring" forState: UIControlStateReserved];
        [self.startButton setTitle: @"Stop Monitoring" forState: UIControlStateSelected];
        [self.startButton setTitle: @"Stop Monitoring" forState: UIControlStateDisabled];
        
        /*NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                  nil];
        
        NSError *error;
        
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
        if (recorder) {
            [recorder prepareToRecord];
            recorder.meteringEnabled = YES;
            [recorder record];
            levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        } else
            NSLog(@"Error ");
         */
        
        [[SCListener sharedListener] listen];
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback2:) userInfo: nil repeats: YES];
    }
    else
    {
        /*if (recorder)
        {
            [levelTimer invalidate];
            //[levelTimer release];
            [recorder stop];
            [recorder release];
        }
          */
        
        self.startButton.titleLabel.text = @"Start Monitoring";
        [self.startButton setTitle: @"Start Monitoring" forState: UIControlStateNormal];
        [self.startButton setTitle: @"Start Monitoring" forState: UIControlStateApplication];
        [self.startButton setTitle: @"Start Monitoring" forState: UIControlStateHighlighted];
        [self.startButton setTitle: @"Start Monitoring" forState: UIControlStateReserved];
        [self.startButton setTitle: @"Start Monitoring" forState: UIControlStateSelected];
        [self.startButton setTitle: @"Start Monitoring" forState: UIControlStateDisabled];
                
        [levelTimer invalidate];
        
        SCListener *listener = [SCListener sharedListener];
        
               
        // Or free up resources when we're not listening for awhile.
        [listener stop];
        
    }
}

- (IBAction)pressedHelp:(id)sender
{
    HelpView *help = [[HelpView alloc] initWithNibName:@"HelpView" bundle:nil];
    
    help.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    [self presentModalViewController:help animated:YES];
}

@end
