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
@end

@implementation PresetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultPresets];
}

- (void)setupDefaultPresets {
    self.presets = [[OrderedDictionary alloc] init];
    
    NSArray *keys = @[@"Commercials", @"Dryer",  @"Morning Meditation", @"Popcorn", @"Quick Jog", @"Washing Machine"];
    NSArray *values = @[@60.0, @2700.0, @300.0, @210.0, @1500.0, @2100.0];
    
    for (int i = 0; i < [keys count]; i++) {
        [self.presets setObject:values[i] forKey:keys[i]];
    }
    
    NSLog(@"%@", self.presets);
}

- (NSString *)formatSeconds:(CGFloat)seconds {
    NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li",
                        lround(floor(seconds / 3600.)) % 100,
                        lround(floor(seconds / 60.)) % 60,
                        lround(floor(seconds)) % 60];
    return string;
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self formatSeconds:[[self.presets objectForKey:[self.presets keyAtIndex:indexPath.row]] floatValue]]];
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
