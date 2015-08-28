//
//  BokehScene.m
//  Time
//
//  Created by Shena Yoshida on 8/28/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "BokehScene.h"

@implementation BokehScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //self.backgroundColor = [SKColor blackColor];
        self.scene.backgroundColor = [SKColor colorWithRed:251/255.0f green:207/255.0f blue:79/255.0f alpha:1.0];
        
        NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"Bokeh" ofType:@"sks"];
        SKEmitterNode *bokeh = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
        bokeh.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height/2);
        bokeh.name = @"particleBokeh";
        bokeh.targetNode = self.scene;
        [self addChild:bokeh];
    }
    return self;
}

@end
