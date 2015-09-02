//
//  TimerViewController.m
//  Time
//
//  Created by Eric Sze on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIView *leftCircle;
@property (weak, nonatomic) IBOutlet UIView *rightCircle;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;

@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSTimer *countDownTimer;
//@property (nonatomic) NSTimeInterval countDownDuration;
//@property (nonatomic) NSTimeInterval trackTotalTime;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[self tabBarController] navigationItem] setTitle:@"Timer"];
    
    self.leftCircle.layer.cornerRadius = 34.5;
    self.leftCircle.layer.masksToBounds = YES;
    self.leftCircle.clipsToBounds = YES;
    
    self.rightCircle.layer.cornerRadius = 34.5;
    self.rightCircle.layer.masksToBounds = YES;
    self.rightCircle.clipsToBounds = YES;
    
    [self.timerLabel setHidden:YES];
    
    [self.pickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    //[self.pickerView setCountDownDuration:60];
    
    [self.pauseButton setEnabled:NO];
    [self.pauseButton setTitleColor: [UIColor lightGrayColor]forState:UIControlStateNormal];
    
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    
//    self.pickerView.countDownDuration = 60.0f;
    
//        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        [outputFormatter setDateFormat:@"hh:mm:ss a"];
//    
//    
//        self.timerLabel.text = [outputFormatter stringFromDate:self.pickerView.date];
}

-(IBAction)updateLabelText:(UISlider *)sender {
    //NSLog(@"%@", self.timerLabel);
    
}

- (IBAction)startButton:(UIButton *)sender {
    [self.startButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    [self.pauseButton setEnabled:YES];
    [self.pauseButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
    [self.pickerView setHidden:YES];
    [self.timerLabel setHidden:NO];
    
    [self startTimerMethod];
    
//    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    //[[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
    //self.countDownDuration = self.pickerView.countDownDuration;
}

- (void)startTimerMethod {
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)countDown:(NSTimer *) countDownTimer {
    //self.countDownDuration = self.countDownDuration - 1;
    self.pickerView.countDownDuration = 60.0f;
    self.pickerView.countDownDuration = self.pickerView.countDownDuration - 1;
    [self updateTimeLabel];
}

- (IBAction)pickerAction:(UIDatePicker *)sender {
    [self.pickerView addTarget:self action:@selector(updateTime) forControlEvents:UIControlEventValueChanged];
}

- (void)updateTime {
    //self.pickerView.countDownDuration = UIDatePickerModeCountDownTimer;
    
    //NSInteger timeInterval = ((NSInteger)[self.pickerView.date timeIntervalSinceNow]);
    //NSInteger seconds = timeInterval % 60;
    //NSInteger minutes = (timeInterval / 60) % 60;
    //NSInteger hours = (timeInterval / 3600) % 24;
    
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"hh:mm:ss a"];
//    
    
//    self.timerLabel.text = [outputFormatter stringFromDate:self.pickerView.datePickerMode];
//    self.timerLabel.text = [outputFormatter stringForObjectValue:self.pickerView.date];

    //self.timerLabel.text = [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    
    //NSLog(@"%@", self.timerLabel.text);
}

- (void)updateTimeLabel {
//    int secondsCount = self.countDownDuration;
//    int minutes = secondsCount / 60;
//    int seconds = secondsCount - (minutes * 60);
//    
//    self.timerLabel.text = [NSString stringWithFormat:@"%02u:%02u", minutes, seconds];
//    
    //NSInteger timeInterval = ((NSInteger)[self.pickerView.date timeIntervalSinceNow]);
    
    NSInteger timeInterval = self.pickerView.countDownDuration;
    NSInteger seconds = timeInterval % 60;
    NSInteger minutes = (timeInterval / 60) % 60;
    NSInteger hours = (timeInterval / 3600) % 24;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}








- (IBAction)cancelButton:(UIButton *)sender {
    [self.cancelButton setHidden:YES];
    [self.startButton setHidden:NO];
    [self.pauseButton setHidden:NO];
    [self.pauseButton setEnabled:NO];
    [self.pauseButton setTitleColor: [UIColor lightGrayColor]forState:UIControlStateNormal];
    [self.resumeButton setHidden:YES];
    
    [self.timerLabel setHidden:YES];
    [self.pickerView setHidden:NO];
    
    [self.countDownTimer invalidate];
}


- (IBAction)pauseButton:(UIButton *)sender {
    [self.pauseButton setHidden:YES];
    [self.resumeButton setHidden:NO];
    
    [self.countDownTimer invalidate];
    
}
- (IBAction)resumeButton:(UIButton *)sender {
    [self.resumeButton setHidden:YES];
    [self.pauseButton setHidden:NO];
    [self startTimerMethod];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
