//
//  StopWatchViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchViewController.h"

@interface StopWatchViewController () <UITableViewDataSource, UITabBarDelegate>

@property (nonatomic) NSArray *arr;
@property (strong, nonatomic) IBOutlet UILabel *StopwatchRunningLabel;
@property (nonatomic) NSTimer *startStopwatchTimer;
@property (nonatomic) NSTimer *runStopwatchTimer;
@property (nonatomic) BOOL running;


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
    
    self.startStopwatchTimer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(callTheTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startStopwatchTimer forMode:NSRunLoopCommonModes];
}


- (void)callTheTimer: (NSTimer *)timer{
    
    
    
    //call the second timer
    self.runStopwatchTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(stopWatch:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.runStopwatchTimer forMode:NSRunLoopCommonModes];
}


- (void)stopWatch: (NSTimer *)timer{
    
    CGFloat currentNumber = [self.StopwatchRunningLabel.text floatValue];
    CGFloat nextNumber = currentNumber + 0.000001;
    
    self.StopwatchRunningLabel.text = [NSString stringWithFormat:@"%f", nextNumber];

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
