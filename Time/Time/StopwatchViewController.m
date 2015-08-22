//
//  StopwatchViewController.m
//  Time
//
//  Created by Mesfin Bekele Mekonnen on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"

@interface StopwatchViewController ()
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) CADisplayLink *stopwatchTimer;

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stopwatchTimer  = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshTimerLabel)];
    NSDate *initialDate = [NSDate new];
}

-(void)refreshTimerLabel{
    
    
    
    NSDate *currentDate = [NSDate new];
    
}
- (IBAction)startButtonTapped:(UIButton *)sender {
    
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
