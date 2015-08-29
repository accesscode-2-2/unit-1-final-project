//
//  GOCalendarTableViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/24/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCalendarTableViewController.h"
#import "GOCalendarResults.h"
#import "BackgroundGradient.h"
#import "WorkoutManager.h"

@interface GOCalendarTableViewController ()

@end

@implementation GOCalendarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Go Goals";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.tableView.layer insertSublayer:bgLayer atIndex:0];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableDictionary *calendarDates = [WorkoutManager calendarManager].calendarDates;
    NSInteger rowsCalendarDates = [calendarDates count];
    return rowsCalendarDates;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarList" forIndexPath:indexPath];
    NSMutableDictionary *calendarDates = [WorkoutManager calendarManager].calendarDates;
    //    NSString *key = [calendarDates obj
    
    NSArray *keys = [calendarDates allKeys];
    NSString *key = keys[indexPath.section];
    //NSArray *calendarArray = [calendarDates objectForKey:key];
    cell.textLabel.text = key;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"CalendarListToResults"]){
        
        GOCalendarResults *resultsVC = segue.destinationViewController;
        NSIndexPath *indexPath;
        NSMutableDictionary *calendarDates = [WorkoutManager calendarManager].calendarDates;
        NSArray *values = [calendarDates allValues];
        NSDate *value = values[indexPath.section];
        resultsVC.scheduledDate =  value;
        
    }
    
}

@end
