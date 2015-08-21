//
//  StopwatchViewController.h
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopwatchViewController : UIViewController {

    __weak IBOutlet UILabel *stopwatchLabel;
    NSTimer *stopTimer;
    NSDate *startDate;
    BOOL running;
    

}

@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;

- (IBAction)startButton:(id)sender;
- (IBAction)stopButton:(id)sender;

- (void)updatetimer;
@end
