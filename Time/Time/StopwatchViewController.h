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
    NSTimer *lapTimer;
    NSDate *startDate;
    NSDate *restartDate;
    BOOL running;
    

}

@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapLabel;
@property (weak, nonatomic) IBOutlet UITableView *lapTableView;

- (IBAction)startButton:(id)sender;
- (IBAction)resetButton:(id)sender;


- (void)updateTimer;


@end
