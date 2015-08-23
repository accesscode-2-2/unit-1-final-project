//
//  SpecialEventViewController.h
//  Time
//
//  Created by Felicia Weathers on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialEventViewController : UIViewController {
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
- (IBAction)titleTextFiled2:(id)sender;

- (IBAction)startButton:(id)sender;
- (IBAction)resetButton:(id)sender;


@end
