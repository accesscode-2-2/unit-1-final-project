////
////  PresetTimersTableViewController.m
////  PresetTimerPracticeProject
////
////  Created by Bereket  on 8/29/15.
////  Copyright (c) 2015 Bereket . All rights reserved.
////

#import "PresetTimersTableViewController.h"
#import "ViewController.h"
#import "PresetTimersSingleton.h"
#import "PresetTimer.h"
#import "TimerDetailViewController.h"


@interface PresetTimersTableViewController ()

@end

@implementation PresetTimersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ListOfTimersIdentifier"];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSMutableArray *array = [[PresetTimersSingleton sharedInstance] presetTimersArray];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListOfTimersIdentifier" forIndexPath:indexPath];
    
    PresetTimer *currentTimer = [[[PresetTimersSingleton sharedInstance] presetTimersArray]objectAtIndex:indexPath.row];
    NSString *timerName = currentTimer.timerName;
    
    cell.textLabel.text=timerName;
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PresetTimer *timer = [[[PresetTimersSingleton sharedInstance] presetTimersArray] objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TimerDetailViewController *timerDetailVC = (TimerDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"timerDetailViewControllerID"];
    timerDetailVC.presetTimer = timer;
    [self.navigationController pushViewController:timerDetailVC animated:YES];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showDetailIdentifier"]) {
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//                PresetTimer *timer = [[[PresetTimersSingleton sharedInstance] presetTimersArray] objectAtIndex:indexPath.row];
//        
//        TimerDetailViewController *timerDetailVC = (TimerDetailViewController *)segue.destinationViewController;
//        timerDetailVC.timer = timer;
//    }
//}


///*
// // Override to support conditional editing of the table view.
// - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
// // Return NO if you do not want the specified item to be editable.
// return YES;
// }
// */
//
///*
// // Override to support editing the table view.
// - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
// if (editingStyle == UITableViewCellEditingStyleDelete) {
// // Delete the row from the data source
// [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
// } else if (editingStyle == UITableViewCellEditingStyleInsert) {
// // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
// }
// }
// */
//
///*
// // Override to support rearranging the table view.
// - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
// }
// */
//
///*
// // Override to support conditional rearranging of the table view.
// - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
// // Return NO if you do not want the item to be re-orderable.
// return YES;
// }
// */
//
//
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    
//    
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end
