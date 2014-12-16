//
//  PrivacyPolicyViewController.m
//  CustomNewProject
//
//  Created by soulnear on 14-12-4.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import "PrivacyPolicyViewController.h"

@interface PrivacyPolicyViewController ()
{
    UIWebView * myWebView;
    NSArray * content_array;
}

@property(nonatomic,strong)UITextView * myTextView;

@end

@implementation PrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"隐私/服务条款";
    self.leftImageName = @"logIn_close.png";
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"PrivacyPolicyList" ofType:@"plist"];
//    NSMutableDictionary * data = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    UISegmentedControl * segmentC = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"隐私条款",@"服务条款",nil]];
    segmentC.backgroundColor = [UIColor whiteColor];
    segmentC.tintColor = RGBCOLOR(195,195,195);
    segmentC.selectedSegmentIndex = 0;
    segmentC.frame = CGRectMake(12,12,DEVICE_WIDTH-24,28);
    [segmentC setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(3,3,3),
                                       NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [segmentC setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(3,3,3),
                                       NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    [segmentC addTarget:self action:@selector(changeTap:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentC];
    
    content_array = [NSArray arrayWithObjects:@"隐私条款.html",@"服务条款.html",nil];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:[content_array objectAtIndex:0] ofType:nil];
    NSURL * url = [NSURL fileURLWithPath:resourcePath];
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,40,DEVICE_WIDTH,DEVICE_HEIGHT-64-40)];
    myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    myWebView.scrollView.showsVerticalScrollIndicator = NO;
    myWebView.scrollView.bounces = NO;
    [self.view addSubview:myWebView];
    [myWebView loadRequest:[NSURLRequest requestWithURL:url] ];
}

-(void)changeTap:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i", Index);
    
    NSString *resourcePath = [ [NSBundle mainBundle] pathForResource:[content_array objectAtIndex:Index] ofType:nil];
    NSURL * url = [[NSURL alloc] initFileURLWithPath:resourcePath];
    [myWebView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void)leftButtonTap:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    content_array = nil;
    myWebView = nil;
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
