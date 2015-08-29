//
//  CQNewTimerViewController.m
//  Time
//
//  Created by Ayuna Vogel on 8/24/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "CQNewTimerViewController.h"
#import "CQTimer.h"
#import "TimerViewController.h"

@interface CQNewTimerViewController ()

@end

@implementation CQNewTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"New Timer";

    NSInteger seconds = 60;
    [self.timerPickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.timerPickerView setCountDownDuration:seconds];
    self.timerLabel.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button methods 

- (void)timerFired: (NSTimer *)timer {
    self.secondsCount--;
    
    self.hours = self.secondsCount/3600;
    self.minutes = (self.secondsCount % 3600)/60;
    self.seconds = self.secondsCount - (self.hours * 3600) - (self.minutes * 60);
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    self.timerLabel.hidden = NO;
    self.timerPickerView.hidden = YES;
    
    if (self.secondsCount <= 0) {
        
        [self.timer invalidate];
        self.timer = nil;
        
        [self.startCancelButtonTapped setTitle:@"Start" forState:UIControlStateNormal];
        self.pauseResumeButtonTapped.enabled = NO;
    }
}

- (IBAction)startCancelButtonTapped:(id)sender {
    self.timerDuration = self.timerPickerView.countDownDuration;
    
    self.seconds = 0;
    self.hours = (int)(self.timerDuration/3600.0f);
    self.minutes = ((int)self.timerDuration - (self.hours * 3600))/60;
    
    self.secondsCount = ((self.hours * 3600) + (self.minutes * 60));
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
    if (self.isTimerRunning == YES) {
        
        [self.startCancelButtonTapped setTitle:@"Start" forState:UIControlStateNormal];
        [self.pauseResumeButtonTapped setTitle:@"Pause" forState:UIControlStateNormal];
        self.pauseResumeButtonTapped.enabled = NO;
        self.timerLabel.hidden = YES;
        self.timerPickerView.hidden = NO;
        
        [self.timer invalidate];
        self.timer = nil;
        
    } else {
        
        [self.startCancelButtonTapped setTitle:@"Cancel" forState:UIControlStateNormal];
        self.pauseResumeButtonTapped.enabled = YES;
        
        
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        }
    }
    
    self.isTimerRunning = !self.isTimerRunning;
}

- (IBAction)pauseResumeButtonTapped:(id)sender {
    if (self.isTimerPaused == NO) {
        [self.timer invalidate];
        self.timer = nil;
        
        [self.pauseResumeButtonTapped setTitle:@"Resume" forState:UIControlStateNormal];
        
    } else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        [self.pauseResumeButtonTapped setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    self.isTimerPaused = !self.isTimerPaused;
}

- (IBAction)saveButtonTapped:(id)sender {
    
    // Get the element you want to pass to the next VC.
    
    CQTimer *newTimer = [[CQTimer alloc] init];
    newTimer.timerTitle = self.timerTitleTextField.text;
    newTimer.timerDuration = self.timerPickerView.countDownDuration;
    
    [self.delegate addToTheArrayNewTimer:newTimer]; 
    
    
   // [self.presetTimers addObject:newTimer];
    
    // Get the new view controller using [segue destinationViewController].
    
    //timerViewController.delegate = self;
    
    // Pass the selected object to the new view controller.
    
//    TimerViewController.timerObject = newTimer;
//    
//    [self.presetTimers addObject:_timerObject];
//    self.timerObject.
//    self.timerObject.timerTitle = timerViewController.timerObject.timerTitle;
//    self.timerObject.timerDuration = timerViewController.timerObject.timerDuration;

    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - soundPickerView methods

// Number of columns in the soundPickerView (one).
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// Number of rows (choices) in the soundPickerView (as many as there are sound alarm choices).
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    //return [self.pickerData[component] count];
//}

@end
