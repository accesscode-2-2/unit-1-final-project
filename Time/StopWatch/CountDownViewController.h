//
//  CountDownViewController.h
//  StopWatch
//
//  Created by Krishna Picart on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

int days = 365.242;
int hours = 24;
int minutes= 60;
int seconds = 60;
int millisecond = 1000;


@interface CountDownViewController : UIViewController


@property (strong,nonatomic)NSMutableArray *countDownArray;

@property (weak,nonatomic) NSTimer *countDownTimer;

@property (weak, nonatomic) IBOutlet UITableView *countDownTableView;




@property (weak, nonatomic) IBOutlet UILabel *countDownDisplayLabel2;

@property (weak, nonatomic) IBOutlet UILabel *countDownDisplayLabel1;

@property (weak, nonatomic) IBOutlet UILabel *countDownDisplayLabel0;



@property (weak, nonatomic) IBOutlet UIButton *countDownStartButton;

@property (weak, nonatomic) IBOutlet UIButton *countDownResetButton;

//@property (weak, nonatomic) IBOutlet UIButton *countDownStopButton;




//- (IBAction)countDownStopButtonAction:(id)sender;

- (IBAction)countDownResetButtonAction:(id)sender;


- (IBAction)countDownStartButtonAction:(id)sender;





@end
