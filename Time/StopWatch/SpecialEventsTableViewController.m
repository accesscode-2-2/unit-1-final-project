//
//  SpecialEventsTableViewController.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "SpecialEventsTableViewController.h"
#import "Event.h"
#import "EventCountdownViewController.h"



@interface SpecialEventsTableViewController ()

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation SpecialEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter = dateFormatter;
    [dateFormatter setDateFormat:@"MM/dd/yyyy 'at' HH:mm:ss"];
    
    self.specialEventsList = [[NSMutableArray alloc]init];
    
    Event *event = [[Event alloc] init];
    event.name = @"Jesus's Birthday";
    event.endTime = [dateFormatter dateFromString:@"12/25/2015 at 07:00:00"];
    event.pictureName = @"olive-toned-baby-angel";
    [self.specialEventsList addObject:event];
    
    event = [[Event alloc] init];
    event.name = @"Project Due";
    event.endTime = [dateFormatter dateFromString:@"09/01/2015 at 20:18:30"];
    event.pictureName = @"ios_emoji_skull";
    [self.specialEventsList addObject:event];
    
    event = [[Event alloc] init];
    event.name = @"Lease Due Date";
    event.endTime = [dateFormatter dateFromString:@"08/30/2015 at 01:46:20"];
    event.pictureName = @"runner_imoji";
    [self.specialEventsList addObject:event];
    
    for (Event *event in self.specialEventsList) {
        
        //Local Notif: Step 1
        UILocalNotification* localNotification =[[UILocalNotification alloc] init];
        localNotification.fireDate = event.endTime;
        localNotification.alertBody = [NSString stringWithFormat:@"Hope you're ready for %@", event.name];
        localNotification.timeZone = nil;
//        localNotification.soundName = @"";
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    }
    
    
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
    destination.dateFormatter = self.dateFormatter;
    destination.event = [self.specialEventsList objectAtIndex:indexPath.row];
    
    
    
}

@end
