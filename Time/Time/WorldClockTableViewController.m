//
//  WorldClockTableViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/26/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "WorldClockTableViewController.h"

@interface WorldClockTableViewController ()
@property (nonatomic) NSMutableArray *arr;

@end

@implementation WorldClockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"World Clock"];
    
    
    //it changes the color only on second click
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];

    
    
    
    //    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                [UIColor whiteColor],UITextAttributeTextColor,
//                                [UIColor blackColor], UITextAttributeTextShadowColor,
//                                [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset, nil];
    
//    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    
    
    
 
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Add"
                                  style:UIBarButtonItemStyleBordered
                                  target:nil
                                  action:nil];
    
    self.navigationItem.rightBarButtonItem = addButton;

    
    
    
    
    
    self.arr = [[NSMutableArray alloc]init];
 
    [self.arr insertObject:@"one" atIndex:0 ];
    [self.arr insertObject:@"two" atIndex:0];
    [self.arr insertObject:@"three" atIndex:0];

    NSLog(@"%@", self.arr[0]);
    

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
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"worldClockIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
   // cell.textLabel.text = self.arr[indexPath.row];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.arr count] - indexPath.row];
    
    cell.detailTextLabel.text = self.arr[indexPath.row];

    
    
//    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
