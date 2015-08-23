//
//  StopWatchViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface StopWatchViewController () <UITableViewDataSource, UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *LapTableView;
@property (nonatomic) BOOL LapTapped;
@property (nonatomic) BOOL firstTimeRunning;

@property (nonatomic) NSMutableArray *LapArray;
@property (nonatomic) void *callTheTimer;

@property (strong, nonatomic) IBOutlet UILabel *StopwatchRunningLabel; //timerLabel
@property (strong, nonatomic) IBOutlet UILabel *recentLapRunning;

@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *resetLapButton;

@property (nonatomic) NSTimer *runningStopWatch;  //timer
@property (nonatomic) NSTimer *LapTimer;   //
@property (nonatomic) NSTimer *runStopwatchTimer;
@property (nonatomic) NSDate *startTime;  //
@property (nonatomic) NSDate *lapStartTime;  //



@property (nonatomic) NSTimeInterval totalSessionTime;  //
@property (nonatomic) NSTimeInterval totalTime;    //
@property (nonatomic) NSTimeInterval distance;

@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self runningStopWatch] invalidate];
 
    self.LapArray = [[NSMutableArray alloc]init];
    
    self.LapTableView.dataSource = self;
    self.LapTableView.delegate = self;
    
    
    
    
    
    [self.LapArray addObject:@"90"];
    [self.LapArray addObject:@"40"];
    
    /******  Interface layout *****/
    [self.startStopButton.titleLabel  isEqual: @"Start"];
    self.startStopButton.layer.cornerRadius = 10;
    self.startStopButton.clipsToBounds = YES;
    self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    
    [self.resetLapButton.titleLabel  isEqual: @"Reset"];
    self.resetLapButton.layer.cornerRadius = 10;
    self.resetLapButton.clipsToBounds = YES;
    self.resetLapButton.backgroundColor = [UIColor grayColor];
    self.resetLapButton.enabled = NO;
    
   // self.LapTableView.backgroundColor = [UIColor grayColor];
    self.LapTapped = NO;
}

- (void)timerFired:(NSTimer *)runningStopWatch {
    
    // get the current time
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.startTime];
    self.distance =  self.totalTime + self.totalSessionTime;
    
    self.StopwatchRunningLabel.text = [NSString stringWithFormat:@"%0.2f", self.distance];
    NSLog(@"%f", self.distance);
    
}

- (void)timerLapFired:(NSTimer *)LapTimer {
    
    // get the current time
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.lapStartTime];
    self.distance =  self.totalTime + self.totalSessionTime;
    
 
    if (self.LapTapped == NO)
        self.recentLapRunning.text = [NSString stringWithFormat:@"%0.2f", self.distance];
    else if (self.LapTapped == YES)
        self.recentLapRunning.text = [NSString stringWithFormat:@"%0.2f", self.totalSessionTime];
 
}


#pragma mark - Buttons

- (IBAction)startStopButtonTapped:(UIButton *)sender {
    
    self.lapStartTime = [[NSDate alloc] init];

    //check Label's text
    NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
    if ([startStopActualLabel isEqualToString:@"Start"] ) {
      
        // set self.startTime to now
        self.startTime = [[NSDate alloc] init];
        
        // setup timer
        self.runningStopWatch = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        // add timer to the run loop
        [[NSRunLoop currentRunLoop] addTimer:self.runningStopWatch forMode:NSRunLoopCommonModes];
        
        
        
        
        
 
        // setup timer
        self.LapTimer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerLapFired:) userInfo:nil repeats:YES];
        
        // add timer to the run loop
        [[NSRunLoop currentRunLoop] addTimer:self.LapTimer forMode:NSRunLoopCommonModes];
        
        
        

        
        /******  Interface layout *****/
        self.resetLapButton.enabled = YES;
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor redColor];
   

     }
    
    
    else if ([startStopActualLabel isEqualToString:@"Stop"] ) {
        
        // keep track of the total amount of time that this stopwatch has been running
        self.totalTime = self.totalTime + self.totalSessionTime;
        
        // stop the timer
        [self.runningStopWatch invalidate];
        [self.LapTimer invalidate];
        /******  Interface layout *****/
        [self.resetLapButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];

    }

}




- (IBAction)resetLapButtonTapped:(UIButton *)sender {
    NSString *resetLapActualLabel =  self.resetLapButton.titleLabel.text;
    if ([resetLapActualLabel isEqualToString:@"Reset"]) {
        
        [[self runningStopWatch] invalidate];
        self.totalSessionTime = 0;
        self.totalTime = 0;
        
        /******  Interface layout *****/
        self.StopwatchRunningLabel.text = @"0:00.0";
        self.recentLapRunning.text = @"0:00.0";
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.resetLapButton.enabled = YES;
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];

        
        
}
  else if ([resetLapActualLabel isEqualToString:@"Lap"]) {
      self.lapStartTime = [[NSDate alloc] init];

      self.LapTapped = YES;
     [[self LapTimer] invalidate];
      
      // setup timer
      self.LapTimer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerLapFired:) userInfo:nil repeats:YES];
      
      // add timer to the run loop
      [[NSRunLoop currentRunLoop] addTimer:self.LapTimer forMode:NSRunLoopCommonModes];
      
      self.LapTapped = NO;

  }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.LapArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.LapArray[indexPath.row];
    return cell;
}
//
//
//- (void) callTheTimer {
//    
//    //call the second timer
//    self.runStopwatchTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(runningStopWatch:) userInfo:nil repeats:YES];
//    
//    [[NSRunLoop currentRunLoop] addTimer:self.runStopwatchTimer forMode:NSRunLoopCommonModes];
//}
//
//
//
//- (void)runningStopWatch: (NSTimer *)timer{
//    if (self.running == YES) {
//
//    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
//    NSTimeInterval elapsed = currentTime - self.totalSessionTime;
//        self.totalTime += elapsed;
//        
//        self.totalSessionTime = currentTime;
////        NSLog (@"%f currentTime now",currentTime);
////        NSLog (@"%f elapsed now",elapsed);
//
//   // elapsed += self.totalTime;
//  
////    int mins = (int) (elapsed) / 60.0;
////    elapsed -= mins * 60;
////    int secs = (int) (elapsed);
////    elapsed -=  secs;
////    int fraction = elapsed * 10.0;
//        
////        NSTimeInterval seconds = fmod(self.totalTime, 60.0);
////        NSTimeInterval minutes = floor(self.totalTime / 60.0);
////        NSTimeInterval fraction = floor(self.totalTime / 10.0);
//
//        NSTimeInterval minutes = floor(self.totalTime / 60.0);
//        NSTimeInterval seconds = fmod(self.totalTime, 60.0);
//       // NSTimeInterval fraction = floor(self.totalTime/10 );
//        
//        
//        
////        NSLog (@"%f currentTime then",currentTime);
////        NSLog (@"%f elapsed then",elapsed);
//
//        NSLog(@"%f: %f",  minutes,  seconds);
//        //this works
////    self.StopwatchRunningLabel.text = [NSString stringWithFormat: @"%2f%2f%2f", minutes,  seconds,  fraction];
//        self.StopwatchRunningLabel.text = [NSString stringWithFormat: @"%02g:%02g", minutes,  seconds];
//
//        
//        
////    self.recentLapRunning.text = [NSString stringWithFormat: @"%d:%02d.%d", mins, secs, fraction];
////    self.StopwatchRunningLabel.text = [NSString stringWithFormat: @"%d:%02d.%d", mins, secs, fraction];
//
//    }
//    
//    
//    else if (self.running == NO) {
//        [timer invalidate];
//        
//    }
//    
//
//}
//


@end
