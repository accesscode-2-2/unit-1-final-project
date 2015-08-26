//
//  TimerViewController.h
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/22/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

<<<<<<< HEAD
@interface TimerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, PresetsTableViewControllerDelegate>
=======
//made a comment for a commit charles

@interface TimerViewController : UIViewController
>>>>>>> aa559a29d86cf85cc559e4bf0d8ae5c48a1172c6

@property (nonatomic) NSTimer *timer;

@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;

@property (strong, nonatomic) IBOutlet UIDatePicker *countDownTimer;

@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) NSInteger *secondsLeft;

- (IBAction)startTimer:(id)sender;
- (IBAction)pauseTimer:(id)sender;
- (IBAction)resetTimer:(id)sender;




@end

