//
//  TimerModel.m
//  Time
//
//  Created by Shena Yoshida on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerModel.h"

@implementation TimerModel


- (StopTimer *)startTimer:(double)interval {
    
    self.timer = (StopTimer *)[NSTimer timerWithTimeInterval:interval target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];   // this lets you access your current timer run loop
    return  self.timer;
    
}

- (void)timerFired:(StopTimer *)timer {
   
    timer.timerData = @"rick";
}






@end
