//
//  TimerViewController.m
//  Time
//
//  Created by Artur Lan on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (nonatomic) NSTimeInterval countDownDuration;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (nonatomic) NSTimer *countdownTimer;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;


@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    
    [self.timer setHidden:YES];
    // Create a new date with the current time
    // Split up the date components
    
    NSInteger seconds = 60;
    
    [self.pickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.pickerView setCountDownDuration:seconds];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender {
    [self.startButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    
    if(sender == self.startButton){
        [self.timer setHidden:NO];
        [self.pickerView setHidden:YES];
        
        
        NSTimer *countdownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:countdownTimer forMode:NSRunLoopCommonModes];
        
        self.countDownDuration = self.pickerView.countDownDuration;
        
        NSLog(@"%f",self.pickerView.countDownDuration);
    }
}

- (IBAction)cancelButton:(id)sender {
    [self.startButton setHidden:NO];
    [self.cancelButton setHidden:YES];
    
}
- (IBAction)pauseButton:(id)sender {
    
    [self.pauseButton setHidden:YES];
    [self.resumeButton setHidden:NO];
    
    self.
}
- (IBAction)resumeButton:(id)sender {
    [self.resumeButton setHidden:NO];
}

- (void)countDown:(NSTimer *) countdownTimer {
    self.countDownDuration = self.countDownDuration - 1;
    int secondsCount = self.countDownDuration;
    int minutes = secondsCount / 60;
    int seconds = secondsCount - (minutes * 60);
    
    
    NSString *outputTimer = [NSString stringWithFormat:@"%02u:%02u", minutes, seconds];
    self.timer.text = outputTimer;
 
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
