//
//  LapTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "LapTableViewController.h"

@interface LapTableViewController ()

@end

@implementation LapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lapTimes = [[NSMutableArray alloc]init];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
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
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:198.0/255 green:230.0/255 blue:204.0/255 alpha:1.0];
    cell.selectedBackgroundView = selectionColor;
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.lapTimes count] - indexPath.row];
    cell.detailTextLabel.text = self.lapTimes[[self.lapTimes count] - 1 - indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lapIdentifier"];
    
    if (cell == nil) {
        
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:@"lapIdentifier"];
        
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor] ;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //    cell.backgroundColor = [UIColor blackColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor colorWithRed:255.0/255 green:128.0/255 blue:169.0/255 alpha:1.0 ];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:255.0/255 green:128.0/255 blue:169.0/255 alpha:1.0 ];
    cell.detailTextLabel.textColor =  [UIColor colorWithRed:255.0/255 green:128.0/255 blue:169.0/255 alpha:1.0 ];
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Orbitron-Regular" size:20]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"DigitalReadoutExpUpright" size:20]];
}

@end
