//
//  TimerTabBarController.m
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerTabBarController.h"

@interface TimerTabBarController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;
@property (nonatomic) BOOL isTimerRunning;
@property (nonatomic) BOOL isPaused;
@property (weak, nonatomic) IBOutlet UIImageView *animatedPicture; // added for animation

@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;

@property (nonatomic) int secondsCount;

@property (nonatomic) NSTimer *timer;

@end

@implementation TimerTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isTimerRunning = NO;
    self.isPaused = NO;
    self.pauseResumeButton.enabled = NO;
}

- (void)animationSetup { // added method so you can start/stop animation anywhere in timer state
    
    self.animatedPicture.animationImages = [NSArray arrayWithObjects:
                                           //[UIImage imageNamed:@"ticker1.png"],
                                           [UIImage imageNamed:@"ticker2.png"],
                                           [UIImage imageNamed:@"ticker3.png"],
                                           [UIImage imageNamed:@"ticker4.png"],
                                           // [UIImage imageNamed:@"ticker5.png"],
                                           [UIImage imageNamed:@"ticker6.png"],
                                           [UIImage imageNamed:@"ticker7.png"],
                                           [UIImage imageNamed:@"ticker8.png"], nil];
    
    [self.animatedPicture setAnimationRepeatCount:0]; // run animation in loop
    self.animatedPicture.animationDuration = 1.0; // run speed
    [self.animatedPicture startAnimating]; //start animating!
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCancelButton:(id)sender {
    NSTimeInterval duration = self.datePicker.countDownDuration;
    
    self.seconds = 0;
    self.hours = (int)(duration/3600.0f);
    self.minutes = ((int)duration - (self.hours * 3600))/60;
    
    self.secondsCount = ((self.hours * 3600) + (self.minutes * 60));
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
    self.datePicker.hidden = YES; // hide viewpicker when timer starts (for increased ui flexibility)
    [self animationSetup]; // start animation
    
    if (self.isTimerRunning == YES) {
        
        self.timeLabel.alpha = 0;
        [self.startCancelButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.pauseResumeButton setTitle:@"Pause" forState:UIControlStateNormal];
        self.pauseResumeButton.enabled = NO;
        
        self.datePicker.hidden = NO; // bring view picker back when timer is reset
    
        [self.animatedPicture stopAnimating]; // stop animation
        
        [self.timer invalidate];
        self.timer = nil;
        
    } else {
        
        self.timeLabel.alpha = 1;
        
        [self.startCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        self.pauseResumeButton.enabled = YES;
        
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
        }
        
    }
    
    self.isTimerRunning = !self.isTimerRunning;
    
    
}

- (void) updateTimer {
    
    self.secondsCount--;
    
    self.hours = self.secondsCount/3600;
    self.minutes = (self.secondsCount % 3600)/60;
    self.seconds = self.secondsCount - (self.hours * 3600) - (self.minutes * 60);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
    if (self.secondsCount <= 0) {
        
        [self.timer invalidate];
        self.timer = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time Done!" message:[NSString stringWithFormat:@""] delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        
        [alert show];
        [self.animatedPicture stopAnimating];
        self.datePicker.hidden = NO;
        
        self.timeLabel.alpha = 0;
        [self.startCancelButton setTitle:@"Start" forState:UIControlStateNormal];
        self.pauseResumeButton.enabled = NO;
        
    }
    
}

- (IBAction)pauseResumeButton:(id)sender {
    if (self.isPaused == NO) {
        [self.timer invalidate];
        self.timer = nil;
        
        [self.animatedPicture stopAnimating]; // stop animation
        
        [self.pauseResumeButton setTitle:@"Resume" forState:UIControlStateNormal];
        
    } else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
            
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [self.pauseResumeButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.animatedPicture startAnimating]; // start animation
    }
    
    self.isPaused = !self.isPaused;
}


@end
