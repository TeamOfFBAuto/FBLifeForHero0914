//
//  GongGaoViewController.m
//  越野e族
//
//  Created by soulnear on 14-9-20.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "GongGaoViewController.h"

@interface GongGaoViewController ()

@end

@implementation GongGaoViewController
@synthesize myWebView = _myWebView;
@synthesize html_name = _html_name;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64)];
    _myWebView.delegate = self;
    [self.view addSubview:_myWebView];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:_html_name ofType:@"html" inDirectory:@"notice_wap1"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [_myWebView loadRequest:request];
    
    
    
    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [_myWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"];
    float height = [height_str floatValue];
    _myWebView.scrollView.contentSize = CGSizeMake(320,height);
    
}

#pragma mark - dealloc
-(void)dealloc
{
    _myWebView = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
