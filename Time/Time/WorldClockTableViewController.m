//
//  WorldClockTableViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/26/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "WorldClockTableViewController.h"
#import "WorldClockAddTableViewController.h"
#import "WorldClockInfo.h"

@interface WorldClockTableViewController ()
@property (nonatomic) NSMutableArray *selectedCitiesArray;

@end

@implementation WorldClockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"World Clock"];
 
    self.selectedCitiesArray = [[NSMutableArray alloc] init];
   
    //it changes the color only on second click
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
 
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationController.view.backgroundColor =
    [UIColor colorWithPatternImage:[UIImage imageNamed:@"waterRotated"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
 }
-(void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedCitiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"worldClockIdentifier" forIndexPath:indexPath];
    
    WorldClockInfo *city = self.selectedCitiesArray[indexPath.row];
    cell.textLabel.text = city.cityName;
    
    cell.detailTextLabel.text = city.cityTime;
   
    return cell;
}


//delegate method that allows for editing when the edit button is clicked

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
         [self.selectedCitiesArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        //entry removed from data source now reload
        [self.tableView reloadData];
    }
}

#pragma mark Cells color
- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = indexPath.row % 2
    ? [UIColor colorWithRed:0.91 green:0.95 blue:0.98 alpha:1.0]
    : [UIColor colorWithRed:0.76 green:0.87 blue:0.98 alpha:1.0];
    
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WorldClockAddTableViewController *vc = segue.destinationViewController;
    vc.selectedCitiesArray = self.selectedCitiesArray;
 }



@end
