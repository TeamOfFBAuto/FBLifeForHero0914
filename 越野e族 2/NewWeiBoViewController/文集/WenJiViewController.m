//
//  WenJiViewController.m
//  FbLife
//
//  Created by soulnear on 13-3-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "WenJiViewController.h"

@interface WenJiViewController ()

@end

@implementation WenJiViewController
@synthesize bId = _bId;
@synthesize info = _info;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





-(void)initHttpRequest
{
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString* fullURL= [NSString stringWithFormat:URLWENJI,self.bId,authkey];
    
    NSLog(@"请求文集的url：%@",fullURL);
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    request.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            _info = [[WenJiFeed alloc] initWithJson:[[dic objectForKey:@"weiboinfo"] objectAtIndex:0]];
            
            [self AllContents:_info];
            
            [Load_view hide];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }];
    
    [_requset setFailedBlock:^{
        
    }];
    
    
    [request startAsynchronous];
}


-(void)AllContents:(WenJiFeed *)obj
{
    [webView loadHTMLString:_info.content  baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    myScrollView.contentSize = webView.scrollView.contentSize;
    webView.frame = CGRectMake(0,64,320,myScrollView.contentSize.height);
    
    [headView loadImageFromURL:obj.face_original withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
    
    dateLine_Label.text = obj.dateline;
    
    title_Label.text = obj.title;
    
    userName_label.text = obj.username;
}

-(void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"WenJiViewController"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"WenJiViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    self.title = @"文集正文";
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    
    self.view.backgroundColor = RGBCOLOR(217,221,219);
//
//    
//    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space.width = MY_MACRO_NAME?-4:5;
//    
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10, 8,12,21.5)];
//    
//    [button_back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    
//    self.navigationItem.leftBarButtonItems=@[space,back_item];
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
	[self initHttpRequest];
    
    if (!myScrollView)
    {
        myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-44-20)];
    }
    
    myScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myScrollView];
    
    if (!headView)
    {
        headView = [[AsyncImageView alloc] initWithFrame:CGRectMake(CELL_LEFT, CELL_TOP, 30, 30)];
        headView.layer.cornerRadius = 5;
        headView.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]);
        headView.layer.borderWidth =1.0;
        headView.layer.masksToBounds = YES;
        [myScrollView addSubview:headView];
    }
    
    
    if (!userName_label)
    {
        userName_label = [[UILabel alloc] initWithFrame:CGRectMake(50,CELL_TOP,100,30)];
        userName_label.backgroundColor = [UIColor clearColor];
        userName_label.textAlignment = NSTextAlignmentLeft;
        userName_label.font = [UIFont systemFontOfSize:14];
        [myScrollView addSubview:userName_label];
    }
    
    
    if (!dateLine_Label)
    {
        dateLine_Label = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-110,CELL_TOP,100,30)];
        dateLine_Label.backgroundColor = [UIColor clearColor];
        dateLine_Label.font = [UIFont systemFontOfSize:10];
        dateLine_Label.textColor = RGBCOLOR(164,132,98);
        dateLine_Label.textAlignment = NSTextAlignmentRight;
        [myScrollView addSubview:dateLine_Label];
    }
    
    
    if (!title_Label)
    {
        title_Label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_LEFT,CELL_NAME_TOP+30,DEVICE_WIDTH-CELL_LEFT*2,20)];
        title_Label.backgroundColor = [UIColor clearColor];
        title_Label.textAlignment = NSTextAlignmentLeft;
        title_Label.font = [UIFont systemFontOfSize:16];
        [myScrollView addSubview:title_Label];
    }
    
    
    if (!line_imageView)
    {
        line_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,65,DEVICE_WIDTH,2)];
        line_imageView.image = [personal getImageWithName:@"blog_sp"];
        [myScrollView addSubview:line_imageView];
    }
    
    
    if (!webView)
    {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64,DEVICE_WIDTH,DEVICE_HEIGHT-20-44-64)];
    }
    
    webView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    webView.backgroundColor = [UIColor clearColor];
    [webView scalesPageToFit];
    [myScrollView addSubview:webView];
    
    
    if (!Load_view)
    {
        Load_view = [[loadingview alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-20-44)];
        [self.view addSubview:Load_view];
    }else
    {
        [Load_view show];
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    
    float webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
    //    CGFloat webViewHeight=[webView1.scrollView contentSize].height;
    CGRect newFrame = webView1.frame;
    newFrame.size.height = webViewHeight+15;
    newFrame.origin.y = 64;
    webView1.frame = newFrame;
    myScrollView.contentSize = CGSizeMake(0,webViewHeight+80);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end





