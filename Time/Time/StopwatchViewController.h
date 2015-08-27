//
//  StopwatchViewController.h
//  Time
//
//  Created by Mesfin Bekele Mekonnen on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopWatchViewControllerDelegate.h"

@interface StopwatchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) id<StopWatchViewControllerDelegate> delegate;

@end
