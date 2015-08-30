//
//  DataSingleton.h
//  Time
//
//  Created by Elber Carneiro on 8/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedDictionary.h"

@interface DataSingleton : NSObject
@property (nonatomic) OrderedDictionary *presetTimers;
@property (nonatomic) NSMutableArray *alphabeticalKeys;
+ (id)sharedDataSingleton;
- (void)setTimer:(NSArray *)time withName:(NSString *)name;
@end
