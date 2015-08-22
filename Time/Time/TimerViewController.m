//
//  TimerViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController
@synthesize timerLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timerLabel.text = @"10.00.00.000";
    countDown = FALSE;
    
}
- (IBAction)timerStartButton:(id)sender {
    
    
    }

- (IBAction)timerStopButton:(id)sender {
}

- (void)countDown {
    
    
    
    if (timerLabel == 0) {
        [timer invalidate];
    }
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
