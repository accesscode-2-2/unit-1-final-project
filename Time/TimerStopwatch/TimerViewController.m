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

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval countDownInterval;
@property (nonatomic) int countDownDuration;
@property (nonatomic) int afterRemainder;
@property (nonatomic) int remainder;

@end

@implementation TimerViewController

- (void) updateCountDown {
    //countdowntime = countdowntime - 1
    self.afterRemainder --;
    
    int hours = (int)(self.afterRemainder/(60*60));
    int mins = (int)(((int)self.afterRemainder/60) - (hours * 60));
    int secs = (int)(((int)self.afterRemainder - (60 * mins) - (60 * hours * 60)));
    NSString *displayTime = [NSString stringWithFormat:@"%02d: %02d: %02d", hours, mins, secs];
   
    
    self.displayTimer.text = displayTime ;
}

- (IBAction)startButton:(id)sender {
    
    if(!self.timer){
    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes] ;
    }//self.countDownInterval = self.countDownTimer - self.countDownDuration;
    //self.remainder = self.countDownInterval;
    //self.afterRemainder = self.countDownInterval - self.remainder%60;
    self.afterRemainder = 600;
    //NSLog(@"%lf", tota);
    self.startime = [[NSDate alloc] init];
    
}

- (IBAction)pauseButton:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)timerReset:(id)sender {
    if (sender == self.timerReset) {
        [self.timer invalidate];
    }
}

@end

