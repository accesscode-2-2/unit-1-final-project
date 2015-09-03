//
//  WebVC.h
//  NSDateProject
//
//  Created by MacMan on 9/3/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong,nonatomic) IBOutlet UILabel *webSiteUrl;

@property (strong,nonatomic) NSString *webSiteText;



@end
