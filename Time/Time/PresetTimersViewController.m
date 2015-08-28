//
//  PresetTimersViewController.m
//  Time
//
//  Created by Lauren Caponong on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimersViewController.h"


@interface PresetTimersViewController () <ViewControllerDelegate>




@end

@implementation PresetTimersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    totalSeconds = 120;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];

}

//-(void)timer {
//    totalSeconds--;
//    timerLabel.text = [self timeFormatted:totalSeconds];
//    if (totalSeconds == 0) {
//        [countDownTimer invalidate];
//    }
//}

//- (void) newCustomTimeViewController:(NewCustomViewController *)customVC didAddTimerWithHours:(NSInteger)hours minutes:(NSInteger)minutes name:(NSString *)alarmName {
    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
