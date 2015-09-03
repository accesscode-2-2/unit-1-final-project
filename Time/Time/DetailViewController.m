//
//  DetailViewController.m
//  Time
//
//  Created by Artur Lan on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "DetailViewController.h"
#import "PresetTime.h"
#import "TimerViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (IBAction)saveButton:(UIButton *)sender {
    
    PresetTime *time = [[PresetTime alloc] init];
    time.nameOfTask = self.nameYourTask.text;
    time.timeOfTask = [self.yourTime.text doubleValue];
    
    [self.previousViewController.timers addObject:time];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
