//
//  StopWatchTabBarController.h
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopWatchTabBarController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *timerDisplay;
@property (strong, nonatomic) IBOutlet UILabel *lapTimerLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *lapButton;
@property (nonatomic) BOOL timerIsRunning; // this will start/stop timer
- (IBAction)startPauseButton:(id)sender;
- (IBAction)lapButton:(id)sender;


@end
