//
//  TimerDetailTableViewController.m
//  Time
//
//  Created by Eric Sanchez on 8/29/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "TimerDetailTableViewController.h"
#import "Preset.h"

@interface TimerDetailTableViewController ()

@end

@implementation TimerDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	Preset *popcorn = [[Preset alloc] init];
	popcorn.name = @"Popcorn";
	popcorn.time = 3.5f;
	
	Preset *meatloaf = [[Preset alloc] init];
	meatloaf.name = @"Meatloaf";
	meatloaf.time = 3.5f;
	
	Preset *fish = [[Preset alloc] init];
	fish.name = @"fish";
	fish.time = 3.5f;
   self.presets = @[popcorn, meatloaf, fish];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.presets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetIdentifier" forIndexPath:indexPath];
    NSArray *names = [self.presets valueForKey:@"name"];
    // Configure the cell...
    cell.textLabel.text = names[indexPath.row];
    return cell;
}






@end
