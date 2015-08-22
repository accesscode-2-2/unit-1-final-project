//
//  TimerViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController
@synthesize timerLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timerLabel.text = @"10.00.00.000";
    countDown = FALSE;
    
}
- (IBAction)timerStartButton:(id)sender {
    countDown = TRUE; 
    timer = [NSTimer scheduledTimerWithTimeInterval:-1.0/10.0
                                                 target:self
                                               selector:@selector(beginTimer)
                                               userInfo:nil
                                                repeats:YES];

    
    }

- (IBAction)timerStopButton:(id)sender {
    countDown = FALSE;
    [timer invalidate];
    timer = nil;
    
}

- (void)beginTimer {
    NSDate *currentTime = [NSDate date];
    
    NSTimeInterval timeInterval = [currentTime timeIntervalSinceDate:startTime];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timerString=[dateFormatter stringFromDate:timerDate];
    timerLabel.text = timerString;
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
