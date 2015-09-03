//
//  TimerDetailViewController.m
//  TimerStopwatch
//
//  Created by Bereket  on 9/2/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "TimerDetailViewController.h"

@interface TimerDetailViewController ()


@end

@implementation TimerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"timer: %@", self.presetTimer);
    
//    self.presetTimer.timer = [NSTimer ...
    
}


- (IBAction)buttonTapped:(id)sender {
    
    if (sender == self.startDetailTime) {
        self.startNow = [[NSDate alloc] init];
        self.presetTimer.timer= [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.presetTimer.timer forMode: NSRunLoopCommonModes];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerFired {
    
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessonTime = [now timeIntervalSinceDate:self.startNow];
    self.presetTimer.timeInterval =  self.totalTime - self.totalSessonTime;
    
    self.detailTimeLabel.text = [NSString stringWithFormat:@"%0.2f", self.presetTimer.timeInterval];
    NSLog(@"%f", self.presetTimer.timeInterval);
    // update label
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
