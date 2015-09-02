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
//@property (nonatomic) NSTimer *timer;
//@property (nonatomic) NSTimeInterval countDownDuration;
//@property (nonatomic) NSTimeInterval trackTotalTime;

@property (nonatomic) NSInteger totalSecondsLeft;


@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.leftCircle.layer.cornerRadius = 34.5;
    self.leftCircle.layer.masksToBounds = YES;
    self.leftCircle.clipsToBounds = YES;
    
    self.rightCircle.layer.cornerRadius = 34.5;
    self.rightCircle.layer.masksToBounds = YES;
    self.rightCircle.clipsToBounds = YES;
    

    self.timerLabel.alpha = 0;
    [self.pauseButton setEnabled:NO];
    [self.pauseButton setTitleColor: [UIColor lightGrayColor]forState:UIControlStateNormal];
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *date =self.pickerView.date;
//    NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
//    
//    self.totalSecondsLeft = comps.hour * 3600 + comps.minute * 60;
    
}


- (IBAction)startButton:(UIButton *)sender {
    [self.startButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    [self.pauseButton setEnabled:YES];
    [self.pauseButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
    //[self.pickerView setHidden:YES];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{self.pickerView.alpha = 0;} completion:nil];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{self.timerLabel.alpha = 1;} completion:nil];

//    [UIView animateWithDuration:1.0 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{self.timerLabel.alpha = 1.0;} completion:^(BOOL finished) {
//        [UIView animateWithDuration:1.0 delay:1.0 options: UIViewAnimationOptionCurveEaseOut animations:^{self.timerLabel.alpha = 0.0;} completion:^(BOOL finished){NSLog(@"Done!");
//         }];
//    }];
    
    
    [self startTimerMethod];
    self.timerLabel.text = [self makeTimeLabel];

}

- (void)startTimerMethod {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = self.pickerView.date;
    NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    
    self.totalSecondsLeft = comps.hour * 3600 + comps.minute * 60;
    
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
}

- (void)updateLabel:(NSTimer *)timer {
    self.timerLabel.text = [self makeTimeLabel];
    
    if (self.totalSecondsLeft > 0) {
        self.totalSecondsLeft--;
    } else {
        [timer invalidate];
    }
}

- (NSString *)makeTimeLabel {
    NSInteger hoursLeft = self.totalSecondsLeft / 3600;
    NSInteger minutesLeft = (self.totalSecondsLeft % 3600) / 60;
    NSInteger secondsLeft = ((self.totalSecondsLeft % 3600) % 60) % 60;
    
    NSString *hoursToBeShown = [NSString stringWithFormat:@"%ld", (long)hoursLeft];
    NSString *minutesToBeShown = @"";
    NSString *secondsToBeShown = @"";
    
    if (minutesLeft < 10 && minutesLeft != 0) {
        minutesToBeShown = [NSString stringWithFormat:@"0%ld", (long)minutesLeft];
    } else if (minutesLeft == 0) {
        minutesToBeShown = @"00";
    } else minutesToBeShown = [NSString stringWithFormat:@"%ld", (long)minutesLeft];
    
    if (secondsLeft < 10 && secondsLeft != 0) {
        secondsToBeShown = [NSString stringWithFormat:@"0%ld", (long)secondsLeft];
    } else if  (secondsLeft == 0) {
        secondsToBeShown = @"00";
    } else {
        secondsToBeShown = [NSString stringWithFormat:@"%ld", (long)secondsLeft];
    }
    
    return [NSString stringWithFormat:@"%@:%@:%@", hoursToBeShown, minutesToBeShown, secondsToBeShown];
}


- (IBAction)cancelButton:(UIButton *)sender {
    [self.cancelButton setHidden:YES];
    [self.startButton setHidden:NO];
    [self.pauseButton setHidden:NO];
    [self.pauseButton setEnabled:NO];
    [self.pauseButton setTitleColor: [UIColor lightGrayColor]forState:UIControlStateNormal];
    [self.resumeButton setHidden:YES];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{self.pickerView.alpha = 1;} completion:nil];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{self.timerLabel.alpha = 0;} completion:nil];
    
    [self.countDownTimer invalidate];
    //self.countDownTimer = nil;
}


- (IBAction)pauseButton:(UIButton *)sender {
    [self.pauseButton setHidden:YES];
    [self.resumeButton setHidden:NO];
    
    [self.countDownTimer invalidate];
    //self.countDownTimer = nil;
    
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
