//
//  TimerViewController.h
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
{
    
    NSTimer *countdownTimer;
    double timerInterval;
    double timerElapsed;
    NSDate *timerStarted;

}
    
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@property (nonatomic) NSMutableArray *presets;

- (IBAction)startCountdown:(id)sender;
- (IBAction)restartButton:(id)sender;

- (IBAction)presetButton:(id)sender;




@end
