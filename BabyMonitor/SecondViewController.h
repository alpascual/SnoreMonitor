//
//  SecondViewController.h
//  BabyMonitor
//
//  Created by Al Pascual on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"

//#import "GADBannerView.h"

@interface SecondViewController : UIViewController {
    
    UISlider *sensitiveProgress;
    //GADBannerView *bannerView_;
}

@property (nonatomic,retain) IBOutlet UISlider *sensitiveProgress;

- (IBAction) savePressed;

@end
