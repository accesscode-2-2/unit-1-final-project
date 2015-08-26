//
//  ViewController.m
//  BereketsStopWatch2.0
//
//  Created by Bereket  on 8/25/15.
//  Copyright (c) 2015 Bereket . All rights reserved.
//

#import "StopWatchViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.LapsArray = [[NSMutableArray alloc] init];
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.LapsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lapsCellIdentifier" forIndexPath:(indexPath)];
    
    cell.textLabel.text=@"bananas";
    return cell;
}

//--------------------------------------------------------------------------------------------------------

//-----The method below holds a series of conditionals that dictate the functions of our 4 buttons-----
- (IBAction)buttonTapped:(id)sender {
    
    if(sender == self.StartTimer){
        
        
        //starts recording time (t=0 at this point)
        self.startTime =[[NSDate alloc] init];
        
        //starts the timer with its interval
        self.timer=[NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        //adds timer to run loop
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
    }
    else if (sender == self.PauseTimer){
        
        self.totalTime =  self.totalTime + self.totalSessonTime;
        [self.timer invalidate];
        
    }
    else if (sender == self.ResetTimer){
        
        [self.timer invalidate];
        self.startTime= [[NSDate alloc] init];
        self.totalTime=00.00;
        self.TimeLabel.text= @"00.00";
        
    }
    else if (sender == self.AddLappToTableView){
        
        [self.LapsArray addObject:@2.20];
        [self.lapsTableView reloadData];
        
    }
}
//----------------------------END OF BUTTON CONTROL METHOD-----------------------------------------------

- (void)timerFired:(NSTimer *)timer {
    
    // get the current time
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessonTime = [now timeIntervalSinceDate:self.startTime];
    NSTimeInterval distance =  self.totalTime + self.totalSessonTime;
    
    self.TimeLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    NSLog(@"%f", distance);
}
//--------------------------------------------------------------------------------------------------------



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
