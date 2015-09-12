

//
//  WorldClockAddTableViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "WorldClockAddTableViewController.h"
#import "WorldClockTableViewController.h"
#import "WorldClockInfo.h"

@interface WorldClockAddTableViewController ()
@property (nonatomic) NSArray *keyArray;
@property (nonatomic) NSArray *unsortedKeyArray;
@property (nonatomic) NSArray *valueArray;

@property (nonatomic) NSString* city ;
@property (nonatomic) NSString* time;

@property (nonatomic) NSMutableDictionary *clock;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation WorldClockAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Add City"];
    
    
    self.clock = [[NSMutableDictionary alloc] init];
    self.searchResults = [[NSArray alloc] init];
    self.keyArray = [[NSArray alloc] init];
    self.unsortedKeyArray = [[NSArray alloc] init];

    
    ////// trying to get current time
    NSDate * now = [NSDate date];
  
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
   
    NSString *NYTimeString = [outputFormatter stringFromDate:now];
    
    NSDate *parisTime = [now dateByAddingTimeInterval:21600]; // Add XXX seconds to *now
    NSString *ParisTimeString = [outputFormatter stringFromDate:parisTime];
    
    
    NSDate *RomeTime = [now dateByAddingTimeInterval:21600];
    NSString *RomeTimeString = [outputFormatter stringFromDate:RomeTime];
    
    
    NSDate *MexicoCity = [now dateByAddingTimeInterval:-3600];
    NSString *MexicoCityTimeString = [outputFormatter stringFromDate:MexicoCity];
    
    
    
    NSDate *NewDelhi = [now dateByAddingTimeInterval:34200];
    NSString *NewDelhiTimeString = [outputFormatter stringFromDate:NewDelhi];
 
    NSDate *RioDeJaneiro = [now dateByAddingTimeInterval:3600];
    NSString *RioDeJaneiroTimeString = [outputFormatter stringFromDate:RioDeJaneiro];
	
	NSDate *Tokyo = [now dateByAddingTimeInterval:46800];
	NSString *TokyoString = [outputFormatter stringFromDate:Tokyo];
	
	NSDate *Delhi = [now dateByAddingTimeInterval:27000];
	NSString *DelhiString = [outputFormatter stringFromDate:Delhi];
	
	NSDate *Winnipeg = [now dateByAddingTimeInterval:3600];
	NSString *WinnipegString = [outputFormatter stringFromDate:Winnipeg];
	
	NSDate *Berlin = [now dateByAddingTimeInterval:46800];
	NSString *BerlinString = [outputFormatter stringFromDate:Berlin];
	
	NSDate *Kyoto = [now dateByAddingTimeInterval:46800];
	NSString *KyotoString = [outputFormatter stringFromDate:Kyoto];
	
	NSDate *Mogadishu = [now dateByAddingTimeInterval:25200];
	NSString *MogadishuString = [outputFormatter stringFromDate:Mogadishu];
	
	NSDate *Copenhagen = [now dateByAddingTimeInterval:21600];
	NSString *CopenhagenString = [outputFormatter stringFromDate:Copenhagen];
	
	NSDate *TheMoon = [now dateByAddingTimeInterval:14400];
	NSString *TheMoonString = [outputFormatter stringFromDate:TheMoon];
	
	NSDate *Lincoln = [now dateByAddingTimeInterval:-3600];
	NSString *lincolnString = [outputFormatter stringFromDate:Lincoln];
	
	NSDate *Hanoi = [now dateByAddingTimeInterval:39600];
	NSString *HanoiString = [outputFormatter stringFromDate:Hanoi];
	
	NSDate *Halifax = [now dateByAddingTimeInterval:3600];
	NSString *HalifaxString = [outputFormatter stringFromDate:Halifax];
	
	NSDate *AbuDhabi = [now dateByAddingTimeInterval:28800];
	NSString *AbuDhabiString = [outputFormatter stringFromDate:AbuDhabi];
	
	NSDate *Montreal = [now dateByAddingTimeInterval:46800];
	NSString *MontrealString = [outputFormatter stringFromDate:Montreal];
	
	NSDate *Vancouver = [now dateByAddingTimeInterval:-10800];
	NSString *VancouverString = [outputFormatter stringFromDate:Vancouver];
	
	NSDate *Stockholm = [now dateByAddingTimeInterval:21600];
	NSString *StockholmString = [outputFormatter stringFromDate:Stockholm];
	
	NSDate *London = [now dateByAddingTimeInterval:18000];
	NSString *LondonString = [outputFormatter stringFromDate:London];
	
	
	
	
 
    
    [self.clock setObject:NewDelhiTimeString forKey:@"New Delhi, India"];
    [self.clock setObject:MexicoCityTimeString forKey:@"Mexico City"];
    [self.clock setObject:NYTimeString forKey:@"New York, NY"];
    [self.clock setObject:RomeTimeString forKey:@"Rome, Italy"];
    [self.clock setObject:ParisTimeString forKey:@"Paris, France"];
    [self.clock setObject:RioDeJaneiroTimeString forKey:@"Rio de Janeiro, Brazil"];
    [self.clock setObject:NYTimeString forKey:@"Philadelphia"];
	[self.clock setObject:TokyoString forKey:@"Tokyo, Japan"];
	[self.clock setObject:DelhiString forKey:@"Delhi, India"];
	[self.clock setObject:WinnipegString forKey:@"Winnipeg, Canada"];
	[self.clock setObject:BerlinString forKey:@"Berlin, Germany"];
	[self.clock setObject:KyotoString forKey:@"Kyoto, Japan"];
	[self.clock setObject:MogadishuString forKey:@"Mogadishu,Somalia"];
	[self.clock setObject:CopenhagenString forKey:@"Copenhagen, Denmark"];
	[self.clock setObject:TheMoonString forKey:@"The Moon"];
	[self.clock setObject:lincolnString forKey:@"Lincoln, Nebraska"];
	[self.clock setObject:HanoiString forKey:@"Hanoi, Vietnam"];
	[self.clock setObject:HalifaxString forKey:@"Halifax, Nova Scotia"];
	[self.clock setObject:AbuDhabiString forKey:@"Abu Dhabi, U.A.E"];
	[self.clock setObject:MontrealString forKey:@"Montreal, Québec"];
	[self.clock setObject:VancouverString forKey:@"Vancouver, Canada"];
	[self.clock setObject:StockholmString forKey:@"Stockholm, Sweden"];
	[self.clock setObject:LondonString forKey:@"London, England"];
	
	
	
	
	
	
	
	
	
	
    
    
    self.unsortedKeyArray = [self.clock allKeys];
    self.keyArray = [self.unsortedKeyArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.valueArray = [self.clock allValues];

 
    
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     // Return the number of rows in the section.
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else
        return [self.keyArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"WorldClockAddIdentifier";

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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ %@", self.keyArray[(long)indexPath.row], self.valueArray[(long)indexPath.row] ); // you can see
    
    WorldClockInfo *city = [[WorldClockInfo alloc] init];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        city.cityName = self.searchResults[indexPath.row];
        city.cityTime = self.clock[city.cityName];
    } else {
        city.cityName = self.keyArray[indexPath.row];
        city.cityTime = self.valueArray[indexPath.row];

    }
    
    [self.selectedCitiesArray  addObject: city];
 
    [[self navigationController] popViewControllerAnimated:YES];
    [self.tableView reloadData];
    
    

}


#pragma Search Methods

-(void) filterContentForSearchText: (NSString *)searchText scope:(NSString *)scope{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    
    self.searchResults = [self.keyArray filteredArrayUsingPredicate:predicate];
}


-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


#pragma mark Cells color
- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = indexPath.row % 2
//    ? [UIColor colorWithRed:0.87 green:0.93 blue:0.98 alpha:1.0]
//    : [UIColor whiteColor];
    ? [UIColor colorWithRed:0.91 green:0.95 blue:0.98 alpha:1.0]
    : [UIColor colorWithRed:0.76 green:0.87 blue:0.98 alpha:1.0];
    
}

@end
