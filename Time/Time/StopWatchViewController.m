//
//  StopWatchViewController.m
//  Time
//
//  Created by Jason Wang on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchViewController.h"

@interface StopWatchViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (weak, nonatomic) IBOutlet UIButton *labResetButton;

@property (nonatomic) BOOL running;

@property (nonatomic) NSTimeInterval startTime;

@property (nonatomic) NSMutableArray *labsTimes;

@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labResetButton.enabled = NO;
    self.timerLabel.text = @"00:00.00";
    self.running = NO;
    self.labsTimes = [[NSMutableArray alloc] init];
}

- (IBAction)startButtonAction:(UIButton *)sender {
    if (self.running == NO) {
        self.running = YES;
        self.startTime = [NSDate timeIntervalSinceReferenceDate];
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.labResetButton.enabled = YES;
        [self timeIncrement];
    } else {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
//        [self.labResetButton setTitle:@"Reset" forState:UIControlStateNormal];
        self.running = NO;
    }
    
}

- (IBAction)labResetButtonAction:(UIButton *)sender {
    //    NSString *labTime = self.timerLabel.text;
    [self.labsTimes addObject:self.timerLabel.text];
    
    NSLog(@"%@",self.labsTimes);
    
}

- (void)timeIncrement {
    if (self.running == NO)
        return;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - self.startTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 100.0;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02u:%02u.%02u", mins, secs, fraction];
    
    [self performSelector:@selector(timeIncrement) withObject:self afterDelay:0.01];
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
