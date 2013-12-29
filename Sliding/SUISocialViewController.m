//
//  SUISocialViewController.m
//  Sliding
//
//  Created by Jacob Sokolov on 29/12/13.
//  Copyright (c) 2013 Jacob Sokolov. All rights reserved.
//

#import "SUISocialViewController.h"
#import "SUIViewController.h"

@interface SUISocialViewController ()
{
    UIWebView * webView;
    
    UIButton * button;
    
    UIButton * titleButton;
}

@end

@implementation SUISocialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(0, 0, 50, 50)];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [titleButton setFrame:CGRectMake(0, 0, 100, 100)];
    [titleButton setTitle:@"www.twitter.com/yashacorp" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(openInSafari) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.titleView = titleButton;
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.twitter.com/yashacorp"]]];
    
    [self.view addSubview:webView];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)openInSafari
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/yashacorp"]];
}

@end
