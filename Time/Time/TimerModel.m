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
    
    Timer *pizza = [[Timer alloc] init];
    pizza.timerName = @"Pizza";
    pizza.countDownDuration = 60;
    [self.timers addObject:pizza];
    
    Timer *fish = [[Timer alloc] init];
    fish.timerName = @"Fish";
    fish.countDownDuration = 120;
    [self.timers addObject:fish];
    
    Timer *cupcake = [[Timer alloc] init];
    cupcake.timerName = @"Cupcake";
    cupcake.countDownDuration = 120;
    [self.timers addObject:cupcake];
    
    Timer *eggs = [[Timer alloc] init];
    eggs.timerName = @"Eggs";
    eggs.countDownDuration = 180;
    [self.timers addObject:eggs];
    
    Timer *cookie = [[Timer alloc] init];
    cookie.timerName = @"Cookie";
    cookie.countDownDuration = 240;
    [self.timers addObject:cookie];
    
    Timer *cake = [[Timer alloc] init];
    cake.timerName = @"Cake";
    cake.countDownDuration = 300;
    [self.timers addObject:cake];
    
    
    
}


@end
