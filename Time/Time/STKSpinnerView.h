//
//  STKSpinnerView.h
//  STKOKKKKKK
//
//  Created by Diana Elezaj on 8/30/15.
//  Copyright (c) 2015 Diana Elezaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STKSpinnerView : UIView

@property (nonatomic) float progress;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) float wellThickness;
@property (nonatomic, strong) UIColor *color;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
