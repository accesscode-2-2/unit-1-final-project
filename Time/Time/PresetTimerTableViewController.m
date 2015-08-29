//
//  PresetTimerTableViewController.m
//  Time
//
//  Created by Felicia Weathers on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimerTableViewController.h"

@interface PresetTimerTableViewController ()

@property (nonatomic) NSMutableArray *presets;

@end

@implementation PresetTimerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presets = [[NSMutableArray alloc]init];
    
    TimerData *cardio = [[TimerData alloc]init];
    cardio.nameOfTimer = @"Cardio";
    cardio.presetTime = @30.00;
    
    TimerData *strengthTraining = [[TimerData alloc]init];
    strengthTraining.nameOfTimer = @"Strength Training";
    strengthTraining.presetTime = @45.00;
    
    TimerData *yoga = [[TimerData alloc]init];
    yoga.nameOfTimer = @"Yoga";
    yoga.presetTime = @90.00;

    
    
    self.presets = [NSMutableArray arrayWithObjects: cardio, strengthTraining, yoga, nil];
    
    self.clearsSelectionOnViewWillAppear = NO;


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
    return self.presets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedPreset = self.presets[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PresetTimerIdentifier" forIndexPath:indexPath];
   
    NSArray *presetData = [self.presets valueForKey:@"nameOfTimer"];
    NSString *name = presetData[indexPath.row];
    
    cell.textLabel.text = name;

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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *presetData = [self.presets valueForKey:@"nameOfTimer"];
    NSString *name = presetData[indexPath.row];
    
    
}

- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)addButton:(id)sender {
    
}
@end
