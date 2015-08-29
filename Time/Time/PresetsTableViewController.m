//
//  PresetsTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetsTableViewController.h"
#import "NewPresetViewController.h"
#import "OrderedDictionary.h"

@interface PresetsTableViewController ()
@property (nonatomic) OrderedDictionary *presets;
@property (nonatomic) NSArray *selectedPreset;
@property (nonatomic) NSUInteger chosenIndex;
@end

@implementation PresetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultPresets];
    [self.navigationItem setTitle:@"Select Presets"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didSelectTimer)];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
}

- (void)setupDefaultPresets {
    self.presets = [[OrderedDictionary alloc] init];
    
    NSArray *keys = @[@"Commercials", @"Dryer",  @"Morning Meditation",
                      @"Popcorn", @"Quick Jog", @"Washing Machine"];
    
    NSArray *values = @[@[@"00", @"01", @"00"],
                        @[@"00", @"45", @"00"],
                        @[@"00", @"05", @"00"],
                        @[@"00", @"03", @"30"],
                        @[@"00", @"25", @"00"],
                        @[@"00", @"35", @"00"]];
    
    for (int i = 0; i < [keys count]; i++) {
        [self.presets setObject:values[i] forKey:keys[i]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.navigationItem.leftBarButtonItem.enabled == NO) {
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    }
    self.selectedPreset = [self.presets objectForKey:[self.presets keyAtIndex:indexPath.row]];
}

- (void)didSelectTimer {
    [self.delegate presetTime:self.selectedPreset];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)newPresetButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewPresetViewController *newPresetVC = [storyboard instantiateViewControllerWithIdentifier:@"newPresetVC"];
    newPresetVC.delegate = self;
    
    [self presentViewController:newPresetVC animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.presets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetIdentifier"];
    
    if (cell == nil) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:@"presetIdentifier"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.presets keyAtIndex:indexPath.row]];
    NSArray *presetTime = [self.presets objectForKey:[self.presets keyAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@:%@", presetTime[0], presetTime[1], presetTime[2]];
    
    return cell;
}

#pragma mark - NewPresetViewControllerDelegate implementation
-(void)presetCreated:(NSArray *)countdownTime withName:(NSString *)timerName {
    [self.presets setObject:countdownTime forKey:timerName];
    [self.tableView reloadData];
}

@end
