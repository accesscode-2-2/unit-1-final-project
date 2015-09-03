//
//  PresetTimer.h
//  TimerStopwatch
//
//  Created by Bereket  on 9/2/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresetTimer : NSObject

@property (nonatomic) NSString* timerName;
@property (nonatomic) NSTimer* timer;
@property (nonatomic) NSTimeInterval timeInterval;

@property (nonatomic) NSInteger hours;
@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger seconds;
@end
