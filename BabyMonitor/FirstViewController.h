//
//  FirstViewController.h
//  BabyMonitor
//
//  Created by Al Pascual on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioUnit/AudioUnit.h>

#import <AudioToolbox/AudioServices.h>

#import "SessionManager.h"
//#import "GADBannerView.h"
#import "MeterView.h"
#import "SoundManager.h"
#import "SoundDelegate.h"
#import "SCListener.h"
#import "HelpView.h"


@interface FirstViewController : UIViewController <SoundDelegate>{

    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    
    UIProgressView *progress;
    UIButton *startButton;
    //GADBannerView *bannerView_;
    MeterView *voltmeterView;
    SoundManager *sound;
}

@property (nonatomic,retain) IBOutlet UIProgressView *progress;
@property (nonatomic,retain) IBOutlet UIButton *startButton;
@property (nonatomic, retain) IBOutlet MeterView *voltmeterView;
@property (nonatomic,retain) SoundManager *sound;

-(IBAction) startMonitoring;
-(void) makeTheCall:(NSInteger)type;
- (IBAction)pressedHelp:(id)sender;

@end
