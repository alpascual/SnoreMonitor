//
//  SessionManager.h
//  BabyMonitor
//
//  Created by Albert Pascual on 6/22/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SessionManager : NSObject {
    NSString *singletonString;
	
}

@property (nonatomic,retain) NSString *singletonString;  

+ (SessionManager*) sharedStateInstance;
@end
