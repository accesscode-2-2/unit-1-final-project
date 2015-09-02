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
    [self.timers addObject:eggs];
    
    Timer *vegetables = [[Timer alloc] init];
    vegetables.timerName = @"Stir Fry Vegetables";
    vegetables.countDownDuration = 300;
    [self.timers addObject:vegetables];
    
    Timer *fish = [[Timer alloc] init];
    fish.timerName = @"Teriyaki Salmon";
    fish.countDownDuration = 600;
    [self.timers addObject:fish];
    
    Timer *cookie = [[Timer alloc] init];
    cookie.timerName = @"Chocolate Cookies";
    cookie.countDownDuration = 720;
    [self.timers addObject:cookie];
    
    Timer *turkey = [[Timer alloc] init];
    turkey.timerName = @"Roast Turkey";
    turkey.countDownDuration = 3900;
    [self.timers addObject:turkey];
    
    
    //    Timer *cupcake = [[Timer alloc] init];
    //    cupcake.timerName = @"Banana Cupcakes";
    //    cupcake.countDownDuration = 1200;
    //    [self.timers addObject:cupcake];
    //
    //    Timer *pizza = [[Timer alloc] init];
    //    pizza.timerName = @"Frozen Pizza";
    //    pizza.countDownDuration = 1500;
    //    [self.timers addObject:pizza];
    //
    //    Timer *cake = [[Timer alloc] init];
    //    cake.timerName = @"Birthday Cake";
    //    cake.countDownDuration = 1800;
    //    [self.timers addObject:cake];
    
    
}



@end
