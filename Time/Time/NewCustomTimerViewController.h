//
//  NewCustomTimerViewController.h
//  Time
//
//  Created by Christian Maldonado on 8/26/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PresetTimersViewController;

@interface NewCustomTimerViewController : UIViewController

@property (nonatomic, weak) PresetTimersViewController *timerViewController;
@property (nonatomic) NSMutableDictionary *customTimersDictionary;

@end
