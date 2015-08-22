//
//  StopWatchTabBarController.m
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchTabBarController.h"

@interface StopWatchTabBarController ()


@end

@implementation StopWatchTabBarController

float timeTick = 0.00; // the timer always begins at this number
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerDisplay.text = [[NSString alloc] initWithFormat:@"%.2f",timeTick];
   
}

- (void)tick { // the timer loop will run this method each time it is initiated, it advances the number
    
    float currentNumber = [self.timerDisplay.text floatValue]; // get float value of string each time timer is fired
    float nextNumber = currentNumber +.01; // add 0.01 to present time
    self.timerDisplay.text = [NSString stringWithFormat:@"%.2f", nextNumber]; // set time to label text
}

- (IBAction)startPauseButton:(id)sender {
    [timer invalidate]; // timer doesn't double time each time button is pressed.
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    if (self.timerIsRunning) {
        self.timerIsRunning = NO;
        [timer invalidate];
        
        
    } else {
        self.timerIsRunning = YES;
    }
}
@end
