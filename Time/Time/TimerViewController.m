//
//  TimerViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (nonatomic) NSInteger afterRemainder;
@property (nonatomic)  NSInteger Remainder;
@property (nonatomic) NSTimeInterval countDownInterval;

@property (nonatomic) BOOL running;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.running = NO;
    self.Remainder = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)updateTime {
    self.afterRemainder --;
    
    if (self.afterRemainder <=0) {
        [self invalidateTimer];
        
    }
    
    NSInteger hours = (NSInteger)(self.afterRemainder/(60*60));
    NSInteger minutes = (((NSInteger)self.afterRemainder/60) - (hours *60));
    NSInteger seconds = (((NSInteger)self.afterRemainder - (60 * minutes) - (60 * hours *60)));
    NSString *displayText = [[NSString alloc] initWithFormat: @"%02ld : %02ld : %02ld", (long)hours, (long)minutes, (long)seconds];
    
    self.countdownLabel.text = displayText;
}

- (IBAction)startCountdown:(id)sender {
    if (!self.running) {
        
        [sender setTitle:@"Pause" forState: UIControlStateNormal];
        
        self.running = TRUE;
        
        if (self.Remainder==-1){
            self.countDownInterval = (NSTimeInterval)_datePicker.countDownDuration;
            self.Remainder = self.countDownInterval;
            self.afterRemainder = self.countDownInterval - self.Remainder%60;
        }
        
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(updateTime)
                                                        userInfo:nil
                                                         repeats:YES];
 
    } else {
        self.running = FALSE;
        [sender setTitle:@"Start" forState: UIControlStateNormal];
        [self invalidateTimer];
    }
    
}

- (void) invalidateTimer{
    if (countdownTimer != nil) {
        [countdownTimer invalidate];
        countdownTimer = nil;
    }
}
- (IBAction)restartButton:(id)sender {
    self.running = FALSE; 
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [countdownTimer invalidate];
    countdownTimer = nil;
    self.countdownLabel.text = @"00.00.00";
    
}
@end

