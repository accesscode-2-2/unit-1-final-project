//
//  PresetsTableViewController.h
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetsTableViewControllerDelegate.h"
#import "NewPresetViewControllerDelegate.h"

@interface PresetsTableViewController : UITableViewController <NewPresetViewControllerDelegate>
@property (nonatomic) id<PresetsTableViewControllerDelegate> delegate;
@end
