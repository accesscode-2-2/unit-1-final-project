//
//  GOWorkoutsTableViewController.m
//  unit-1-final-project
//
//  Created by Jamaal Sedayao on 8/24/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOWorkoutsTableViewController.h"
#import "GOTimerViewController.h"
#import "WorkoutManager.h"
#import "Workout.h"
#import "GOFightViewController.h"
#import "BackgroundGradient.h"

@interface GOWorkoutsTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *goLeanLabel;
@property (weak, nonatomic) IBOutlet UILabel *goHardLabel;
@property (weak, nonatomic) IBOutlet UILabel *goFightLabel;
@property (weak, nonatomic) IBOutlet UILabel *goDeepLabel;

@end

@implementation GOWorkoutsTableViewController


// In each tabbed view controller

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        self.title = @"Go";
        
        // non-selected tab bar image
        UIImage *defaultImage = [[UIImage imageNamed:@"goIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // selected tab bar image
        UIImage *selectedImage = [[UIImage imageNamed:@"goIconSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // set the tab bar item with a title and both images
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:defaultImage
                                                selectedImage:selectedImage];
        
        self.tabBarItem.title = nil;
        
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.f, 50.f);
        
        return self;
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.tableView.layer insertSublayer:bgLayer atIndex:0];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    for (NSString* family in [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)])
    {
       // NSLog(@"%@", family);
        
        for (NSString* name in [[UIFont fontNamesForFamilyName:family] sortedArrayUsingSelector:@selector(compare:)])
        {
           // NSLog(@"  %@", name);
        }
    }

    
    // creates a custom right bar button to segue into the results page
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(addWorkoutButton:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Your Workouts" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 0.0, 110.0, 40.0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    [self.tableView reloadData];
    
    self.goHardLabel.font = [UIFont fontWithName:@"NikeTotal90" size:80.0];
    self.goLeanLabel.font = [UIFont fontWithName:@"NikeTotal90" size:80.0];
    
    self.goFightLabel.font = [UIFont fontWithName:@"NikeTotal90" size:80.0];
    
    self.goDeepLabel.font = [UIFont fontWithName:@"NikeTotal90" size:80.0];
    
    
    
    self.tableView.delegate = self;
    
    self.tableView.separatorColor = [UIColor clearColor];
}

- (IBAction)addWorkoutButton:(id)sender {
    // creates a storboard from the "Main" storboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // creates an instance of view controller from UI storyboard with identifier "ViewControllerIdentifier"
    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"CustomWorkoutList"];
    
    // pushing the navigation controller on a navigation stack
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Preparing for Segue");
    if([segue.identifier isEqualToString:@"timerSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableArray *workouts = [WorkoutManager sharedManager].workouts;
        Workout *workout = workouts[indexPath.row];
        
        GOTimerViewController *sublistVC = segue.destinationViewController;
        sublistVC.currentWorkout = [workouts objectAtIndex:0];
        
        NSLog(@"%@", sublistVC.currentWorkout);
        NSLog(@"%@", workout.workoutName);
    }
    if([segue.identifier isEqualToString:@"timerSegueTwo"])
    {
        NSLog(@"Success!");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableArray *workouts = [WorkoutManager sharedManager].workouts;
        Workout *workout = workouts[indexPath.row];
        
        GOTimerViewController *sublistVC = segue.destinationViewController;
        sublistVC.currentWorkout = [workouts objectAtIndex:1];
        
        NSLog(@"%@", sublistVC.currentWorkout);
        NSLog(@"%@", workout.workoutName);
    }
    if([segue.identifier isEqualToString:@"timerSegueThree"])
    {
        NSLog(@"GoFight!");
        
    }
    if([segue.identifier isEqualToString:@"timerSegueFour"])
    {
        NSLog(@"GoBuild!");
        
        self.hidesBottomBarWhenPushed = NO;
        
        GOFightViewController *sublistVC = segue.destinationViewController;
        [self.navigationController pushViewController:sublistVC animated:YES];
    }

}
@end
