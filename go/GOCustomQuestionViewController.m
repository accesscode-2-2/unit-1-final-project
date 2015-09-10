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
@property (weak, nonatomic) IBOutlet UIButton *addExerciseButton;
@property (nonatomic) Workout *workout;



@end

@implementation GOCustomQuestionViewController

#pragma mark - Setup

- (void)delegateSetup {
//    self.addExerciseNameField.delegate = self;
//    self.enterWorkoutNameField.delegate = self;
    self.minutesField.delegate = self;
    self.secondsField.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)backgroundSetup {
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)disableInitialButtons{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.addExerciseButton.userInteractionEnabled = NO;
}

- (void)creatingACustomRightBarButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(addWorkoutButton:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add to List" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 0.0, 90.0, 30.0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self backgroundSetup];
    
    [self disableInitialButtons];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
    [self delegateSetup];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self creatingACustomRightBarButton];
    
    // alloc init workout
    self.workout = [[Workout alloc]init];
    self.workout.exercises = [[NSMutableArray alloc]init];
}

#pragma mark - Text Field Conditions

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Check for non-numeric characters
    NSUInteger lengthOfString = string.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++){
        unichar character = [string characterAtIndex:loopIndex];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 2;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)editingChanged:(UITextField *)sender {
    BOOL hasMinutes = ![self.minutesField.text isEqualToString:@""];
    BOOL hasSeconds = ![self.secondsField.text isEqualToString:@""];
    BOOL hasWorkout = ![self.enterWorkoutNameField.text isEqualToString:@""];
    BOOL hasExercise = ![self.addExerciseNameField.text isEqualToString:@""];
    
    if (hasMinutes && hasSeconds && hasWorkout && hasExercise){
        self.addExerciseButton.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.addExerciseButton.userInteractionEnabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}



#pragma mark - Buttons

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
    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"CustomWorkoutList"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *exercises = self.workout.exercises;
    [exercises removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

 #pragma mark - Segue
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     GOCustomWorkoutTableViewController *resultsVC = segue.destinationViewController;
     resultsVC.listofCustomWorkouts = [WorkoutManager customWorkoutManager].customWorkouts;
 }
 

@end
