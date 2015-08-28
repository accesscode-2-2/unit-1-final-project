//
//  LapTableViewController.h
//  Time
//
//  Created by Elber Carneiro on 8/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopWatchViewControllerDelegate.h"

@interface LapTableViewController : UITableViewController<StopWatchViewControllerDelegate>

@property (nonatomic) NSMutableArray *lapTimes;

@end
