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

@end



@implementation UpcomingEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //getting today's date which will print to the console
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"Today's date: %@", dateString);
    
    //initializing eventsDictionary
    self.eventsDictionary = [[NSDictionary alloc] init];
    
    
//    
//    for (NSString *eventName in [UpcomingEvents upcomingEventsDictionary]) {
//        UpcomingEvents *event = [[UpcomingEvents alloc] init];
//        event.eventName = eventName;
//        [self.events setValue:<#(id)#> forKey:<#(NSString *)#>];
//    }
    
    
}



+ (int)daysBetweenFromDate:(NSDate*)fromDateTime toDate:(NSDate*)toDateTime
{
    //this method is calculating the number of days between one date to another
    
    NSDate *fromDate;
    NSDate *toDate;
    
    //initialize the calender
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //Returns by reference the starting time and duration of a given calendar unit that contains a given date.
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    //Returns, as an NSDateComponents object using specified components, the difference between two supplied dates.
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
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
    NSString *eventDateString = key;
    cell.textLabel.text = eventNameString;
    
    // printing value of the key in the detail text label
    cell.detailTextLabel.text = eventDateString;
    
//    NSLog(@"%@", keys);
    
    return cell;
    
}

//    // Configure the cell...
//    cell.textLabel.text = [[self.events objectAtIndex:indexPath.row] objectForKey: @"Christmas"];
//    cell.detailTextLabel.text = [[self.events objectAtIndex:indexPath.row] objectForKey:@"New Years"];
//    // continue configuration etc..
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
