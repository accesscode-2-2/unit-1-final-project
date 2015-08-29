//
//  TimerData.m
//  Time
//
//  Created by Felicia Weathers on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerData.h"

@implementation TimerData

- (void)setUpPresetData {
    
    self.presets = [[NSMutableArray alloc]init];
    
    TimerData *cardio = [[TimerData alloc]init];
    cardio.nameOfTimer = @"Cardio";
    cardio.presetTime = @30.00;
    
    TimerData *strengthTraining = [[TimerData alloc]init];
    strengthTraining.nameOfTimer = @"Strength Training";
    strengthTraining.presetTime = @45.00;
    
    TimerData *yoga = [[TimerData alloc]init];
    yoga.nameOfTimer = @"Yoga";
    yoga.presetTime = @90.00;
    
}
@end
