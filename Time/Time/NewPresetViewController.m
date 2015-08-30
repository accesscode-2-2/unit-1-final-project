//
//  NewPresetViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewPresetViewController.h"
#import "NewPresetViewControllerDelegate.h"

@interface NewPresetViewController ()
@property (nonatomic) NSMutableArray *hours;
@property (nonatomic) NSMutableArray *minutes;
@property (nonatomic) NSMutableArray *seconds;
@property (nonatomic) NSMutableArray *pickerViewNumbers;
@property (weak, nonatomic) IBOutlet UIPickerView *timerPickerView;
@property (weak, nonatomic) IBOutlet UITextField *timerNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation NewPresetViewController

#pragma mark - Initial Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPickerViewNumbers];
    self.timerPickerView.delegate = self;
    self.timerPickerView.dataSource = self;
}

- (void)setupHours {
    self.hours = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 12; i++) {
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.hours addObject:s];
    }
}

- (void)setupMinutes {
    self.minutes = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 60; i++) {
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.minutes addObject:s];
    }
}

- (void)setupSeconds {
    self.seconds = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 60; i++) {
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.seconds addObject:s];
    }
}

- (void)setupPickerViewNumbers {
    [self setupHours];
    [self setupMinutes];
    [self setupSeconds];
    
    self.pickerViewNumbers = [[NSMutableArray alloc] initWithObjects:self.hours,
                              self.minutes, self.seconds, nil];
}

#pragma mark - UIPickerView delegate and data source implementation
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerViewNumbers[component] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.pickerViewNumbers count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerViewNumbers[component][row];
}

#pragma mark - New Data
- (IBAction)doneButtonTapped:(id)sender {
    
    if(self.timerNameTextField.text.length == 0 ||
       ([self.timerPickerView selectedRowInComponent:0] == 00 &&
        [self.timerPickerView selectedRowInComponent:1] == 00 &&
        [self.timerPickerView selectedRowInComponent:2] == 00)){
           
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
       }else{
    
    NSArray *countdownTime = @[
                               self.pickerViewNumbers[0][[self.timerPickerView selectedRowInComponent:0]],
                               self.pickerViewNumbers[1][[self.timerPickerView selectedRowInComponent:1]],
                               self.pickerViewNumbers[2][[self.timerPickerView selectedRowInComponent:2]]
                               ];
    NSLog(@"%@", countdownTime);
    
    NSString *timerName = self.timerNameTextField.text;
    NSLog(@"%@", timerName);
    
    [self.delegate presetCreated:countdownTime withName:timerName];
           [self dismissViewControllerAnimated:YES completion:^{}];
       }

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *viewAsLabel = (UILabel *)view;
    
    if(!viewAsLabel) {
        viewAsLabel = [[UILabel alloc] init];
        [viewAsLabel setFont:[UIFont fontWithName:@"DigitalReadoutExpUpright" size:50]];
        [viewAsLabel setTextAlignment:NSTextAlignmentCenter];
        [viewAsLabel setBackgroundColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]];
        [viewAsLabel setTextColor:[UIColor colorWithRed:255/255 green:62.0/255 blue:127.0/255 alpha:1.0]];
    }
    
    if (component == 0) {
        viewAsLabel.text = [self.hours objectAtIndex:row];
    } else if (component == 1) {
        viewAsLabel.text = [self.minutes objectAtIndex:row];
    } else {
        viewAsLabel.text = [self.seconds objectAtIndex:row];
    }
    
    return viewAsLabel;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 80;
}


@end
