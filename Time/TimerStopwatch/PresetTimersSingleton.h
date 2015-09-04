//
//  PresetTimersSingleton.h
//  TimerStopwatch
//
//  Created by Bereket  on 9/2/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresetTimersSingleton : NSObject

@property (nonatomic) NSMutableArray *presetTimersArray;

+ (instancetype)sharedInstance;

@end
