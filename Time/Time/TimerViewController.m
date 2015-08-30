//
//  TimerViewController.m
//  Time
//
//  Created by Eric Sze on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIView *leftCircle;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftCircle.layer.cornerRadius = 34.5;
    self.leftCircle.layer.masksToBounds = YES;
    self.leftCircle.clipsToBounds = YES;
    
    [self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
