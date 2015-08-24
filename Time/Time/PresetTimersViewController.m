//
//  PresetTimersViewController.m
//  Time
//
//  Created by Lauren Caponong on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimersViewController.h"

@interface PresetTimersViewController () <ViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *alarmNameLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePickerView;

@end

@implementation PresetTimersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)alarmNameLabel:(id)sender {
    
    //[ViewControllerDelegate updateAlarmLabel];
    
}

- (IBAction)timePickerView:(id)sender {
}


@end
