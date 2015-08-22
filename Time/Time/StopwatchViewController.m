//
//  StopwatchViewController.m
//  Time
//
//  Created by Mesfin Bekele Mekonnen on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
//@import QuartzCore;

@interface StopwatchViewController ()
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) CFTimeInterval initialTime;

@property (nonatomic) CADisplayLink *stopwatchTimer;

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stopwatchTimer  = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(refreshTimerLabel)];
}

-(void)refreshTimerLabel{
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval difference = currentTime - self.initialTime;

    NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li.%03li",
                        lround(floor(difference / 3600.)) % 100,
                        lround(floor(difference / 60.)) % 60,
                        lround(floor(difference)) % 60,
                        lround(floor(difference * 1000)) % 1000];
    
    self.timerLabel.text = string;
    
}

- (IBAction)startButtonTapped:(UIButton *)sender {
    [self.stopwatchTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.initialTime = CACurrentMediaTime();
}

- (IBAction)stopButtonTapped:(UIButton *)sender {
    
}

- (IBAction)lapButtonTapped:(UIButton *)sender {
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
