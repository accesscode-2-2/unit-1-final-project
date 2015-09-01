//
//  NewWorldClockTableViewController.h
//  Time
//
//  Created by Chris David on 8/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewWorldClockTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic) NSMutableArray *selectedCitiesArray;
@end
