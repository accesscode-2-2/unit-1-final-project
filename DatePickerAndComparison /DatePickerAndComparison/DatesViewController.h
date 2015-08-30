//
//  DatesViewController.h
//  DatePickerAndComparison
//
//  Created by MacMan on 8/30/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

int milliseconds = 1000;

int seconds = 1;

int minutes = 1;

int hour = 1;

int day = 1;

NSTimer *countDownTimer;

NSString *countDownDisplayTimer;


@interface DatesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *daysDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursDisplayLabel;

@property (weak, nonatomic) IBOutlet UILabel *minutesDisplayLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondsDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *milliSecDisplayLabel;

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
- (IBAction)didChangeDate:(UIDatePicker *)sender;
- (IBAction)calculateButtonAction:(UIButton *)sender;



@end
