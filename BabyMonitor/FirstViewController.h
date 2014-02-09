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

#import "SAMultisectorControl.h"


@interface FirstViewController : UIViewController <SoundDelegate>{

    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    
    UIProgressView *progress;
    UIButton *startButton;
    //GADBannerView *bannerView_;
    MeterView *voltmeterView;
    SoundManager *sound;
}

@property (nonatomic,strong) IBOutlet UIProgressView *progress;
@property (nonatomic,strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet MeterView *voltmeterView;
@property (nonatomic,retain) SoundManager *sound;
@property (strong, nonatomic) IBOutlet SAMultisectorControl *multisectorControl;
@property (strong, nonatomic) SAMultisectorSector *sector3;

-(IBAction) startMonitoring;
-(void) makeTheCall:(NSInteger)type;
- (IBAction)pressedHelp:(id)sender;

@end
