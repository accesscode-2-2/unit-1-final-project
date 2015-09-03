//
//  TimerModel.m
//  Time
//
//  Created by Xiulan Shi on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerModel.h"
#import "Timer.h"

@implementation TimerModel

+ (instancetype)sharedInstance {
    
    static TimerModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TimerModel alloc] init];
    });
    return sharedInstance;
    
}


- (void)initializeModel {
    
    self.timers = [[NSMutableArray alloc] init];
    
    Timer *eggs = [[Timer alloc] init];
    eggs.timerName = @"Poached Eggs";
    eggs.countDownDuration = 180;
    eggs.imageName = @"Poached Eggs";
    [self.timers addObject:eggs];
    
    Timer *vegetables = [[Timer alloc] init];
    vegetables.timerName = @"Stir Fry Vegetables";
    vegetables.countDownDuration = 300;
    vegetables.imageName = @"Stir Fry Vegetables";
    [self.timers addObject:vegetables];
    
    Timer *fish = [[Timer alloc] init];
    fish.timerName = @"Teriyaki Salmon";
    fish.countDownDuration = 600;
    fish.imageName = @"Teriyaki Salmon";
    [self.timers addObject:fish];
    
    Timer *cookie = [[Timer alloc] init];
    cookie.timerName = @"Delicious Cookies";
    cookie.countDownDuration = 720;
    cookie.imageName = @"Delicious Cookies";
    [self.timers addObject:cookie];
    
    Timer *turkey = [[Timer alloc] init];
    turkey.timerName = @"Roast Turkey";
    turkey.countDownDuration = 3900;
    turkey.imageName = @"Roast Turkey";
    [self.timers addObject:turkey];
    
    
}



@end
