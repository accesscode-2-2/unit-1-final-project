//
//  TimerViewController.m
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/22/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "TimerViewController.h"
#import "AppDelegate.h"

@interface TimerViewController ()

@property (nonatomic) NSTimeInterval countDownInterval;
@property (nonatomic) NSTimeInterval totalSessionTime;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) int countDownDuration;
@property (nonatomic) int afterRemainder;
@property (nonatomic) int remainder;

@end

@implementation TimerViewController

- (IBAction)startTimer:(id)sender {
    if(!self.timer){
        self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        self.startime = [[NSDate alloc] init];
    }
}

- (IBAction)pauseTimer:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
}

// timer not starting from when reset
- (IBAction)resetTimer:(id)sender {
    if (sender == self.resetButton) {
        self.timerLabel.text = @"00:00:00";
        [self.timer invalidate];
        
    }
}

- (void) updateCountDown {
    //countdowntime = countdowntime - 1
    self.afterRemainder --;
    
    int hours = (int)(self.afterRemainder/(60*60));
    int mins = (int)(((int)self.afterRemainder/60) - (hours * 60));
    int secs = (int)(((int)self.afterRemainder - (60 * mins) - (60 * hours * 60)));
    NSString *displayTime = [NSString stringWithFormat:@"%02d: %02d: %02d", hours, mins, secs];
    
    self.timerLabel.text = displayTime ;
}



- (void)timerFired:(NSTimer *)timer {
    
    NSDate *now = [[NSDate alloc] init];
    
    self.countDownInterval = [now timeIntervalSinceDate:self.startTime];
    NSTimeInterval distance =  self.totalTime + self.totalSessionTime;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    NSLog(@"%f", distance);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



@end

