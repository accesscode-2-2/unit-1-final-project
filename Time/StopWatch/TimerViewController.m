//
//  TimerViewController.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/31/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *startCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *endTime;
@property (nonatomic) NSTimeInterval totalTime;

@property (nonatomic) BOOL isRunning;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.datePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
                                [UIDatePicker
                                 instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:self.datePicker];
    
    self.isRunning = NO;
    
    self.datePicker.countDownDuration = 60.0;
    self.countdownLabel.alpha = 0;
    
}


- (IBAction)startButtonTapped:(id)sender {
    
    if (!self.isRunning) {
        self.totalTime = self.datePicker.countDownDuration;
        [self startTimer];
    }
    
}

- (IBAction)stopButtonTapped:(id)sender {
    
    if ([self isRunning]) {
        [self stopTimer];
    }
    
}

- (void)timerFired:(NSTimer *)timer {
    
    self.totalTime--;
    
    self.countdownLabel.text = [NSString stringWithFormat:@"%@", [self formattedTime:self.totalTime]];

    if (self.totalTime == 0) {
        
        [self stopTimer];
    }
}

-(void)startTimer {
    self.isRunning = YES;
    self.datePicker.alpha = 0;
    self.countdownLabel.alpha = 1;
    self.countdownLabel.textColor = [UIColor whiteColor];
    
//    self.countdownLabel.text = [NSString stringWithFormat:[self.datePicker date]];

    
   self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

}

- (void)stopTimer {
    
    self.isRunning = NO;
    self.datePicker.alpha = 1;
    self.countdownLabel.alpha = 0;

    [self.timer invalidate];
}
-(NSString *)formattedTime: (NSTimeInterval) timeInterval {
    int totalHundredths = timeInterval * 100;
    int hours = totalHundredths / 360000;
    int minutes = (totalHundredths - (hours * 360000)) / 6000;
    int seconds = (totalHundredths - (hours * 360000) - (minutes * 6000)) / 100;
    int milliseconds = totalHundredths - (hours * 360000) - (minutes * 6000) - (seconds * 100);
    
    
    //Potetial for creating a lap
    NSString *displayTime = [NSString stringWithFormat:@"%02d:%02d:%02d",minutes,seconds,milliseconds];
    return displayTime;
}




@end
