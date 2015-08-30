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
@property (nonatomic) NSMutableArray *alphabeticalKeys;
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
    
    self.tableView.backgroundColor = [UIColor blackColor];
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
    
    self.alphabeticalKeys = [NSMutableArray arrayWithArray:[self.presets allKeys]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.navigationItem.leftBarButtonItem.enabled == NO) {
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    }
    self.selectedPreset = [self.presets objectForKey:[self.presets keyAtIndex:indexPath.row]];
}

- (void)didSelectTimer {
    
    NSString *key = [self.presets getKeyForObject:self.selectedPreset];
    
    [self.delegate presetTime:self.selectedPreset withName:key];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetIdentifier"];
    
    if (cell == nil) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:@"presetIdentifier"];
    }
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor orangeColor];
    cell.selectedBackgroundView = selectionColor;
    
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Orbitron-Regular" size:20]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"DigitalReadoutExpUpright" size:20]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.alphabeticalKeys[indexPath.row]];
    NSArray *presetTime = [self.presets objectForKey:self.alphabeticalKeys[indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@:%@", presetTime[0], presetTime[1], presetTime[2]];
    
    return cell;
}

#pragma mark - NewPresetViewControllerDelegate implementation
-(void)presetCreated:(NSArray *)countdownTime withName:(NSString *)timerName {
    [self.presets setObject:countdownTime forKey:timerName];
    
    self.alphabeticalKeys = [NSMutableArray arrayWithArray:[self.presets allKeys]];
    NSLog(@"Alpha Keys %@", self.alphabeticalKeys);
    NSArray* sortedArray = [self.alphabeticalKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.alphabeticalKeys = [NSMutableArray arrayWithArray:sortedArray];
    [self.tableView reloadData];
}

@end
