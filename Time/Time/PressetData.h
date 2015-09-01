//
//  PressetData.h
//  Time
//
//  Created by Diana Elezaj on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Preset.h"

@interface PressetData : NSObject

@property (nonatomic) NSMutableArray *allPresets;
@property (nonatomic) Preset *presetModel;

-(void)initializeData;
+ (PressetData *)sharedModel;

@end
