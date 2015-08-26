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
        NSLog(@"%f", self.countDownTimer.countDownDuration);
        self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        self.startTime = [[NSDate alloc] init];
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

- (void) updateCountDown:(NSTimer *)timer {
    self.afterRemainder --;
    
    NSInteger hours = self.afterRemainder /3600;
    NSInteger mins = (self.afterRemainder%3600)/60;
    NSInteger secs = ((self.afterRemainder%3600)%60)%60;
    
    NSString *hoursToBeShown = [NSString stringWithFormat:@"%d",hours];
    NSString *minutesToBeShown = @"";
    NSString *secondsToBeShown = @"";
    
    if (mins < 10 && mins !=0)
        minutesToBeShown = [NSString stringWithFormat:@"0%ld", (long)mins];
    else if (mins == 0)
        mins = @"00";
    else (mins = [NSString stringWithFormat:@"%ld", (long)mins]);
    
    if (secs < 10 && secs !=0)
        secondsToBeShown = [NSString stringWithFormat:@"0%ld", (long)secs];
    else if (secs == 0)
        secs = @"00";
    else ( secs = [NSString stringWithFormat:@"%ld", (long)secs]);
    
}

- (void)timerFired:(NSTimer *)timer {
    
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.startTime];
    NSTimeInterval distance =  self.totalTime + self.totalSessionTime;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    NSLog(@"%f", distance);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countDownTimer.datePickerMode = UIDatePickerModeCountDownTimer;
    self.countDownTimer.countDownDuration = 60;
}



@end
