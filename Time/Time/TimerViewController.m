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

- (IBAction)Start {
    
    mainFloat = 10.00;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void)countDown {
    
    mainFloat -= 0.01;
    seconds.text = [NSString stringWithFormat:@"%f", mainFloat];
    
    if (mainFloat == 0) {
        [timer invalidate];
    }
}
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
