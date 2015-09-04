////
////  ViewController.h
////  PresetTimerPracticeProject
////
////  Created by Bereket  on 8/29/15.
////  Copyright (c) 2015 Bereket . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetTimer.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *timeTableButton;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIButton *setButton;

//
//
//@property (strong, nonatomic) IBOutlet UIPickerView *timerPickerView;
//@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeLabel;
//
//@property (nonatomic, strong) NSMutableArray* myStoredTimeFromPickerView;
//
//@property (nonatomic,strong) NSArray* pickerViewArrayHours;
//@property (nonatomic,strong) NSMutableArray* minAndSecArray;
//
//@property (strong, nonatomic) IBOutlet UIButton *setTimeButton;
//@property (nonatomic) NSString* timeString;
//
//@property (nonatomic) NSMutableArray* arrayForTimes;
@end
//
