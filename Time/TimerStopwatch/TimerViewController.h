//
//  TimerViewController.h
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/22/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//this is just for a commit!


@interface TimerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *countDownTimer;
@property (strong, nonatomic) IBOutlet UILabel *displayTime;
@property (strong, nonatomic) IBOutlet UIButton *timerReset;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *startime;
@property (nonatomic) NSTimeInterval totalTime;

- (IBAction)startButton:(id)sender;

- (void) pauseLayer:(CALayer *) layer;
- (void) resumeLayer:(CALayer *) layer;

@end

