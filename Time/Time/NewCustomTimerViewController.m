//
//  NewCustomTimerViewController.m
//  Time
//
//  Created by Christian Maldonado on 8/26/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewCustomTimerViewController.h"

@interface NewCustomTimerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *timePickerView;
@property (weak, nonatomic) IBOutlet UITextField *alarmNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation NewCustomTimerViewController

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
    NSString *alarmName = self.alarmNameLabel.text;
    NSLog(@"%@ dookie",alarmName);
    NSTimeInterval timeInterval = self.timePickerView.countDownDuration;
    NSLog(@"%f poopy", timeInterval);
    
    //break this down into hours and minutes because it's displayed in seconds
    //deligation to comunitcate this info back to the next view controller
    
    /*
     when the user hits 'done' use delegation to provide all timer info back to the 
     presettimersviewcontroller
     
     ex.
     
     NSInteger hours = x;
     NSInteger minutues = x;
     
     [self.delegate newCustomTimeViewController:self didAddTimerWithHours:hours minutes:minutes name:alarmName];
     
     */
    
}


- (IBAction)alarmNameLabel:(id)sender {
    
    //[ViewControllerDelegate updateAlarmLabel];
    
}

- (IBAction)timePickerView:(id)sender {
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
