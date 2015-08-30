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

//@property (nonatomic) NSMutableArray *selectedC;

//
//@property (nonatomic) NSMutableDictionary *citySelected;
//@property (nonatomic) NSArray *keyCitySelected;
//@property (nonatomic) NSArray *valueCitySelected;



@end

@implementation WorldClockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"World Clock"];
 
  //  self.tableView.backgroundColor = [UIColor grayColor ];

    self.selectedCitiesArray = [[NSMutableArray alloc] init];
   
    //it changes the color only on second click
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
 
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
 
    
    
    
        
    
    
    
    
    
 }
-(void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    
    
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
    //return self.selectedCitiesArray.count;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WorldClockAddTableViewController *vc = segue.destinationViewController;
    
    //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
//    CQCategory *newCategory = [self.allCategories objectAtIndex:indexPath.row];
    //vc.category = newCategory;
    
    vc.selectedCitiesArray = self.selectedCitiesArray;
    
 }



@end
