//
//  StopWatchTabBarController.m
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchTabBarController.h"
#import "TimerModel.h"
#import "StopTimer.h"

@interface StopWatchTabBarController ()
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@end

@implementation StopWatchTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerIsRunning = NO; // timer is inactive when view loads
    self.timerLabel.text = @"0"; // set timer to start at 0
    

//    TimerModel *timerModel= [[TimerModel alloc] init];
//    StopTimer *newTimer = [timerModel startTimer:0.01];
    
}

- (void) timerFired:(NSTimer *)timer { // start timer
    
    float currentNumber = [self.timerLabel.text floatValue]; // get integer value of string each time timer is fired
    float nextNumber = currentNumber +.01; // add to present time
    self.timerLabel.text = [NSString stringWithFormat:@"%.2f", nextNumber]; // set time to label text
    
    if (nextNumber)
        NSLog(@"timer fired"); // display each time a number is generated
    
}

- (void)stopTimer { // stop timer
    [self.timer invalidate];

}

- (void)startTimer {
    self.timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];   // this lets you access your current timer run loop
    
- (IBAction)buttonTapped:(id)sender {
        //IBAction *tapped =
        NSLog(@"button tapped"); // test it!
//        
//        if (self.timerIsRunning) {
//            self.timerIsRunning = NO;
//            [self stopTimer];
//        } else {
//            self.timerIsRunning = YES;
//            [self startTimer];
//        }
    
}
}

@end
