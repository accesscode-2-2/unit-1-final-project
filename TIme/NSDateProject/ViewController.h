//
//  ViewController.h
//  NSDateProject
//
//  Created by MacMan on 9/1/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController


@property (strong,nonatomic)NSMutableArray *laps;
@property(strong,nonatomic)ViewController *viewController;

@property (weak, nonatomic) IBOutlet UITableView *lapTableView;






@property (weak,atomic) NSTimer *DontStopWatch;

@property (strong,atomic) NSDate *currentDate;
@property (strong,atomic) NSDate *startDate;
@property (strong,atomic) NSDate *timerDate;


@property (strong,atomic) NSDateFormatter *dateFormatter;
@property (strong,atomic) NSString *timeString;

@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *lapResetButton;


- (IBAction)startStopButtonAction:(id)sender;
- (IBAction)lapResetButtonAction:(id)sender;

@end

