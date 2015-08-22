//
//  StopWatchTabBarController.h
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopWatchTabBarController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timerLabel; // drag in label to create property
@property (nonatomic) BOOL timerIsRunning;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) float *savedTime;

@end
