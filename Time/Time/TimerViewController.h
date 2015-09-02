//
//  TimerViewController.h
//  Time
//
//  Created by Artur Lan on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PresetTime.h"

@interface TimerViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray *timers;

@property(nonatomic,retain) UITableView *tableView;


@end
