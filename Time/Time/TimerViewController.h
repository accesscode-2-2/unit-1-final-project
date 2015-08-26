//
//  TimerViewController.h
//  Time
//
//  Created by Diana Elezaj on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
@property (nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSInteger remainingTime;

@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@end
