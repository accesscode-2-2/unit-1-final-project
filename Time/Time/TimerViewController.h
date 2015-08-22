//
//  TimerViewController.h
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController {
    
    
    
    __weak IBOutlet UILabel *timerLabel;
    NSTimer *timer;
    NSDate *startTime;
    BOOL countDown;
}

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)timerStartButton:(id)sender;
- (IBAction)timerStopButton:(id)sender;


@end
