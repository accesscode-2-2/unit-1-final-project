//
//  EventCountdownViewController.h
//  StopWatch
//
//  Created by Natalia Estrella on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCountdownViewController : UIViewController

@property (nonatomic) Event *event;
@property (nonatomic) NSDateFormatter *dateFormatter;

@end
