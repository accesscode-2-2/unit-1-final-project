//
//  NewWorldClockTableViewController.m
//  Time
//
//  Created by Chris David on 8/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewWorldClockTableViewController.h"
#import "WorldClockInfo.h"
#import "WorldClockTableViewController.h"

@interface NewWorldClockTableViewController ()
@property (nonatomic) NSArray *keyArray;
@property (nonatomic) NSArray *valueArray;

@property (nonatomic) NSString* city ;
@property (nonatomic) NSString* time;

@property (nonatomic) NSMutableDictionary *clock;
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation NewWorldClockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Add City"];
    
    
    self.clock = [[NSMutableDictionary alloc] init];
    self.searchResults = [[NSArray alloc] init];
    self.keyArray = [[NSArray alloc] init];
    
    
    ////// trying to get current time
    NSDate * now = [NSDate date];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    
    NSString *NYTimeString = [outputFormatter stringFromDate:now];
    
    NSDate *parisTime = [now dateByAddingTimeInterval:21600]; // Add XXX seconds to *now
    NSString *ParisTimeString = [outputFormatter stringFromDate:parisTime];
    
    
    NSDate *RomeTime = [now dateByAddingTimeInterval:21600];
    NSString *RomeTimeString = [outputFormatter stringFromDate:RomeTime];
    
    
    NSDate *Seattle = [now dateByAddingTimeInterval:-3600];
    NSString *SeattleTimeString = [outputFormatter stringFromDate:Seattle];
    
    
    
    NSDate *NewJersey = [now dateByAddingTimeInterval:34200];
    NSString *NewJerseyTimeString = [outputFormatter stringFromDate:NewJersey];
    
    
    
    
    
    
    [self.clock setObject:NewJerseyTimeString forKey:@"New Jersey"];
    [self.clock setObject:SeattleTimeString forKey:@"Seattle"];
    [self.clock setObject:NYTimeString forKey:@"New York"];
    [self.clock setObject:RomeTimeString forKey:@"Rome, Italy"];
    [self.clock setObject:ParisTimeString forKey:@"Paris, France"];
    
    
    self.keyArray = [self.clock allKeys];
    self.valueArray = [self.clock allValues];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else
        return [self.keyArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"NewWorldClockIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
    }
    else {
        [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
       
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ %@", self.keyArray[(long)indexPath.row], self.valueArray[(long)indexPath.row] ); // you can see
    
    
    WorldClockInfo *city = [[WorldClockInfo alloc] init];
    city.cityName = self.keyArray[indexPath.row];
    city.cityTime = self.valueArray[indexPath.row];
    
    WorldClockInfo *citySelected = [[WorldClockInfo alloc] init];
    city.cityName = self.searchResults[indexPath.row];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self.selectedCitiesArray  addObject: citySelected];
        
    }
    else {
        [self.selectedCitiesArray addObject:city ];
        // [self.clock removeObjectForKey:city.cityName];
    }
    
    [[self navigationController] popViewControllerAnimated:YES];
    [self.tableView reloadData];
    
}
-(void) filterContentForSearchText: (NSString *)searchText scope:(NSString *)scope{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    
    self.searchResults = [self.keyArray filteredArrayUsingPredicate:predicate];
}


-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = indexPath.row % 2
    ? [UIColor colorWithRed:0.87 green:0.93 blue:0.98 alpha:1.0]
    : [UIColor whiteColor];
    
}

@end
