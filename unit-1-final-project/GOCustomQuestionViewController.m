//
//  GOCustomQuestionViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/26/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCustomQuestionViewController.h"
#import "GOCustomWorkoutTableViewController.h"
#import "ExerciseTableViewCell.h"
#import "BackgroundGradient.h"
#import "WorkoutManager.h"
#import "Workout.h"
#import "Exercises.h"

@interface GOCustomQuestionViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *enterWorkoutNameField;
@property (weak, nonatomic) IBOutlet UITextField *addExerciseNameField;
@property (weak, nonatomic) IBOutlet UITextField *minutesField;
@property (weak, nonatomic) IBOutlet UITextField *secondsField;
@property (nonatomic) Workout *workout;

// property that is workout

@end

@implementation GOCustomQuestionViewController

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Check for non-numeric characters
    NSUInteger lengthOfString = string.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
        unichar character = [string characterAtIndex:loopIndex];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.minutesField.delegate = self;
    self.secondsField.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // creates a custom right bar button to segue into the results page
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(addWorkoutButton:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add to List" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 0.0, 90.0, 30.0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    // alloc init workout
    self.workout = [[Workout alloc]init];
    self.workout.exercises = [[NSMutableArray alloc]init];
    
}

- (IBAction)addExercise:(id)sender {
    
    
    Exercises *exercise = [[Exercises alloc]init];
    
    [self.tableView reloadData];
    
    // converts text input to float
    NSString *seconds = self.secondsField.text;
    float thisseconds = [seconds floatValue];
    NSString *minutes = self.minutesField.text;
    float thisminutes = [minutes floatValue];
    
    // adds both seconds and minutes together
    float totalSeconds = (thisminutes * 60) + thisseconds;
    
    exercise.exerciseTime = totalSeconds;
    
    exercise.nameOfExercise = self.addExerciseNameField.text;
    
    [self.workout.exercises addObject :exercise];
    
    [self.tableView reloadData];
}

- (IBAction)addWorkoutButton:(id)sender {
    
    // calls the singleton from the Workout Manager
    NSMutableArray *customWorkouts = [WorkoutManager customWorkoutManager].customWorkouts;
    
    self.workout.workoutName = self.enterWorkoutNameField.text;
    
    [customWorkouts addObject:self.workout];
    
    // creates a storboard from the "Main" storboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // creates an instance of view controller from UI storyboard with identifier "ViewControllerIdentifier"
    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"CustomWorkoutList"];
    
    // pushing the navigation controller on a navigation stack
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated { // sets the background of the VC
    [super viewWillAppear:animated];
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // get the number of exercises from this workout array
    return self.workout.exercises.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exerciseList" forIndexPath:indexPath];
    NSMutableArray *allExercises = self.workout.exercises;
    Exercises *thisExercise = allExercises[indexPath.row];
    NSString *key = thisExercise.nameOfExercise;
    cell.textLabel.text = key;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


 #pragma mark - Navigation
 

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     GOCustomWorkoutTableViewController *resultsVC = segue.destinationViewController;
     resultsVC.listofCustomWorkouts = [WorkoutManager customWorkoutManager].customWorkouts;
 }
 

@end
