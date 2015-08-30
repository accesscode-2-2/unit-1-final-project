//
//  WorldClockAddTableViewController.h
//  Time
//
//  Created by Diana Elezaj on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorldClockAddTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic) NSMutableArray *selectedCitiesArray;

@end
