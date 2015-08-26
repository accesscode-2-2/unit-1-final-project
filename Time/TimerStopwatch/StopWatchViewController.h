//
//  ViewController.h
//  BereketsStopWatch2.0
//
//  Created by Bereket  on 8/25/15.
//  Copyright (c) 2015 Bereket . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *TimeLabel; //label that shows the time

@property (strong, nonatomic) IBOutlet UITableView *lapsTableView; //table View that holds current laps

@property (nonatomic) NSTimer* timer;
@property (nonatomic) NSDate* startTime;

@property (nonatomic) NSTimeInterval totalSessonTime;  //records the time between each "Start and "Pause."
@property (nonatomic) NSTimeInterval totalTime;        //adds the total time between all session times.


//---------------------------------------------------------------------------
//The properties below are tied to the buttons on the stopwatch
@property (strong, nonatomic) IBOutlet UIButton *StartTimer;
@property (strong, nonatomic) IBOutlet UIButton *PauseTimer;
@property (strong, nonatomic) IBOutlet UIButton *ResetTimer;
@property (strong, nonatomic) IBOutlet UIButton *AddLappToTableView;
//----------------------------------------------------------------------------



//---------------------------------------------------------------------------

//Mutable array to store laps when "Add Lap" button is pushed.
@property (nonatomic, strong) NSMutableArray* LapsArray;

//---------------------------------------------------------------------------




@end

