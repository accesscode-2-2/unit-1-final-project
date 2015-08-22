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

@property (nonatomic) NSArray *arr;
@property (strong, nonatomic) IBOutlet UILabel *StopwatchRunningLabel;
@property (nonatomic) NSTimer *startStopwatchTimer;
@property (nonatomic) NSTimer *runStopwatchTimer;
@property (nonatomic) BOOL running;
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *resetLapButton;
@property (strong, nonatomic) IBOutlet UILabel *recentLapRunning;
@property (strong, nonatomic) IBOutlet UITableView *LapTableView;
@property (nonatomic) NSTimer *runningStopWatch;
@property (nonatomic) void *callTheTimer;

@property (nonatomic) NSTimeInterval previousTime;
//@property (nonatomic) NSTimeInterval totalTime;



@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self runningStopWatch] invalidate];
 
    
    self.arr = @[
                 @"one",
                 @"two",
                 @"three"
                 ];
    self.running = false;
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
    
}



- (IBAction)startStopButtonTapped:(UIButton *)sender {
    
  
    //check Label's text
    NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
    if ([startStopActualLabel isEqualToString:@"Start"] && [self.StopwatchRunningLabel.text  isEqualToString : @"0:00.0"]) {
        
        //start timer
        [self callTheTimer];
        self.previousTime = [NSDate timeIntervalSinceReferenceDate];
        self.running = YES;
        
        
        /******  Interface layout *****/
        self.resetLapButton.enabled = YES;
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor redColor];
    }
    
    
    else if ([startStopActualLabel isEqualToString:@"Start"] && ![self.StopwatchRunningLabel.text   isEqualToString : @"0:00.0"]) {
        self.running = YES;
        self.previousTime = [NSDate timeIntervalSinceReferenceDate];
             NSLog (@"BOOM ");
        [[self runningStopWatch] fire];

     }
    
    
    else if ([startStopActualLabel isEqualToString:@"Stop"] ) {
         self.running = NO;
       [[self runningStopWatch] invalidate];

        
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

        
        /******  Interface layout *****/
        self.StopwatchRunningLabel.text = @"0:00.0";
        self.recentLapRunning.text = @"0:00.0";
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.resetLapButton.enabled = YES;
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];

        
        //self.running = NO;
        
}
  else if ([resetLapActualLabel isEqualToString:@"Lap"]) {
      self.running = YES;
      self.previousTime = [NSDate timeIntervalSinceReferenceDate];

      [self callTheTimer];

  }
}



- (void) callTheTimer {
    
    //call the second timer
    self.runStopwatchTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(runningStopWatch:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.runStopwatchTimer forMode:NSRunLoopCommonModes];
}



- (void)runningStopWatch: (NSTimer *)timer{
    if (self.running == YES) {

    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - self.previousTime;
//        NSLog (@"%f currentTime now",currentTime);
//        NSLog (@"%f elapsed now",elapsed);

   // elapsed += self.totalTime;
  
    int mins = (int) (elapsed) / 60.0;
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -=  secs;
    int fraction = elapsed * 10.0;
    
//        
//        NSLog (@"%f currentTime then",currentTime);
//        NSLog (@"%f elapsed then",elapsed);

    self.recentLapRunning.text = [NSString stringWithFormat: @"%d:%02d.%d", mins, secs, fraction];
    self.StopwatchRunningLabel.text = [NSString stringWithFormat: @"%d:%02d.%d", mins, secs, fraction];

    }
    
    
    else if (self.running == NO) {
        [timer invalidate];
        
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
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
