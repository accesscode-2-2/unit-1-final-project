//
//  PresetTimersSingleton.m
//  TimerStopwatch
//
//  Created by Bereket  on 9/2/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "PresetTimersSingleton.h"

@implementation PresetTimersSingleton

+ (instancetype)sharedInstance {
    static PresetTimersSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PresetTimersSingleton alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _presetTimersArray = [NSMutableArray new];
    }
    return self;
}


@end
