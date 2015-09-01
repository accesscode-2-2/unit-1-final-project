//
//  WorldClockTableViewController.m
//  Time
//
//  Created by Chris David on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "WorldClockTableViewController.h"
#import "WorldClockInfo.h"
#import "NewWorldClockTableViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NewWorldClockTableViewController *vc = segue.destinationViewController;
    
    //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    //    CQCategory *newCategory = [self.allCategories objectAtIndex:indexPath.row];
    //vc.category = newCategory;
    
    vc.selectedCitiesArray = self.selectedCitiesArray;
    
}


@end
