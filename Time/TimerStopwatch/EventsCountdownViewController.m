//
//  EventsCountdownViewController.m
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/27/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "EventsCountdownViewController.h"

@interface EventsCountdownViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *timeTillBirthday;
@property (strong, nonatomic) IBOutlet UILabel *birthdayCountdownLabel;
- (IBAction)startCountdown:(id)sender;



@end

@implementation EventsCountdownViewController

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

- (IBAction)startCountdown:(id)sender {
}
@end
