//
//  TimerDetailViewController.m
//  TimerStopwatch
//
//  Created by Bereket  on 9/2/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//


#import "PresetTimer.h"
#import "TimerDetailViewController.h"



@interface TimerDetailViewController ()






@end

@implementation TimerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   


    // Do any additional setup after loading the view.
    
    
//    self.presetTimer.timer = [NSTimer ...
    
}


- (IBAction)buttonTapped:(id)sender {
    
    if (sender == self.startDetailTime) {
        self.startNow = [[NSDate alloc] init];
        self.presetTimer.timer= [NSTimer timerWithTimeInterval:1/1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.presetTimer.timer forMode: NSRunLoopCommonModes];
    }
    
        if (sender == self.pauseDetailTime) {
            
            self.totalTime =  self.totalTime - self.totalSessonTime;
            [self.presetTimer.timer invalidate];
            self.presetTimer.timer= nil;

        }
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerFired: (NSTimer *)timer {
    
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessonTime = [now timeIntervalSinceDate:self.startNow];
    self.presetTimer.timeInterval =  self.presetTimer.seconds -1;
     self.presetTimer.seconds=self.presetTimer.timeInterval;
    
    if(self.presetTimer.timeInterval==0){
        [self.presetTimer.timer invalidate];
        self.presetTimer.timer=nil;
    }
    
    int hours = (int)(self.self.presetTimer.timeInterval/(60*60));
    int mins = (int)(((int)self.presetTimer.timeInterval/60) - (hours * 60));
    int secs = (int)(((int)self.presetTimer.timeInterval - (60 *mins) - (60 * hours * 60)));
    self.detailTimeLabel.text = [[NSString alloc] initWithFormat:@"%02u:%02u:%02u", hours, mins, secs];
    
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
