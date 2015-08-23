//
//  PresetsTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetsTableViewController.h"
#import "OrderedDictionary.h"

@interface PresetsTableViewController ()
@property (nonatomic) OrderedDictionary *presets;
@property (nonatomic) NSArray *selectedPreset;
@end

@implementation PresetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultPresets];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didSelectTimer)];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
}

- (void)setupDefaultPresets {
    self.presets = [[OrderedDictionary alloc] init];
    
    NSArray *keys = @[@"Commercials", @"Dryer",  @"Morning Meditation", @"Popcorn", @"Quick Jog", @"Washing Machine"];
    NSArray *values = @[
                        @[@"00", @"01", @"00"],
                        @[@"00", @"45", @"00"],
                        @[@"00", @"05", @"00"],
                        @[@"00", @"03", @"30"],
                        @[@"00", @"25", @"00"],
                        @[@"00", @"35", @"00"]
                        ];
    
    for (int i = 0; i < [keys count]; i++) {
        [self.presets setObject:values[i] forKey:keys[i]];
    }
}

- (NSString *)formatSeconds:(CGFloat)seconds {
    NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li",
                        lround(floor(seconds / 3600.)) % 100,
                        lround(floor(seconds / 60.)) % 60,
                        lround(floor(seconds)) % 60];
    return string;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
    self.selectedPreset = [self.presets objectForKey:[self.presets keyAtIndex:indexPath.row]];
    [self.delegate presetTime:self.selectedPreset];
}

- (void)didSelectTimer {
    [self dismissViewControllerAnimated:YES completion:^{}];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.presets keyAtIndex:indexPath.row]];
    NSArray *presetTime = [self.presets objectForKey:[self.presets keyAtIndex:indexPath.row]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@:%@", presetTime[0], presetTime[1], presetTime[2]];
    return cell;
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
