//
//  PresetTimerAddViewController.m
//  Time
//
//  Created by Xiulan Shi on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimerAddViewController.h"
#import "TimerModel.h"

@interface PresetTimerAddViewController () <UITextFieldDelegate>

@property (nonatomic) TimerModel *model;
@property (weak, nonatomic) IBOutlet UIDatePicker *selectTime;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITextField *timerName;



@end

@implementation PresetTimerAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model = [[TimerModel alloc] init];
    [self.model initializeModel];
    
    self.timerName.delegate = self;
    
}


- (void)saveNewTimer{
    
    Timer *newTimer = [[Timer alloc] init];
    
    newTimer.timerName = self.timerName.text;
    
    newTimer.countDownDuration = self.selectTime.countDownDuration;
    
    [self.timerViewController.model.timers insertObject:newTimer atIndex:0];
    
    
}


- (IBAction)saveButtonTapped:(id)sender {
    
    [self saveNewTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonTapped:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSLog(@"Current text: %@", textField.text);
    
    return YES;
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
