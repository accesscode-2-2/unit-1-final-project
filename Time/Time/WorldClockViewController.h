//
//  WorldClockViewController.h
//  Time
//
//  Created by Chris David on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorldClockViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *worldClockLabel;
@property (nonatomic) BOOL running;
@property (nonatomic) NSDate *startDate;

-(void)worldClockTimer: (NSTimer *) timer;

@end
