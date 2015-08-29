//
//  stopwatchVC.h
//  StopWatch
//
//  Created by MacMan on 8/26/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

int countNumber0;
int countNumber1;
int countNumber2;


@interface stopwatchVC : UIViewController

@property (strong,nonatomic)NSMutableArray *laps;
@property (weak,nonatomic) NSTimer *KNTimer;
@property int currentTimeInSeconds;

@property (weak, nonatomic) IBOutlet UITableView *lapTableView;

@property (weak, nonatomic) IBOutlet UILabel *timerDisplay0;
@property (weak, nonatomic) IBOutlet UILabel *timerDisplay1;
@property (weak, nonatomic) IBOutlet UILabel *timerDisplay2;
@property (weak, nonatomic) IBOutlet UILabel *centerTimerDisplayLabel;


@property (weak, nonatomic) IBOutlet UIButton *lapResetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

- (IBAction)lapResetButtonAction:(id)sender;
- (IBAction)startStopButtonAction:(id)sender;





@end
















