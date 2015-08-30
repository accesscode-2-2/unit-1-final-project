//
//  DataSingleton.m
//  Time
//
//  Created by Elber Carneiro on 8/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "DataSingleton.h"

@implementation DataSingleton

+ (id)sharedDataSingleton {
    static DataSingleton *sharedDataSingleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataSingleton = [[self alloc] init];
    });
    
    return sharedDataSingleton;
}

- (id)init {
    if (self = [super init]) {
        [self setupDefaultPresets];
    }
    return self;
}

- (void)setupDefaultPresets {
    self.presetTimers = [[OrderedDictionary alloc] init];
    
    NSArray *keys = @[@"Commercials", @"Dryer",  @"Morning Meditation",
                      @"Popcorn", @"Quick Jog", @"Washing Machine"];
    
    NSArray *values = @[@[@"00", @"01", @"00"],
                        @[@"00", @"45", @"00"],
                        @[@"00", @"05", @"00"],
                        @[@"00", @"03", @"30"],
                        @[@"00", @"25", @"00"],
                        @[@"00", @"35", @"00"]];
    
    for (int i = 0; i < [keys count]; i++) {
        [self.presetTimers setObject:values[i] forKey:keys[i]];
    }
    
    self.alphabeticalKeys = [NSMutableArray arrayWithArray:[self.presetTimers allKeys]];
}

- (void)setTimer:(NSArray *)time withName:(NSString *)name {
    [self.presetTimers setObject:time forKey:name];
    
    self.alphabeticalKeys = [NSMutableArray arrayWithArray:[self.presetTimers allKeys]];
    NSLog(@"Alpha Keys %@", self.alphabeticalKeys);
    NSArray* sortedArray = [self.alphabeticalKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.alphabeticalKeys = [NSMutableArray arrayWithArray:sortedArray];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSString *key in self.alphabeticalKeys) {
        [temp addObject:[self.presetTimers objectForKey:key]];
    }
    
    self.presetTimers = [OrderedDictionary dictionaryWithObjects:temp forKeys:self.alphabeticalKeys];
    NSLog(@"Preset Timers: %@", self.presetTimers);
}

@end
