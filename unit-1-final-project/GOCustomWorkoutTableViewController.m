//
//  GOCustomWorkoutTableViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/26/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCustomWorkoutTableViewController.h"
#import "GOCustomResultsViewController.h"
#import "BackgroundGradient.h"
#import "WorkoutManager.h"
#import "Workout.h"

@interface GOCustomWorkoutTableViewController ()
@end

@implementation GOCustomWorkoutTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.tableView.layer insertSublayer:bgLayer atIndex:0];
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
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    GOCustomResultsViewController *resultsVC = segue.destinationViewController;
    NSMutableArray *workouts = [WorkoutManager customWorkoutManager].customWorkouts;
    Workout *workout = workouts[indexPath.row];
    resultsVC.resultsWorkout = workout;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *customWorkouts = [WorkoutManager customWorkoutManager].customWorkouts;
    [customWorkouts removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

@end
