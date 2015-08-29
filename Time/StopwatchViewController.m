//
//  StopwatchViewController.m
//  Time
//
//  Created by Lauren Caponong on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"

@interface StopwatchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *stopwatchTimerLabel;

@property (weak, nonatomic) IBOutlet UIButton *startButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *pauseButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *lapButtonTapped;

@property (weak, nonatomic) IBOutlet UIButton *resetButtonTapped;


@property (nonatomic) float nextNumber;
@property (nonatomic) float currentNumber;

@property (nonatomic) NSTimer *timer1;

@property (weak, nonatomic) IBOutlet UITableView *lapsTableView;
@property (nonatomic) NSMutableArray *laps;
@property (nonatomic) float currentLapTime;

@end




@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.laps = [[NSMutableArray alloc] init];
    self.lapsTableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startButtonTapped:(id)sender {
    
    [self.timer1 invalidate];
    
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(startButtonTapped:) userInfo:nil repeats:NO];
    
    float currentNumber = [self.stopwatchTimerLabel.text floatValue];
    self.nextNumber = currentNumber + 0.001;
    self.stopwatchTimerLabel.text = [NSString stringWithFormat:@"%lf", self.nextNumber];
    
}


- (IBAction)pauseButtonTapped:(id)sender {
    
    [self.timer1 invalidate];
    
    
    
    
}


- (IBAction)lapButtonTapped:(id)sender {
    
    NSString *currentLapTime = self.stopwatchTimerLabel.text;
    
    [self.laps addObject:currentLapTime];
    
    [self.lapsTableView reloadData];
    
}


    
    
- (IBAction)resetButtonTapped:(id)sender {
    
    self.currentNumber = 0;
    
    self.stopwatchTimerLabel.text = [NSString stringWithFormat:@"0"];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.laps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"LapCellIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.laps[indexPath.row];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lap %ld", (long)indexPath.row];
    
    return cell;
}



@end
