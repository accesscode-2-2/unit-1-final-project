//
//  LapTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "LapTableViewController.h"

@interface LapTableViewController ()
@property (nonatomic) NSMutableArray *lapTimes;
@end

@implementation LapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lapTimes = [[NSMutableArray alloc]init];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lapIdentifier"];//] forIndexPath:indexPath];
    
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
    //    cell.backgroundColor = [UIColor blackColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Orbitron-Regular" size:15];
    cell.detailTextLabel.font = [UIFont fontWithName:@"DigitalReadoutExpUpright" size:19];
    cell.detailTextLabel.textColor = [UIColor blackColor];
}

@end
