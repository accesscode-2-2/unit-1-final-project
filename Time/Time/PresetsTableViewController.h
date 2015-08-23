//
//  PresetsTableViewController.h
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetsTableViewControllerDelegate.h"

@interface PresetsTableViewController : UITableViewController
@property (nonatomic) id<PresetsTableViewControllerDelegate> delegate;
@end
