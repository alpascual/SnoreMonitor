//
//  SoundManager.m
//  Geography Tutor
//
//  Created by Al Pascual on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"


@implementation SoundManager

@synthesize sndQueue;
@synthesize overlay;

- (void) LoadSound:(NSString*)pathSound:(NSString*)ofType
{

	/*SystemSoundID soundsID;
	
	//Path for our sound:
	//NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"my-sound" ofType:@"wav"];
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:pathSound ofType:ofType];
	CFURLRef soundURL = (CFURLRef)[NSURL fileURLWithPath:soundPath];
	AudioServicesCreateSystemSoundID(soundURL, &soundsID);
	
	AudioServicesPlaySystemSound(soundsID);
	
	[soundPath release];*/

	NSLog(@"Playing sound %@", pathSound);
	[self addSoundToQueue:pathSound];
	
	if ( bPlaying == NO )
	{
		bPlaying = YES;
		[self playQueue];
	}
	
}

- (void)LoadRandomSound:(NSString*)pathSound:(NSString*)ofType
{
	int ran = 0;
	ran = arc4random() % 4;
	
	NSString *path2 = [[NSString alloc] initWithFormat:@"%@%d", pathSound, ran];
		
	[self LoadSound:path2 :ofType];
	
	[path2 release];
}

-(id)init
{
	bPlaying = NO;
	if (self = [super init])
	{
		sndQueue = [[[NSMutableArray alloc] init] retain];
	}
	return self;
}

-(id)initWithArray:(NSMutableArray *)arraySound
{	
	self = [self init];
	if (self!=nil){
		[sndQueue addObjectsFromArray:arraySound];
	}
	
	return self;
}


-(void)addSoundToQueue:(NSString*)snd
{
	[sndQueue addObject:snd];
}

-(NSString*)getSoundFromQueue
{
	NSLog(@"entered getSoundFromQueue");
	if ( [sndQueue count] > 0 )
	{
        @synchronized(self) {
        
		if ( self.overlay.hidden == YES)
			self.overlay.hidden = NO;
		
		NSLog(@"%d sounds to play", [sndQueue count]);
		NSString* snd = nil;
		snd = [sndQueue objectAtIndex:0]; //1st sound
		[sndQueue removeObjectAtIndex:0]; 
		NSLog(@"returning sound from queue");
		return snd;
            
        }
	}
	else
	{
		NSLog(@"count is 0 returning Null");
		return NULL;
	}
}

void MyAudioServicesSystemSoundCompletionProc(SystemSoundID ssID, void *clientData)
{
	NSLog(@"Finished playing sounds");
	//cleanup
	//AudioServicesDisposeSystemSoundID(ssID);
	SoundManager *pSoundQueue = clientData;
	[pSoundQueue playQueue]; //it crashes here: EXC_BAD_ACCESS
}

-(void)playQueue
{
    @try {
	NSLog(@"Getting new sound from the queue");
    NSString *nextSound = [self getSoundFromQueue];
	NSLog(@"returned from getSoundFromQueue");
	if (nextSound != nil) { 
		NSLog(@"before playing sound %@", nextSound);
		
		nextSound = [nextSound stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSString *path = [[NSBundle mainBundle] pathForResource:[nextSound lowercaseString] ofType:@"wav"];
		SystemSoundID soundID;
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
			
		AudioServicesAddSystemSoundCompletion (soundID,NULL,NULL,MyAudioServicesSystemSoundCompletionProc, /*(void*)*/ self);
			AudioServicesPlaySystemSound (soundID);	
			
		NSLog(@"Playing sound from the queue %@", path);
			
		[path release];		
		
	}
	else
	{
		NSLog(@"Nothing to play");
		bPlaying = NO;
		self.overlay.hidden = YES; 
	}
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception looking for sound");
    }
    
}

- (void) dealloc
{
    [super dealloc];
    
	[sndQueue release];
}

@end
