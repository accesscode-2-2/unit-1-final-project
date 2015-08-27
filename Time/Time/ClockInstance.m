////
////  ClockInstance.m
////  Time
////
////  Created by Chris David on 8/23/15.
////  Copyright (c) 2015 Mike Kavouras. All rights reserved.
////
//
//#import "ClockInstance.h"
//
//@implementation ClockInstance
//
//+ (ClockInstance *)sharedInstance
//{
//    static dispatch_once_t once;
//    static id sharedInstance;
//    dispatch_once(&once, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}
//
//-(void) initializeModel {
//    
//    self.allCategories = [[NSMutableArray alloc] init];
//    
//    ListData *basketball = [[ListData alloc] init];
//    basketball.name = @"Basketball";
//    basketball.selection = @"";
//    basketball.options = @[@"Knicks", @"Heat", @"Celtics", @"Warriors", @"Nets", @"Timberwolves"];
//    basketball.index = 0;
//    [self.allCategories addObject:basketball];
//    
//    ListData * baseball = [[ListData alloc] init];
//    baseball.name = @"Baseball";
//    baseball.selection = @"";
//    baseball.options = @[@"Yankees", @"Mets", @"Red Sox", @"Twins", @"Dodgers"];
//    baseball.index = 1;
//    [self.allCategories addObject:baseball];
//    
//    ListData * football = [[ListData alloc] init];
//    football.name = @"Football";
//    football.selection = @"";
//    football.options = @[@"Giants", @"Jets", @"Eagles", @"Colts", @"Patriots"];
//    football.index = 2;
//    [self.allCategories addObject:football];
//    
//    
//    
//}
//@end
