//
//  DetailViewController.h
//  Time
//
//  Created by Artur Lan on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetTableViewController.h"
#import "PresetTime.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameYourTask;
@property (weak, nonatomic) IBOutlet UITextField *yourTime;
@property (nonatomic) PresetTime * model;

@property (nonatomic) NSMutableDictionary *personalTimer;

@property (nonatomic, weak) PresetTableViewController *previousViewController;


@end
