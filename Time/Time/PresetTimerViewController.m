//
//  PresetTimerViewController.m
//  Time
//
//  Created by Shena Yoshida on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimerViewController.h"
#import "PresetTimerAddViewController.h"
#import "PresetTimerDetailViewController.h"

@interface PresetTimerViewController ()<UITableViewDataSource, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PresetTimerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [TimerModel sharedInstance];
    [self.model initializeModel];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonTapped:)];
    self.tableView.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)editButtonTapped:(UIBarButtonItem *)button {
    [self.tableView setEditing:YES animated:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(stopEditingButtonTapped:)];
}

- (void)stopEditingButtonTapped:(UIBarButtonItem *)button {
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonTapped:)];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.model.timers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



- (void)addButtonTapped {
    
    PresetTimerAddViewController *myNewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"showAdd"];
    myNewVC.timerViewController = self;
    [self presentViewController:myNewVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.timers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetTimerIdentifier" forIndexPath:indexPath];
    
    
    Timer *timer = [self.model.timers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = timer.timerName;
    
    int minutes = timer.countDownDuration/60;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i Mins", minutes];
    cell.imageView.image = [UIImage imageNamed:timer.imageName];
    [cell layoutIfNeeded];
    return cell;
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual:@"showAdd"]) {
        
        PresetTimerAddViewController *addVC = segue.destinationViewController;
        
        addVC.timerViewController = self;
        
    }
    else
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Timer *currentTimer = [self.model.timers objectAtIndex:indexPath.row];
        PresetTimerDetailViewController *detailVC = segue.destinationViewController;
        
        detailVC.currentTimer = currentTimer;
        
    }
    
}


@end







