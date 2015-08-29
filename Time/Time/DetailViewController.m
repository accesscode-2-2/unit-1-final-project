//
//  DetailViewController.m
//  Time
//
//  Created by Artur Lan on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameYourTask;
@property (weak, nonatomic) IBOutlet UITextField *yourTime;

@property (nonatomic) NSMutableDictionary *values;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveButton:(UIButton *)sender {
//    ModelTime *timer = [[ModelTime alloc] init];
//    NSString *task = self.nameYourTask.text;
    
//    NSMutableArray *keys = [NSMutableArray arrayWithObject:self.nameYourTask.text];
//    NSMutableArray *objects = [NSMutableArray arrayWithObject:self.yourTime.text];
//    NSMutableDictionary *values = [NSMutableDictionary dictionaryWithObjects:keys forKeys:objects];
//    
//    NSLog(@"%@ %@", keys, [values objectForKey:keys]);
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *value = [NSString stringWithFormat:self.yourTime.text];
    [dict setValue:value forKey:self.nameYourTask.text];
    
    NSLog(@"%@", dict);
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
