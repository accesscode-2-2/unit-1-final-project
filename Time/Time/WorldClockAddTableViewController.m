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
@property (nonatomic) NSMutableDictionary *clock;
@property (nonatomic) NSArray *keyArray;
@property (nonatomic) NSArray *valueArray;

@property (nonatomic) NSString* city ;
@property (nonatomic) NSString* time;
@end

@implementation WorldClockAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Add City"];
    
    
    self.clock = [[NSMutableDictionary alloc] init];

    
    ////// trying to get current time
    NSDate * now = [NSDate date];
  
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
   
    NSString *NYTimeString = [outputFormatter stringFromDate:now];
    NSLog(@"NYDateString %@", NYTimeString);
    
    NSDate *parisTime = [now addTimeInterval:21600]; // Add XXX seconds to *now
    NSString *ParisTimeString = [outputFormatter stringFromDate:parisTime];
    NSLog(@"ParisDateString %@", ParisTimeString);
    
    
    NSDate *RomeTime = [now addTimeInterval:21600];
    NSString *RomeTimeString = [outputFormatter stringFromDate:RomeTime];
    NSLog(@"RomeTimeString %@", RomeTimeString);
    
    
    NSDate *MexicoCity = [now addTimeInterval:-3600];
    NSString *MexicoCityTimeString = [outputFormatter stringFromDate:MexicoCity];
    NSLog(@"MexicoCityTimeString %@", MexicoCityTimeString);
    
    
    
    NSDate *NewDelhi = [now addTimeInterval:34200];
    NSString *NewDelhiTimeString = [outputFormatter stringFromDate:NewDelhi];
    NSLog(@"NewDelhiTimeString %@", NewDelhiTimeString);

    
    
    
    
    
    [self.clock setObject:NewDelhiTimeString forKey:@"New Delhi"];
    [self.clock setObject:MexicoCityTimeString forKey:@"Mexico City"];
    [self.clock setObject:NYTimeString forKey:@"New York"];
    [self.clock setObject:RomeTimeString forKey:@"Rome, Italy"];
    [self.clock setObject:ParisTimeString forKey:@"Paris, France"];

    
        self.keyArray = [self.clock allKeys];
        self.valueArray = [self.clock allValues];

    
    
    
    for ( NSString *key in self.clock) {
        NSString *value = [self.clock objectForKey:key];
        
 
        //NSLog(@"key: %@, value: %@", key, value);
        
       
        
    
        
        
        
        
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
    return self.keyArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorldClockAddIdentifier" forIndexPath:indexPath];
    
    
    [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[self.valueArray objectAtIndex:indexPath.row]];
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ %@", self.keyArray[(long)indexPath.row], self.valueArray[(long)indexPath.row] ); // you can see
    
    
    WorldClockInfo *city = [[WorldClockInfo alloc] init];
    city.cityName = self.keyArray[indexPath.row];
    city.cityTime = self.valueArray[indexPath.row];
    
    
    [self.selectedCitiesArray addObject:city ];

    
    
    [[self navigationController] popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
