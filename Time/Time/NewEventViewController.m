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
@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePicker];
    [self.eventTextField setPlaceholder:@"Event Name"];
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

- (IBAction)doneButtonTapped:(id)sender {
    [self.delegate presetCreated:self.eventDatePicker.date withName:self.eventTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
