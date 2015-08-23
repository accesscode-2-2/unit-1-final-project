//
//  PresetsTableViewControllerDelegate.h
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PresetsTableViewControllerDelegate <NSObject>
- (void)presetTime:(CGFloat)presetTime;
@end
