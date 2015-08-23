//
//  StopwatchTableViewController.m
//  Time
//
//  Created by Eric Sze on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
//@import QuartzCore.CADisplayLink;
@import QuartzCore;

@interface StopwatchViewController ()

@property (nonatomic) NSMutableArray *laps;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) CADisplayLink *displayLink;

@property(readonly, nonatomic) CFTimeInterval duration;
@property(nonatomic) NSInteger frameInterval;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *start;
//new addition
@property (nonatomic) NSTimeInterval totalTime;


@end

@implementation StopwatchViewController


- (IBAction)lapButton:(id)sender {
    
    NSString *currentLapTime = self.timerLabel.text;
    
    [self.laps addObject:currentLapTime];
    
    [self.tableView reloadData];
        
        
        
    
    
    
    
    
}

BOOL running;
NSTimeInterval startTime;
//NSTimeInterval startTimeNow;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.laps = [[NSMutableArray alloc] init];
    
    
//    self.laps = @[
//                 @"one",
//                 @"two",
//                 @"three"
//                 ];
    
    self.timerLabel.text = @"00:00:00";
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
}

- (IBAction)start:(UIButton *)sender {

//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerFired:)];
//    
//    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
//                       forMode:NSDefaultRunLoopMode];
    
    if (running == false) {
        // start timer
        running = true;
        startTime = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        [self updateTime];
//        [self new]; r
    } else {
        // stop timer
        [sender setTitle:@"START" forState:UIControlStateNormal];
        running = false;
    }
    
}

- (void)updateTime {
    if (running == false) return;
    
    // calculate elapsed time
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
    
    self.totalTime += elapsed;
    startTime = currentTime;

    NSLog(@"%f", self.totalTime);
    
    // extract out the minutes, seconds, and fraction of seconds from elapsed time:
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 100.0;
    
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%f",secs, self.totalTime];
    
    // update our label using a format of 0:00.0
    //self.timerLabel.text = [NSString stringWithFormat: @"%02u:%02u:%02u", mins, secs, fraction];
    
    // call updateTime again after 0.1 seconds
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.01];
}

//- (IBAction)secondStart:(UIButton *)sender {
//    [self new];
//    [self.secondStart setHidden:YES];
//}
//
//- (void)new {
////    if (running == false) return;
//    
//    running = true;
//    startTime = [NSDate timeIntervalSinceReferenceDate];
//    // calculate elapsed time
//    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
//    NSTimeInterval elapsed = currentTime - startTime;
//    
////    self.totalTime += elapsed;
////    startTimeNow = currentTime;
//    //
//    //    NSLog(@"%f", self.totalTime);
//    
//    // extract out the minutes, seconds, and fraction of seconds from elapsed time:
//    int mins = (int) (elapsed / 60.0);
//    elapsed -= mins * 60;
//    int secs = (int) (elapsed);
//    elapsed -= secs;
//    int fraction = elapsed * 100.0;
//    
//    // update our label using a format of 0:00.0
//    self.timerLabel.text = [NSString stringWithFormat: @"%02u:%02u:%02u", mins, secs, fraction];
//    
//    // call updateTime again after 0.1 seconds
//    [self performSelector:@selector(new) withObject:self afterDelay:0.01];
//}


//- (void) timerFired: (CADisplayLink *)display {
//    float currentNumber = [self.timerLabel.text floatValue];
//    float nextNumber = currentNumber + 0.001;
//    
//    self.timerLabel.text = [NSString stringWithFormat:@"%.3f", nextNumber];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.laps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.laps.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld", [self.laps count] - (long)indexPath.row];
    cell.detailTextLabel.text = self.laps[[self.laps count] - 1 - indexPath.row];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld", (long)indexPath.row];
//    cell.detailTextLabel.text = self.laps[indexPath.row];
    
    
    
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
