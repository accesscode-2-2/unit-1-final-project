//
//  DatePickerVC.h
//  StopWatch
//
//  Created by MacMan on 8/31/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

int days = 365.242;
int hours = 24;
int minutes= 60;
int seconds = 60;
int milliseconds = 100;

@interface DatePickerVC : UIViewController

@property (strong,nonatomic)NSMutableArray *countDownArray;

@property (weak,nonatomic) NSTimer *countDownTimer;


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
