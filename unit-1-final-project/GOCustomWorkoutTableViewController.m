 //
//  GOCustomWorkoutTableViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/26/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCustomWorkoutTableViewController.h"
#import "GOCustomResultsViewController.h"
#import "Workout.h"
#import "WorkoutManager.h"

@interface GOCustomWorkoutTableViewController ()

@end

@implementation GOCustomWorkoutTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // creates a custom right bar button to segue into the results page
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(addWorkoutButton:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add Workout" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 0.0, 90.0, 40.0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    [self.tableView reloadData];
    
}

- (IBAction)addWorkoutButton:(id)sender {
    
    // creates a storboard from the "Main" storboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // creates an instance of view controller from UI storyboard with identifier "ViewControllerIdentifier"
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"CustomQuestionVC"];
    
    // pushing the navigation controller on a navigation stack
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *workouts = [WorkoutManager customWorkoutManager].customWorkouts;
    return workouts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomWorkoutIdentifier" forIndexPath:indexPath];
    
    NSMutableArray *workouts = [WorkoutManager customWorkoutManager].customWorkouts;
    Workout *workout = workouts[indexPath.row];
    NSString *key = workout.workoutName;
    NSLog(@"%@", key);
    cell.textLabel.text = key;
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSMutableArray *workouts = [WorkoutManager customWorkoutManager].customWorkouts;
//    Workout *workout = workouts[indexPath.row];
//    GOCustomResultsViewController *resultsVC;
//    resultsVC.resultsWorkout = workout.exercises;
//}

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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    GOCustomResultsViewController *resultsVC = segue.destinationViewController;
    NSMutableArray *workouts = [WorkoutManager customWorkoutManager].customWorkouts;
    Workout *workout = workouts[indexPath.row];
    resultsVC.resultsWorkout = workout;

    //resultsVC.resultsWorkout = [WorkoutManager customWorkoutManager].customWorkouts;
}


@end
