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
        self.timerLabel.text = @"00:00:00";
        [self.timer invalidate];
    }
}

- (void) updateCountDown {
    self.afterRemainder --;
    
    int hours = (int)(self.afterRemainder/(60*60));
    int mins = (int)(((int)self.afterRemainder/60) - (hours * 60));
    int secs = (int)(((int)self.afterRemainder - (60 *mins) - (60 * hours * 60)));
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@"%02u : %02u : %02u", hours, mins, secs];
    
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
    
}

- (void)presetTimerButtonTapped:(UIBarButtonItem *)button {
    NSLog(@"charles");
    
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"newPresetController"];
    //    newPresetIdentifier.delegate = self;
    
    //    NewPresetsViewController *viewController = [[NewPresetsViewController alloc] init];
    //    UINavigationController *controller = [[UINavigationController alloc] init];
    //    controller.viewControllers = @[viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

//- (IBAction)createPresetButtonPressed:(id)sender {
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    NewPresetsViewController *newPresetIdentifier = [storyboard instantiateViewControllerWithIdentifier:@"newPresetIdentifier"];
//    newPresetIdentifier.delegate = self;
//
//    [self presentViewController:newPresetVC animated:YES completion:nil];
//}
@end
