//
//  TimerDetailViewController.h
//  TimerStopwatch
//
//  Created by Bereket  on 9/2/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetTimer.h"
#import "PresetTimersSingleton.h"
@interface TimerDetailViewController : UIViewController



@property (strong, nonatomic) IBOutlet UILabel *detailTimeLabel;

@property (strong, nonatomic) IBOutlet UIButton *startDetailTime;

@property (strong, nonatomic) IBOutlet UIButton *pauseDetailTime;

@property (nonatomic) PresetTimer* presetTimer;

@property (nonatomic) NSDate* startNow;


@property (nonatomic) NSTimeInterval totalSessonTime;  //records the time between each "Start and "Pause."
@property (nonatomic) NSTimeInterval totalTime;        //adds the total time between all session times.

@end
