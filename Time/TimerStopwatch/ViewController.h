//
//  ViewController.h
//  PresetTimerPracticeProject
//
//  Created by Bereket  on 8/29/15.
//  Copyright (c) 2015 Bereket . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    
}


@property (strong, nonatomic) IBOutlet UIPickerView *timerPickerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeLabel;

@property (nonatomic, strong) NSMutableArray* myStoredTimeFromPickerView;

@property (nonatomic,strong) NSArray* pickerViewArrayHours;
@property (nonatomic,strong) NSMutableArray* minAndSecArray;

@property (strong, nonatomic) IBOutlet UIButton *setTimeButton;
@property (nonatomic) NSString* timeString;

@property (nonatomic) NSMutableArray* arrayForTimes;
@end

