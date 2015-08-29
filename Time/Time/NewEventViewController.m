//
//  NewEventViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewEventViewController.h"

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePicker];
    [self.eventTextField setPlaceholder:@"Event Name"];
    self.doneButton.enabled = NO;
    self.eventTextField.delegate = self;
}

- (void)setupDatePicker {
    [self.eventDatePicker setDatePickerMode:UIDatePickerModeDate];
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:+ 1];
    NSDate *minDate = [sysCalendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:+ 85];
    NSDate *maxDate = [sysCalendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    self.eventDatePicker.minimumDate = minDate;
    self.eventDatePicker.maximumDate = maxDate;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *testString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    testString = [testString stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(testString.length){
      return  self.doneButton.enabled = YES;
    }
    else{
     return self.doneButton.enabled = NO;
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    [self.delegate presetCreated:self.eventDatePicker.date withName:self.eventTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
