//
//  DetailViewController.h
//  Time
//
//  Created by Artur Lan on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameYourTask;
@property (weak, nonatomic) IBOutlet UITextField *yourTime;

@property (nonatomic) NSMutableDictionary *values;

@end
