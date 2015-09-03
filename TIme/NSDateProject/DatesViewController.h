//
//  DatesViewController.h
//  DatePickerAndComparison
//
//  Created by MacMan on 8/30/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

NSTimer *countDownTimer;
NSString *countDownDisplayTimer;


@interface DatesViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

- (IBAction)didChangeDate:(UIDatePicker *)sender;

- (IBAction)calculateButtonAction:(UIButton *)sender;


@end
