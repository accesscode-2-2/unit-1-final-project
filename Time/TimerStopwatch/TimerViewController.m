//
//  TimerViewController.m
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/22/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "TimerViewController.h"
#import "AppDelegate.h"
#import "NewPresetsViewController.h"

@interface TimerViewController ()

@property (nonatomic) NSTimeInterval countDownInterval;
@property (nonatomic) NSTimeInterval totalSessionTime;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) int countDownDuration;
@property (nonatomic) int afterRemainder;
@property (nonatomic) int remainder;



// FYI, pressing "create preset timer" will cause app to crash
//- (IBAction)createPresetButtonPressed:(id)sender;

//@property (nonatomic) NSArray *presetTime;


@end

@implementation TimerViewController

- (IBAction)startTimer:(id)sender {
    if(!self.timer){
        self.countDownInterval = (NSTimeInterval)self.countDownTimer.countDownDuration;
        self.remainder = self.countDownInterval;
        self.afterRemainder = self.countDownInterval - self.remainder%60;
        
        NSLog(@"%f", self.countDownTimer.countDownDuration);
        
        self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        
        self.afterRemainder++;
        [self updateCountDown];
        [self.countDownTimer setHidden:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        self.startTime = [[NSDate alloc] init];
    }
}

// pressing start after pausing will cause it to start over from the original time selected
- (IBAction)pauseTimer:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
}

- (IBAction)resetTimer:(id)sender {
    if (sender == self.resetButton) {
        self.timerLabel.text = @"0:00:00";
        [self.timer invalidate];
        [self.countDownTimer setHidden:NO];
    }
}

- (void) updateCountDown {
    self.afterRemainder --;
    
    int hours = (int)(self.afterRemainder/(60*60));
    int mins = (int)(((int)self.afterRemainder/60) - (hours * 60));
    int secs = (int)(((int)self.afterRemainder - (60 *mins) - (60 * hours * 60)));
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@"%02u:%02u:%02u", hours, mins, secs];
    
    self.timerLabel.text = timeDisplay;
}

- (void)timerFired:(NSTimer *)timer {
    
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.startTime];
    NSTimeInterval distance =  self.totalTime + self.totalSessionTime;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    NSLog(@"%f", distance);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.countDownTimer.datePickerMode = UIDatePickerModeCountDownTimer;
    self.countDownTimer.countDownDuration = 60;
    self.navigationItem.title = @"Timer";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presetTimerButtonTapped:)];
    
    self.startButton.layer.borderWidth = 3.0;
    self.startButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.startButton.layer.cornerRadius = self.startButton.bounds.size.width/2;
    self.startButton.layer.borderColor = [UIColor colorWithRed:47/255.0 green:68/255.0 blue:80/255.0 alpha: 1].CGColor;

    [self.startButton setClipsToBounds:YES];
    
    self.pauseButton.layer.borderWidth = 3.0;
    self.pauseButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.pauseButton.layer.cornerRadius = self.pauseButton.bounds.size.width/2;
    self.pauseButton.layer.borderColor = [UIColor colorWithRed:47/255.0 green:68/255.0 blue:80/255.0 alpha: 1].CGColor;
    [self.pauseButton setClipsToBounds:YES];
    
    self.resetButton.layer.borderWidth = 3.0;
    self.resetButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resetButton.layer.cornerRadius = self.resetButton.bounds.size.width/2;
    self.resetButton.layer.borderColor = [UIColor colorWithRed:47/255.0 green:68/255.0 blue:80/255.0 alpha: 1].CGColor;
    [self.resetButton setClipsToBounds:YES];
    
}

- (void)presetTimerButtonTapped:(UIBarButtonItem *)button {
    NSLog(@"charles");
    
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"newPresetController"];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

@end
