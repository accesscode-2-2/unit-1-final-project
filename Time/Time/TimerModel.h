//
//  TimerModel.h
//  Time
//
//  Created by Shena Yoshida on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StopTimer.h"


@interface TimerModel : NSObject

@property (nonatomic) StopTimer *timer;
//@property (nonatomic) float currentTimeInSeconds;
//@property (nonatomic) float savedTime;
//@property (nonatomic) BOOL timerIsRunning;
- (StopTimer *)startTimer:(double)interval;
@end
