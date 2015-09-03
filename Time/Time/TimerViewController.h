//
//  TimerViewController.h
//  Time
//
//  Created by Artur Lan on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray *timers;

@property(nonatomic,retain) IBOutlet UITableView *tableView;


@end
