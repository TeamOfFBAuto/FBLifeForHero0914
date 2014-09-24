//
//  GongGaoViewController.m
//  越野e族
//
//  Created by soulnear on 14-9-20.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "GongGaoViewController.h"
#import "TheActivityNewsCell.h"

@interface GongGaoViewController ()
{
}

@end

@implementation GongGaoViewController
@synthesize myWebView = _myWebView;
@synthesize html_name = _html_name;
@synthesize myTableView = _myTableView;
@synthesize data_array = _data_array;

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
    
    _data_array = [NSMutableArray array];
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"gonggaoNewsData"];
    NSLog(@"dic ----  %@",dic);
    _data_array = [NSMutableArray arrayWithArray:[dic objectForKey:@"newslist"]];
    
    if ([_html_name isEqualToString:@"index"] && _data_array.count > 0)
    {
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,400)];
        aView.backgroundColor = [UIColor whiteColor];
        
        _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,400-35)];//(iPhone5?568:480)-64)];
        _myWebView.delegate = self;
        [aView addSubview:_myWebView];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:_html_name ofType:@"html" inDirectory:@"notice_wap1"];
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [_myWebView loadRequest:request];
        
        
        for (int i = 0;i < 2;i++) {
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(13+187*i,382.5,107,1)];
            line_view.backgroundColor = RGBCOLOR(116,116,116);
            [aView addSubview:line_view];
        }
        
        UILabel * news_label = [[UILabel alloc] initWithFrame:CGRectMake(120,365,80,35)];
        news_label.text = @"新闻";
        news_label.textAlignment = NSTextAlignmentCenter;
        news_label.textColor = RGBCOLOR(3,3,3);
        news_label.font = [UIFont systemFontOfSize:18];
        [aView addSubview:news_label];
        
  
        
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableHeaderView = aView;
        [self.view addSubview:_myTableView];
    }else
    {
        _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64)];//(iPhone5?568:480)-64)];
        _myWebView.delegate = self;
        [self.view addSubview:_myWebView];
        
        
        NSString* path = [[NSBundle mainBundle] pathForResource:_html_name ofType:@"html" inDirectory:@"notice_wap1"];
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [_myWebView loadRequest:request];
    }
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"];
    float height = [height_str floatValue];
    _myWebView.scrollView.contentSize = CGSizeMake(320,height);
//    CGRect rext = _myWebView.frame;
//    rext.size.height = height;
//    _myWebView.frame = rext;
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data_array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    TheActivityNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[TheActivityNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setInfoWithDic:[_data_array objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [_data_array objectAtIndex:indexPath.row];
    newsdetailViewController * news = [[newsdetailViewController alloc] init];
    news.string_Id = [dic objectForKey:@"id"];
    [self.navigationController pushViewController:news animated:YES];
    
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
