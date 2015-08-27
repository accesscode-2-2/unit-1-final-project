//
//  StopWatchViewControllerDelegate.h
//  Time
//
//  Created by Mesfin Bekele Mekonnen on 8/26/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol StopWatchViewControllerDelegate <NSObject>

- (NSString *)currentLapTime:(NSString *)lapTime;

@end
