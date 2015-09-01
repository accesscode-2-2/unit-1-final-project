//
//  TimerViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"
#import "PresetTimerTableViewController.h"

@interface TimerViewController ()

@property (nonatomic) NSInteger afterRemainder;
@property (nonatomic) NSInteger Remainder;
@property (nonatomic) NSTimeInterval countDownInterval;

@property (nonatomic) NSTimer *startTimer;
@property (nonatomic) NSTimer *pauseTimer;
@property (nonatomic) NSDate *previousTime;


@property (nonatomic) TimerData *presetInterval; //this is what i will pass to the preset view and then pass back once a preset timer is chosen


@property (nonatomic) BOOL running;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@end

@implementation TimerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.running = NO;
    self.Remainder = -1;
    
    self.presetInterval = [[TimerData alloc]init];
    self.presetInterval.presetTime = @00.00;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)updateTime {
    self.afterRemainder --;
    
    if (self.afterRemainder == -1) {
        [self invalidateTimer];
        
    }
    
    NSInteger hours = (NSInteger)(self.afterRemainder/(60*60));
    NSInteger minutes = (((NSInteger)self.afterRemainder/60) - (hours *60));
    NSInteger seconds = (((NSInteger)self.afterRemainder - (60 * minutes) - (60 * hours *60)));
    NSString *displayText = [[NSString alloc] initWithFormat: @"%02ld : %02ld : %02ld", (long)hours, (long)minutes, (long)seconds];
    self.countdownLabel.text = displayText;
}

- (IBAction)startCountdown:(id)sender {
    if(!self.running) {
        self.previousTime = [NSDate date];
        
        [self startTimer];
        self.running = NO;
        
    } else {
        
        [self pauseTimer];
        self.running = NO;
    }
    //    if (!self.running) {
    //
    //
    //        self.running = YES;
    //        NSLog(@"start button hit");
    //
    //        [sender setTitle:@"Pause" forState: UIControlStateNormal];
    //
    //
    //        if (self.Remainder == -1) {
    //            NSLog(@"start the timer");
    //            self.countDownInterval = (NSTimeInterval)_datePicker.countDownDuration;
    //            self.Remainder = self.countDownInterval;
    //            self.afterRemainder = self.countDownInterval - self.Remainder%60;
    //
    //            countdownTimer = [NSTimer timerWithTimeInterval:1
    //                                                     target:self
    //                                                   selector:@selector(updateTime)
    //                                                   userInfo:nil
    //                                                    repeats:YES];
    //            [[NSRunLoop currentRunLoop] addTimer:countdownTimer forMode:NSRunLoopCommonModes];
    //        }
    //
    //    } else {
    //        self.running = NO;
    //        [sender setTitle:@"Start" forState: UIControlStateNormal];
    //        [self invalidateTimer];
    //        NSLog(@"pause button hit");
    //    }
    //
}

- (void)startTimer {
    double timerInterval = 10.0;
    double timerElapsed = 0.0;
    NSDate *timerStarted;

    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:(timerInterval - timerElapsed) target:self selector:@selector(fired) userInfo:nil repeats:NO];
    timerStarted = [NSDate date];
}

-(void) fired {
    [countdownTimer invalidate];
    countdownTimer = nil;
    timerElapsed = 0.0;
    [self startTimer];
    // react to timer event here
}

//    [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
//    
//        if (self.Remainder == -1) {
//            NSLog(@"start the timer");
//            self.countDownInterval = (NSTimeInterval)_datePicker.countDownDuration;
//            self.Remainder = self.countDownInterval;
//            self.afterRemainder = self.countDownInterval - self.Remainder%60;
//    
//    countdownTimer = [NSTimer timerWithTimeInterval:1
//                                             target:self
//                                           selector:@selector(updateTime)
//                                           userInfo:nil
//                                            repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:countdownTimer forMode:NSRunLoopCommonModes];
//    
//        }
//}

- (void)pauseTimer {
    
    if(!self.running){
        self.running = TRUE;
        
        if (!self.running) {
            self.pauseTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                               target:self
                                                             selector:@selector(updateTime)
                                                             userInfo:nil
                                                              repeats:YES];
        }
    } else {
        
        self.running = NO;
        [self.pauseTimer invalidate];
        
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.restartButton setTitle:@"Reset" forState:UIControlStateNormal];
        
        [self.pauseTimer invalidate];
        self.pauseTimer = nil;
    }
}
- (void)invalidateTimer{
    
    if (countdownTimer != nil) {
        [countdownTimer invalidate];
        countdownTimer = nil;
    }
}


//reset not restart
- (IBAction)restartButton:(id)sender {
    self.running = NO;
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [countdownTimer invalidate];
    countdownTimer = nil;
    self.countdownLabel.text = @"00.00.00";
    [self.startTimer invalidate];
    
}

- (IBAction)presetButton:(id)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
    
    PresetTimerTableViewController *vc = (PresetTimerTableViewController *)[navController topViewController];
    
    vc.selectedPreset = self.presetInterval;
    
    
}

@end

