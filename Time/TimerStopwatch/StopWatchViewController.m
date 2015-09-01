






#import "StopWatchViewController.h"

@interface StopWatchViewController ()

@end

@implementation StopWatchViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.lapsTableView.delegate = self;
    self.lapsTableView.dataSource=self;
    self.heldLapsForTableView = [[NSMutableArray alloc] init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.heldLapsForTableView.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath    {
    
    NSString* lapsCell= @"lapsIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lapsCell forIndexPath:(indexPath)];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.heldLapsForTableView[indexPath.row]];
    
    return cell;
}


- (IBAction)buttonTapped:(id)sender {
    if (sender == self.startTime){
        self.beginTime = [[NSDate alloc] init];
        
        self.timer=[NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        //adds timer to run loop
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
    }
    else if(sender == self.pauseTime){
        self.totalTime =  self.totalTime + self.totalSessonTime;
        [self.timer invalidate];
    }
    else if(sender == self.resetTime){
        [self.timer invalidate];
        self.beginTime= [[NSDate alloc] init];
        self.totalTime=00.00;
        self.timeLabel.text= @"00.00";
        
        [self.heldLapsForTableView  removeAllObjects];
        [self.lapsTableView reloadData];
        
    }

    else if (sender == self.addLapToTableView){
        
        [self.heldLapsForTableView addObject:self.timeLabel.text];
        
        
       [self.lapsTableView reloadData];
        
        NSLog(@"added lap");
    }
}
- (void)timerFired:(NSTimer*)timer {
    
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessonTime = [now timeIntervalSinceDate:self.beginTime];
    NSTimeInterval distance =  self.totalTime + self.totalSessonTime;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    NSLog(@"%f", distance);

    }
    
    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

@end