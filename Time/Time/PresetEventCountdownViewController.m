//
//  PresetEventCountdownViewController.m
//  Time
//
//  Created by Shena Yoshida on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetEventCountdownViewController.h"
#import "BokehScene.h"

@interface PresetEventCountdownViewController ()

@property (nonatomic) SKView *particleBackground;

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel1;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel2;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel3;

@property (strong, nonatomic) NSDate *destinationDate1;
@property (strong, nonatomic) NSDate *destinationDate2;
@property (strong, nonatomic) NSDate *destinationDate3;
@property (strong, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;

// continue adding preset dates to scroll view
// ideas: national cheese pizza day (sept 5), world nutella day (feb 5)

@end

@implementation PresetEventCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.particleBackground = [[SKView alloc] init];
    BokehScene * scene = [BokehScene sceneWithSize:self.view.bounds.size]; // add spritekit animated images to background!
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.particleBackground presentScene:scene];
    
    [self.contentView insertSubview:self.particleBackground atIndex:0];
    
    
    self.destinationDate1 = [NSDate dateWithTimeIntervalSince1970:1478131200]; // epoch time conversion for Nov 3, National Sandwich Day
    self.destinationDate2 = [NSDate dateWithTimeIntervalSince1970:1486252800]; // nutella day, feb 5
    self.destinationDate3 = [NSDate dateWithTimeIntervalSince1970:1486598400]; // international pizza with everything (except anchovies) day, feb 9
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES]; // hide navigation bar that pops up automatically w swipe recognizer

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.particleBackground = nil;
    // self.particleBack
    [self.particleBackground presentScene:nil];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.particleBackground.frame = self.contentView.bounds;
    self.contentViewWidthConstraint.constant = self.view.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabel {
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    int units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate: self.destinationDate1 options:0]; // timer 1
    NSDateComponents *components2 = [calendar components:units fromDate:[NSDate date] toDate: self.destinationDate2 options:0]; // timer 2
    NSDateComponents *components3 = [calendar components:units fromDate:[NSDate date] toDate: self.destinationDate3 options:0]; // timer 3
    
    // set text labels
    self.countdownLabel1.text = [NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c:%ld%c", (long)[components day], 'd', (long)[components hour]+4, 'h', (long)[components minute], 'm', (long)[components second], 's'];
    
    self.countdownLabel2.text = [NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c:%ld%c", (long)[components2 day], 'd', (long)[components2 hour]+4, 'h', (long)[components2 minute], 'm', (long)[components2 second], 's'];
    
    self.countdownLabel3.text = [NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c:%ld%c", (long)[components3 day], 'd', (long)[components3 hour]+4, 'h', (long)[components3 minute], 'm', (long)[components3 second], 's'];
}

- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
  
  //  [self.particleBackground presentScene:nil]; // end spritekit when moving back
}

@end
