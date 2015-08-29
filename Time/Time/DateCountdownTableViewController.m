//
//  DateCountdownTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "DateCountdownTableViewController.h"
#import "OrderedDictionary.h"
#import "NewEventViewController.h"

@interface DateCountdownTableViewController ()
@property (nonatomic) OrderedDictionary *eventDates;
@property (nonatomic) NSMutableArray *chronologicalKeys;
@property (nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation DateCountdownTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultPresets];
    
    // This is here just in case the screen stays active on the user's phone for a bit.
    // Refreshes every 5 minutes.
    [NSTimer scheduledTimerWithTimeInterval:300.0
                                     target:self
                                   selector:@selector(reloadCountdown)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)reloadCountdown {
    [self.tableView reloadData];
}

- (void)setupDefaultPresets {
    self.eventDates = [[OrderedDictionary alloc] init];
    
    NSArray *description = @[@"CD Player Day",
                      @"International Day for Failure",
                      @"Push-Button Phone Day",
                      @"International Shareware Day",
                      @"International Programmer's Day",
                      @"Macintosh Computer Day"];
    
    NSArray *keys = @[@"2015 10 01",
                        @"2015 10 13",
                        @"2015 11 18",
                        @"2015 12 13",
                        @"2016 01 07",
                        @"2016 01 24"];
    
    [self.eventDates setDictionary:[NSDictionary dictionaryWithObjects:description forKeys:keys]];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy MM dd"];
    
    self.chronologicalKeys = [NSMutableArray arrayWithArray:[self.eventDates allKeys]];
    NSLog(@"Chrono Keys %@", self.chronologicalKeys);
}

- (NSDate *)convertToNSDate:(NSString *)date {
    NSDate *event = [self.dateFormatter dateFromString:date];
    return event;
}

- (NSString *)timeToEvent:(NSDate *)event {
    NSDate *now = [NSDate new];
    
    // These next two lines are just for debugging and can be deleted before submission
    NSTimeInterval timeLeft = [event timeIntervalSinceDate:now];
    NSLog(@"%f", timeLeft);
    
    // Get our computer's local calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the calendar unit flags we want to use (minutes are included for debugging, to
    // check that the timer is firing every 5 minutes).
    NSCalendarUnit unitFlags = NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth;
    
    // Create the date components using our unit flags, the difference between the two dates,
    // and the local calendar which will automatically compensate for any time difference from
    // GMT.
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:now  toDate:event  options:0];
    NSLog(@"Break down: %lu minutes : %lu hours : %lu days : %lu months", [breakdownInfo minute], [breakdownInfo hour], [breakdownInfo day], [breakdownInfo month]);
    
    NSString *timeToEvent = [NSString stringWithFormat:@"%02lumo %02lud %02luh", [breakdownInfo month], [breakdownInfo day], [breakdownInfo hour]];
    
    return timeToEvent;
}

- (IBAction)newEventButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewEventViewController *newEventVC = [storyboard instantiateViewControllerWithIdentifier:@"newEventVC"];
    newEventVC.delegate = self;
    
    [self presentViewController:newEventVC animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.eventDates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dateIdentifier" forIndexPath:indexPath];
    
    NSString *key = self.chronologicalKeys[indexPath.row];
    NSDate *eventDate = [self convertToNSDate:key];
    NSString *countdown = [self timeToEvent:eventDate];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.eventDates objectForKey:key]];
    cell.detailTextLabel.text = countdown;
    
    return cell;
}

#pragma mark - delegate Implementation
- (void)presetCreated:(NSDate *)eventDate withName:(NSString *)eventName {
    NSString *date = [self.dateFormatter stringFromDate:eventDate];
    NSString *capitalizedEventName = [eventName capitalizedString];
    [self.eventDates setObject:capitalizedEventName forKey:date];
    
    self.chronologicalKeys = [NSMutableArray arrayWithArray:[self.eventDates allKeys]];
    NSArray* sortedArray = [self.chronologicalKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.chronologicalKeys = [NSMutableArray arrayWithArray:sortedArray];
}

@end
