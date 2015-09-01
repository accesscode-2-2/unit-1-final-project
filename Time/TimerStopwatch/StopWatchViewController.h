






#import <UIKit/UIKit.h>


@interface StopWatchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

//---------------------------------------------------------------------------------
@property (strong, nonatomic) IBOutlet UIButton *startTime;

@property (strong, nonatomic) IBOutlet UIButton *pauseTime;
@property (strong, nonatomic) IBOutlet UIButton *resetTime;

@property (strong, nonatomic) IBOutlet UIButton *addLapToTableView;

//---------------------------------------------------------------------------------

@property (nonatomic) NSTimer* timer;
@property (nonatomic) NSDate*  beginTime;


@property (nonatomic) NSTimeInterval totalSessonTime;  //records the time between each "Start and "Pause."
@property (nonatomic) NSTimeInterval totalTime;        //adds the total time between all session times.



//----------------------------------------------------------------------------------

@property (nonatomic, strong) NSMutableArray* heldLapsForTableView;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UITableView *lapsTableView;

@end