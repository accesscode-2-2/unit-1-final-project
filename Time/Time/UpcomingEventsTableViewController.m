//
//  UpcomingEventsTableViewController.m
//  Time
//
//  Created by Lauren Caponong on 8/31/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "UpcomingEventsTableViewController.h"
#import "UpcomingEvents.h"

@interface UpcomingEventsTableViewController ()

@property (nonatomic) NSDictionary *eventsDictionary;
@property (nonatomic) NSDate *today;

@end



@implementation UpcomingEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Upcoming Events";
    
    //initializing eventsDictionary
    self.eventsDictionary = [[NSDictionary alloc]init];

    //getting today's date which will print to the console
    self.today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:self.today];
    NSLog(@"Today's date: %@", dateString);
    
    
}


//method for calculating the difference between one date and another date

-(int)dateDiffrenceFromDate:(NSString *)date1 second:(NSString *)date2 {
    // Manage Date Formation same for both dates
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *startDate = [formatter dateFromString:date1];
    NSDate *endDate = [formatter dateFromString:date2];
    
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
    
    int dayDiff = [difference day];
    
    return dayDiff;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.eventsDictionary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCellIdentifier" forIndexPath:indexPath];
    
    //trying to print the values of the dictionary in the cell
    NSArray *key = [self.eventsDictionary allKeys][indexPath.row];
    
    NSString *eventNameString = self.eventsDictionary[key];
//    NSString *eventDateString = key;
    
    cell.textLabel.text = [self.eventsDictionary objectForKey:@"Christmas"];
    
    // printing value of the key in the detail text label
//    cell.detailTextLabel.text = eventDateString;
    
    return cell;
    
}

//    // Configure the cell...
//    cell.textLabel.text = [[self.events objectAtIndex:indexPath.row] objectForKey: @"Christmas"];
//    cell.detailTextLabel.text = [[self.events objectAtIndex:indexPath.row] objectForKey:@"New Years"];
//    // continue configuration etc..
//    return cell;
//}





@end
