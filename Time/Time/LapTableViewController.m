//
//  LapTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "LapTableViewController.h"

@interface LapTableViewController ()
@property (nonatomic) UIColor *pink;
@property (nonatomic) UIColor *green;
@end

@implementation LapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lapTimes = [[NSMutableArray alloc]init];
    self.pink = [UIColor colorWithRed:255.0/255 green:128.0/255 blue:169.0/255 alpha:1.0];
    self.green = [UIColor colorWithRed:198.0/255 green:230.0/255 blue:204.0/255 alpha:1.0];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - StopWatchViewControllerDelegate implementation
- (NSString *)currentLapTime:(NSString *)lapTime {
    [self.lapTimes addObject:lapTime];
    [self.tableView reloadData];
    NSLog(@"%@",self.lapTimes);
    return lapTime;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lapTimes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lapIdentifier"];
    
    if (cell == nil) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:@"lapIdentifier"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.lapTimes count] - indexPath.row];
    cell.detailTextLabel.text = self.lapTimes[[self.lapTimes count] - 1 - indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = self.green;
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }

    cell.textLabel.textColor = self.pink;
    cell.textLabel.highlightedTextColor = self.pink;
    cell.detailTextLabel.textColor = self.pink;
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Orbitron-Regular" size:20]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"DigitalReadoutExpUpright" size:20]];
}

@end
