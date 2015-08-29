//
//  PresetTimerDetailViewController.m
//  Time
//
//  Created by Xiulan Shi on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimerDetailViewController.h"

@interface PresetTimerDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *startCancelButton;

@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PresetTimerDetailViewController

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
