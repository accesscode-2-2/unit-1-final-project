//
//  PresetTimersViewController.m
//  Time
//
//  Created by Lauren Caponong on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimersViewController.h"


@interface PresetTimersViewController ()
//<ViewControllerDelegate>


@property (nonatomic) NSTimer *countDownTimer;
@property (nonatomic) NSInteger totalSeconds;
@property (nonatomic) NSMutableDictionary *customTimersDictionary;

@end

@implementation PresetTimersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.totalSeconds = 120;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];

    
    self.customTimersDictionary = [[NSMutableDictionary alloc] init];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", self.customTimersDictionary);
}


- (IBAction)addTimerButtonTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewCustomTimerViewController *newPresetVC = [storyboard instantiateViewControllerWithIdentifier:@"newPresetVC"];
    
    
    newPresetVC.customTimersDictionary = self.customTimersDictionary;
    
    [self presentViewController:newPresetVC animated:YES completion:nil];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // set the timerViewController property on the destination view controller to be self
    
}

-(void)timer {
    self.totalSeconds = self.totalSeconds - 1;
    NSLog(@"%ld", (long)self.totalSeconds);
//    timerLabel.text = [self timeFormatted:totalSeconds];
    if (self.totalSeconds == 0) {
        [self.countDownTimer invalidate];
    }
}

//- (void) newCustomTimeViewController:(NewCustomViewController *)customVC didAddTimerWithHours:(NSInteger)hours minutes:(NSInteger)minutes name:(NSString *)alarmName {
    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
