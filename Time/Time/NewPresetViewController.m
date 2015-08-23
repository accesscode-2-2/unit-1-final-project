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


@end
