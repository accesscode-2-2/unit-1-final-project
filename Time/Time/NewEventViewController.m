//
//  NewEventViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewEventViewController.h"
#import "Time-Swift.h"

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet PIDatePicker *eventPicker;

@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePicker];
    [self.eventTextField setPlaceholder:@"Event Name"];
    self.doneButton.enabled = YES;
    self.eventTextField.delegate = self;
}

- (void)setupDatePicker {
    //[self.eventDatePicker setDatePickerMode:UIDatePickerModeDate];
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:+ 1];
    NSDate *minDate = [sysCalendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:+ 85];
    NSDate *maxDate = [sysCalendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    self.eventPicker.minimumDate = minDate;
    self.eventPicker.maximumDate = maxDate;
    self.eventPicker.font = [UIFont fontWithName:@"DigitalReadoutExpUpright" size:24];
    self.eventPicker.textColor = [UIColor colorWithRed:255/255 green:62.0/255 blue:127.0/255 alpha:1.0];
    self.eventPicker.cellColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    self.eventPicker.cellHeight = 50.0;
    [self.eventPicker reloadAllComponents];
    NSLog(@"DEFAULT ROW HEIGHT: %@", NSStringFromCGSize([self.eventPicker.pickerView rowSizeForComponent:0]));
    
}

- (IBAction)doneButtonTapped:(id)sender {
    if(self.eventTextField.text.length == 0){
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Either the timer name or the actual value is missing, Please fill out those fields before progressing."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [self.delegate presetCreated:self.eventPicker.date withName:self.eventTextField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
