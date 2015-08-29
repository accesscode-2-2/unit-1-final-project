//
//  TimedLaps.m
//  StopWatch
//
//  Created by MacMan on 8/28/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//




#import "TimedLaps.h"

@interface TimedLaps ()

@end



@implementation TimedLaps
@synthesize timedLaps = _timedLaps;


-(id)initWithName:(NSString *)timedLaps {
    self = [super init];
    
    if (self){
        self.timedLaps = timedLaps;

        
    }
    
    return self;
    
}




@end
