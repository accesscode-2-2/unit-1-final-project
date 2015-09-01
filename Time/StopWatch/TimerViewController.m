//
//  TimerViewController.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/31/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *startCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.countdownLabel.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCancelTapped:(id)sender {
    if ([self.startCancelButton.titleLabel.text isEqualToString:@"Start"]) {
        self.datePicker.alpha = 0;
        self.countdownLabel.alpha = 1;
        [self.startCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    }
    else {
        self.datePicker.alpha = 1;
        self.countdownLabel.alpha = 0;
        [self.startCancelButton setTitle:@"Start" forState:UIControlStateNormal];
    }

}

- (IBAction)pauseResume:(id)sender {
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
