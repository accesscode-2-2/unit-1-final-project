//
//  ClockInstance.h
//  Time
//
//  Created by Chris David on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockInstance : NSObject
@property (nonatomic) NSMutableArray *allCategories;

-(void) initializeModel;

+ (ClockInstance *)sharedInstance;

@end
