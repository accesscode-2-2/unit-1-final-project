//
//  StopwatchViewController.h
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>

@interface StopwatchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>



    
@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapLabel;
@property (weak, nonatomic) IBOutlet UITableView *lapTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

- (IBAction)startButton:(id)sender;
- (IBAction)resetButton:(id)sender;


- (void)updateTimer;
- (void)rememberTimer; 


@end
