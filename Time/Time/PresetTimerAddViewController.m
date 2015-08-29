//
//  PresetTimerAddViewController.m
//  Time
//
//  Created by Xiulan Shi on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimerAddViewController.h"

@interface PresetTimerAddViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *selectTime;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITextField *timerName;



@end

@implementation PresetTimerAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
