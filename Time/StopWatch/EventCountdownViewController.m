//
//  EventCountdownViewController.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "EventCountdownViewController.h"

@interface EventCountdownViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (nonatomic) NSDate *demoDay;


@end

@implementation EventCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countdownLabel.text = [self.obj name];
    
    //start timer and display in label
    
    
    // create a date formatter so that you can create an NSDate
    // object from a string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
    
    // set the demo day property (NSDate) to the date "2015 09 03"
    self.demoDay = [formatter dateFromString:@"2015 09 03"];
    
//    self.countdownLabel.text = @"0";
    
    // create a new instance of NSTimer
    // equivalent of running [self timerFired] every 1.0 seconds
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    // make sure we add the new timer to the run loop so that it
    // executes
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    // set up a timer to fire once ever second
    NSTimer *demoDayTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fireDemoDayTimer:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)fireDemoDayTimer:(NSTimer *)timer {
    
    // get the current day and time
    NSDate *now = [[NSDate alloc] init];
    
    // calculate the amount of time between now and self.demoDay
    // in seconds
    NSTimeInterval timeLeft = [self.demoDay timeIntervalSinceDate:now];
    
    // this is where you would format the time and display it on
    // the screen
    NSLog(@"%f", timeLeft);
}

- (void)timerFired:(NSTimer *)timer {
    
    // get the current number from out text label
    NSInteger currentNumber = [self.countdownLabel.text integerValue];
    
    // create a variable that's pointing to the current number + 1
    NSInteger nextNumber = currentNumber - 1;
    
    // update the text label
    self.countdownLabel.text = [NSString stringWithFormat:@"%lu", nextNumber];
    
    // if the number is 10, invalidate the timer
    if (nextNumber == 0) {
        [timer invalidate];
    }
    
    NSLog(@"timer fired");
}

@end
