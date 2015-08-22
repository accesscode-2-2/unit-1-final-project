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
@property (strong, nonatomic) IBOutlet UIButton *startResetButton;
@property (strong, nonatomic) IBOutlet UIButton *stopLapButton;


@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arr = @[
                 @"one",
                 @"two",
                 @"three"
                 ];
    self.running = false;
    
    
    self.startResetButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.startResetButton.clipsToBounds = YES;
    self.startResetButton.backgroundColor = [UIColor greenColor];
    
    
    self.stopLapButton.layer.cornerRadius = 10;
    self.stopLapButton.clipsToBounds = YES;
    self.stopLapButton.backgroundColor = [UIColor grayColor];
    self.stopLapButton.enabled = NO;
    
    
    
}

- (IBAction)startResetButtonAction:(UIButton *)sender {
    
    self.running = YES;
         //start timer
        self.startStopwatchTimer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(callTheTimer:) userInfo:nil repeats:NO];
        
        [[NSRunLoop currentRunLoop] addTimer:self.startStopwatchTimer forMode:NSRunLoopCommonModes];
        
        
        
    
}


- (IBAction)stopLapButtonAction:(UIButton *)sender {
    self.running = NO;
}




- (void)callTheTimer: (NSTimer *)timer{
    
    
    
    //call the second timer
    self.runStopwatchTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(runningStopWatch:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.runStopwatchTimer forMode:NSRunLoopCommonModes];
}


- (void)runningStopWatch: (NSTimer *)timer{
    
    CGFloat currentNumber = [self.StopwatchRunningLabel.text floatValue];
    CGFloat nextNumber = currentNumber + 0.000001;
    
    self.StopwatchRunningLabel.text = [NSString stringWithFormat:@"%f", nextNumber];
    
    
    if (self.running == NO) {
        [timer invalidate];
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
