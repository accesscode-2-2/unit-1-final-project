//
//  WebVC.m
//  NSDateProject
//
//  Created by MacMan on 9/3/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "WebVC.h"
#import "ViewController.h"

@interface WebVC ()

@end

@implementation WebVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Do any additional setup after loading the view.
        //bind the labels to the string values
        self.webSiteUrl.text = self.webSiteText;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:_webSiteText];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    

    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
