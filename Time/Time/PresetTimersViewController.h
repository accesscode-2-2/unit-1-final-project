//
//  PresetTimersViewController.h
//  Time
//
//  Created by Lauren Caponong on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewCustomTimerViewController.h"


@protocol ViewControllerDelegate

- (void) updateAlarmLabel;

@end


@interface PresetTimersViewController : UIViewController

@property (nonatomic, retain) id <ViewControllerDelegate> ViewControllerDelegate;


@end

