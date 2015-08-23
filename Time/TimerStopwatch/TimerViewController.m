//
//  TimerViewController.m
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/22/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "TimerViewController.h"
#import "AppDelegate.h"

@interface TimerViewController () {
    
    int afterRemainder;
    int remainder;
    
    // why won't it read whatever is in the .h file?
    NSTimer *timer;
    
    NSTimeInterval countDownInterval;
}

@end

// WHY DOES IT KEEP GOING FASTER AND FASTER?! I ADDED [TIMER INVALIDATE]; !!!!

@implementation TimerViewController

- (void) updateCountDown {
    //countdowntime = countdowntime - 1
    afterRemainder --;
    
    int hours = (int)(afterRemainder/(60*60));
    int mins = (int)(((int)afterRemainder/60) - (hours * 60));
    int secs = (int)(((int)afterRemainder - (60 * mins) - (60 * hours * 60)));
    NSString *displayTime = [[NSString alloc] initWithFormat:@"%02u: %02u: %02u", hours, mins, secs];
    [timer invalidate];
    
    self.displayTime.text = displayTime;
}

- (IBAction)startButton:(id)sender {
    countDownInterval = (NSTimeInterval)_countDownTimer.countDownDuration;
    remainder = countDownInterval;
    afterRemainder = countDownInterval - remainder%60;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    
    self.startime = [[NSDate alloc] init];
    [timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pause:(id)sender {
    [self pauseLayer:self.view.layer];
}

- (IBAction)timerReset:(id)sender {
    if (sender == self.timerReset) {
        [timer invalidate];
    }
}

- (void) pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTimer = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 1.0;
    layer.timeOffset = pausedTimer;
    [timer invalidate];
}

@end

