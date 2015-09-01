//
//  TimerViewController.h
//  StopWatch
//
//  Created by Natalia Estrella on 8/31/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSTimeInterval totalSessionTime;
@property (nonatomic) NSTimeInterval totalTime;



@end
