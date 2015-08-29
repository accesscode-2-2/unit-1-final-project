//
//  PresetTimerTableViewController.h
//  Time
//
//  Created by Felicia Weathers on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerData.h"

@interface PresetTimerTableViewController : UITableViewController


@property (nonatomic) TimerData *selectedPreset;

- (IBAction)backButton:(id)sender;

- (IBAction)addButton:(id)sender;

@property (nonatomic) UIViewController *timerVC;



@end
