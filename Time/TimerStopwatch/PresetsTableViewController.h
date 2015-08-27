//
//  PresetsTableViewController.h
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/26/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPresetsViewControllerDelegate.h"
#import "PresetsTableViewControllerDelegate.h"

@interface PresetsTableViewController : UITableViewController <NewPresetsViewControllerDelegate>
@property (nonatomic) id<PresetsTableViewControllerDelegate> delegate;
@end