//
//  TimerViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseResumeButton;
@property (strong, nonatomic) IBOutlet UIDatePicker *picker;
@property (nonatomic) NSDate *startTime;  //
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSTimer *timer;
@end

@implementation TimerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker.hidden = NO;
    self.timeLabel.hidden = YES;
    
    
    /******  Interface layout *****/
    [self.startStopButton.titleLabel  isEqual: @"START"];
    self.startStopButton.layer.cornerRadius = 60;
    self.startStopButton.clipsToBounds = YES;
    self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    
    [self.pauseResumeButton.titleLabel  isEqual: @"PAUSE"];
    self.pauseResumeButton.layer.cornerRadius = 60;
    self.pauseResumeButton.clipsToBounds = YES;
    self.pauseResumeButton.backgroundColor = [UIColor redColor];
 }






- (void)timerFired:(NSTimer *)timer {
    NSLog(@"hi hi");
    NSDate *now = [[NSDate alloc] init];
    NSInteger elapsedTime = [now timeIntervalSinceDate:self.startTime];
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"%lu", self.duration - elapsedTime];
}
- (IBAction)startStopButton:(id)sender {
    self.timeLabel.hidden = NO;
    self.picker.hidden = YES;

    
    self.duration = 30;
    
    NSLog(@"i clicked start");
    NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
    if ([startStopActualLabel isEqualToString:@"START"] ) {
        // set self.startTime to now
        self.startTime = [[NSDate alloc] init];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        // change the button label to "Stop" so we know it's running
        [self.startStopButton setTitle:@"STOP" forState:UIControlStateNormal];
        
    } else {
        NSLog(@"else");
        [self.timer invalidate];
        
        [self.startStopButton setTitle:@"START" forState:UIControlStateNormal];
        
    }
    
    
    
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
