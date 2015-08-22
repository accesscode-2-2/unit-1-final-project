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
@property (nonatomic) CFTimeInterval lapInitialTime;


@property (nonatomic) CADisplayLink *stopwatchTimer;

@property (weak, nonatomic) IBOutlet UILabel *lapLabel;

@property (nonatomic) NSMutableArray *lapTimes;

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lapTimes = [NSMutableArray new];
    
    self.stopwatchTimer  = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(refreshTimerLabel)];
    [self.stopwatchTimer setPaused:YES];

    [self.stopwatchTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}

-(NSString *)formatTimeString:(CFTimeInterval)timeInterval{
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval difference = currentTime - timeInterval;
    
    NSString *string = [NSString stringWithFormat:@"%02li:%02li.%03li",
                        // lround(floor(difference / 3600.)) % 100,
                        lround(floor(difference / 60.)) % 60,
                        lround(floor(difference)) % 60,
                        lround(floor(difference * 1000)) % 1000];
    return string;
}

-(void)refreshTimerLabel{
   
    self.timerLabel.text = [self formatTimeString:self.initialTime];
    self.lapLabel.text = [self formatTimeString:self.lapInitialTime];
}


- (IBAction)startButtonTapped:(UIButton *)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.stopwatchTimer setPaused:NO];
        if([self.timerLabel.text isEqualToString:@"00:00.000"]){
            self.initialTime = CACurrentMediaTime();
            self.lapInitialTime = self.initialTime;
        }
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"Lap" forState:UIControlStateNormal];


        NSLog(@"%@", self.startButton.titleLabel.text);
    } else {
        [self.stopwatchTimer setPaused:YES];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"Reset" forState:UIControlStateNormal];
    }
    
}
- (IBAction)lapButtonTapped:(UIButton *)sender {
    if([self.lapButton.titleLabel.text isEqualToString:@"Lap"]){
        self.lapInitialTime = CACurrentMediaTime();
        [self.lapTimes addObject:self.lapLabel.text];
    }
    if([self.lapButton.titleLabel.text isEqualToString:@"Reset"]){
        [self.lapTimes removeAllObjects];
        self.lapLabel.text = @"00:00.000";
        self.timerLabel.text = @"00:00.000";
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
