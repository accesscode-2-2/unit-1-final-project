//
//  StopwatchVC.h
//  StopWatch
//
//  Created by Natalia Estrella on 8/23/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopwatchVC : UIViewController

@property (nonatomic) NSTimer *timer;

@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSTimeInterval totalSessionTime;
@property (nonatomic) NSTimeInterval totalTime;

@property (nonatomic) NSTimer *lapTimer;
@property (nonatomic) NSDate * startLapTime;
@property (nonatomic) NSTimeInterval totalLapTime;



@property (weak, nonatomic) IBOutlet UITableView *lapsTableView;



@end
