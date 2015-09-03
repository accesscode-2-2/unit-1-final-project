//
//  LapNotes.h
//  NSDateProject
//
//  Created by MacMan on 9/1/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LapNotes : UITableViewController
@property (nonatomic)bool dataPassing;

@property (weak,nonatomic) IBOutlet UITextField *lapTextField;

@property (strong,nonatomic) NSString *lapTextString;



@end




//@interface LapNotes : UITableViewController
//@property (nonatomic)bool dataPassing;
//
//@property (weak, nonatomic) IBOutlet UILabel *lapTextEditField;
//
//@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lapNotesAction;
