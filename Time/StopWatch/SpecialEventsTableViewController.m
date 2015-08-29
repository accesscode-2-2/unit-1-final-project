//
//  SpecialEventsTableViewController.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "SpecialEventsTableViewController.h"
#import "eventObject.h"
#import "EventCountdownViewController.h"



@interface SpecialEventsTableViewController ()

@end

@implementation SpecialEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.specialEventsList = [[NSMutableArray alloc]init];
    eventObject *object = [[eventObject alloc]init];
    object.name =@"Hello";
    object.endTime = [NSDate date];
    [self.specialEventsList addObject: object];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.specialEventsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"specialEventReuseIdentifier" forIndexPath:indexPath];
    
//    EditSpecialViewController *specialEvent = [[EditSpecialViewController alloc] init];
   
    cell.textLabel.text = [[self.specialEventsList objectAtIndex:indexPath.row] name];

    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    EventCountdownViewController *destination = [segue destinationViewController];
    destination.obj = [self.specialEventsList objectAtIndex:indexPath.row];
    
//    detailVC.eventDatePicked = cell.detailTextLabel.text;
//    detailVC.eventDatePicked = [NSString stringWithFormat:@"%@", cell.detailTextLabel.text ];
//    
    
}

@end
