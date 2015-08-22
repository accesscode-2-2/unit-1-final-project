//
//  StopwatchViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface StopwatchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;



@end

@implementation StopwatchViewController
@synthesize stopwatchLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    stopwatchLabel.text = @"00.00.000";
    running = FALSE;
    startDate = [NSDate date];
    self.startButton.layer.cornerRadius = 37.5;
    self.startButton.clipsToBounds = YES;
    self.resetButton.layer.cornerRadius = 37.5;
    self.resetButton.clipsToBounds = YES; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)startButton:(id)sender {
   
    
    if(!running){
       running = TRUE;
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        if (stopTimer == nil) {
            stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                         target:self
                                                       selector:@selector(updateTimer)
                                                       userInfo:nil
                                                        repeats:YES];
        }
    }else{
        running = FALSE;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [stopTimer invalidate];
        stopTimer = nil;
        
    }

}

-(void)updateTimer{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    stopwatchLabel.text = timeString;
}



- (IBAction)resetButton:(id)sender {
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [stopTimer invalidate];
    stopTimer = nil;
    startDate = [NSDate date];
    stopwatchLabel.text = @"00.00.000";
    running = FALSE;
    
}



@end
