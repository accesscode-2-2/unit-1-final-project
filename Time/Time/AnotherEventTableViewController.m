////
////  AnotherEventTableViewController.m
////  Time
////
////  Created by Christian Maldonado on 9/2/15.
////  Copyright (c) 2015 Mike Kavouras. All rights reserved.
////
//
//#import "AnotherEventTableViewController.h"
//
//@interface AnotherEventTableViewController ()
//
//
//@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
//
//
//@property (strong, nonatomic)NSDate *destinationDay;
//
//@property (strong, nonatomic)NSTimer *timer;
//
//@end
//
//@implementation AnotherEventTableViewController
//-(void)viewDidLoad{
//    [super viewDidLoad];
//    
//    self.destinationDay = [NSDate dateWithTimeIntervalSince1970:1450155600];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel)userInfo:nil repeats:YES];
//
//    
//}
//
//
//
//- (IBAction)updateLabel{
//    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    int units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    
//    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate: self.destinationDay options:0];
//   
//   self.countdownLabel.text = [NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c:%ld%c", (long)[components day], 'd', (long)[components hour]+4, 'h', (long)[components minute], 'm', (long)[components second], 's'];
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventIdentifier" forIndexPath:indexPath];
//    
//    
//    
//        return cell;
//}
//
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
