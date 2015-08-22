//
//  StopWatchTabBarController.h
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopWatchTabBarController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *timerDisplay;
@property (nonatomic) BOOL timerIsRunning; // this will start/stop timer
- (IBAction)startPauseButton:(id)sender;


@end
