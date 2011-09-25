//
//  SoundManager.h
//  Geography Tutor
//
//  Created by Al Pascual on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>


@interface SoundManager : NSObject {

	NSMutableArray *sndQueue;
	BOOL bPlaying;
	UIImageView *overlay;
}

@property(nonatomic, retain) NSMutableArray *sndQueue;
@property(nonatomic, retain) UIImageView *overlay;

- (void) LoadSound:(NSString*)pathSound:(NSString*)ofType;
- (void)LoadRandomSound:(NSString*)pathSound:(NSString*)ofType;

-(id)init;

-(id)initWithArray:(NSMutableArray *)arraySound;

-(void)addSoundToQueue:(NSString*)snd;

-(NSString*)getSoundFromQueue;

-(void)playQueue;
@end
