//
//  guanzhuViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-1.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "guanzhuViewController.h"
#import "guanzhuCell.h"
#import "PersonInfo.h"
#import "NewMineViewController.h"



@interface guanzhuViewController ()
{
    guanzhuCell *cell;
    AlertRePlaceView *  _replaceAlertView;
    
    ASIHTTPRequest * request;
}

@end

@implementation guanzhuViewController
@synthesize dataArray = _dataArray;
@synthesize theTitle = _theTitle;
@synthesize theUid = _theUid;




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
    
    NSString * fullurl;// = [NSString stringWithFormat:URL_GUANZHULIST,@"0",authkey,pageCount];
    
    
    if ([self.theTitle isEqualToString:@"粉丝"])
    {
        fullurl = [NSString stringWithFormat:URL_FANSLIST,_theUid,authkey,pageCount];
    }else
    {
        fullurl = [NSString stringWithFormat:URL_GUANZHULIST,_theUid,authkey,pageCount];
    }
    
    
    if ([_theUid integerValue]>10)
    {
        if (request)
        {
            [request cancel];
            request.delegate = nil;
            request = nil;
        }
        
        
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullurl]];
        
        request.tag = 100;
        
        request.delegate = self;
        
        [request startAsynchronous];
        NSLog(@"请求的数据-===-=  %@",fullurl);
        
    }else{
        NSLog(@"没有开通");
        
    }
    
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    @try
    {
        if (request.tag == 100)
        {
            [loadview stopLoading:1];
            
            if (pageCount == 1)
            {
                [_dataArray removeAllObjects];
            }
            
            NSDictionary * dic = [[request.responseData objectFromJSONData] objectForKey:@"data"];
            
            if (dic.count == 0)
            {
                
                //        loadview.hidden = YES;
                loadview.normalLabel.text = @"没有更多了";
                return;
            }
            
            NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
            
            NSArray *arr1 = [[dic allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
            
            for (NSString * key in arr1)
            {
                PersonInfo * info = [[PersonInfo alloc] initWithDictionary:[dic objectForKey:key]];
                if (info.username.length !=0)
                {
                    [_dataArray addObject:info];
                    
                    if (([_theTitle isEqualToString:@"关注"] && [myUid isEqualToString:_theUid]))
                    {
                        info.isboth = @"1";
                    }
                }
            }
            
            [_guanzhu_tab reloadData];
            
            [Load_view hide];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request1
{
    if (request1.tag == 100)
    {
        NSLog(@"error == %@",request1.error);
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
    }
}

#pragma mark-显示框
-(void)hidefromview
{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
}
-(void)hidealert
{
    _replaceAlertView.hidden=YES;
}

-(void)back:(UIButton *)sender
{
//    [request cancelAuthentication];
//    request.delegate = nil;
//    request = nil;
    
    [request clearDelegatesAndCancel];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"guanzhuViewController"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"guanzhuViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    myUid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
    
    self.navigationItem.title = _theTitle;
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    UIBarButtonItem * spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    spaceBar.width = MY_MACRO_NAME?-4:5;
//    
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,12,21.5)];
//    [button_back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItems=@[spaceBar,back_item];
    
    
    _dataArray = [[NSMutableArray alloc] init];
    pageCount = 1;
    [self initHttpRequest];
    
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, 320, 40)];
    loadview.backgroundColor=[UIColor clearColor];
    
    _guanzhu_tab=[[UITableView alloc]initWithFrame:CGRectMake(0,0,320,iPhone5?iphone5fram:iphone4fram) style:UITableViewStylePlain];
    _guanzhu_tab.backgroundColor = RGBCOLOR(248,248,248);
    _guanzhu_tab.delegate=self;
    
    _guanzhu_tab.dataSource=self;
    _guanzhu_tab.tableFooterView = loadview;
    self.view=_guanzhu_tab;
    
    if (IOS_VERSION>=7.0)
    {
        _guanzhu_tab.separatorInset = UIEdgeInsetsZero;
    }
    
    
    
    
    if (_refreshHeaderView == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-_guanzhu_tab.bounds.size.height, self.view.frame.size.width, _guanzhu_tab.bounds.size.height)];
		view.delegate = self;
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    [_guanzhu_tab addSubview:_refreshHeaderView];
    
    
    if (!Load_view)
    {
        Load_view = [[loadingview alloc] initWithFrame:CGRectMake(0,0,320,iPhone5?568-20-44:460-44)];
        [self.view addSubview:Load_view];
    }else
    {
        [Load_view show];
    }
    
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
}

#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_guanzhu_tab];
    
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40) && scrollView.contentOffset.y > 0)
    {
        if (![loadview.normalLabel.text isEqualToString:@"没有更多了"])
        {
            [loadview startLoading];
            pageCount++;
            [self initHttpRequest];
        }
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    pageCount = 1;
	[self initHttpRequest];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *string_identifier=@"cell";
    
    UITableViewCell *  cell1=[tableView dequeueReusableCellWithIdentifier:string_identifier];
    
    if (!cell1)
    {
        cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string_identifier];
    }
    
    
    for (UIView * view in cell1.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell1.contentView.backgroundColor = [UIColor whiteColor];//(248,248,248);
    cell1.backgroundColor = [UIColor clearColor];
    
    PersonInfo * info = [self.dataArray objectAtIndex:indexPath.row];
    
    
    AsyncImageView * imagetouxiang=[[AsyncImageView alloc]initWithFrame:CGRectMake(23/2,23/2,50,50)];
    
    imagetouxiang.layer.cornerRadius = 5;
    imagetouxiang.layer.borderColor = (__bridge  CGColorRef)([UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]);
    imagetouxiang.layer.borderWidth =1.0;
    imagetouxiang.layer.masksToBounds = YES;
    
    [imagetouxiang loadImageFromURL:info.face_original withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
    
    [cell1.contentView addSubview:imagetouxiang];
    
    UILabel * label_username=[[UILabel alloc]initWithFrame:CGRectMake(75,23/2,200, 20)];
    label_username.text = info.username;
    label_username.backgroundColor = [UIColor clearColor];
    label_username.font = [UIFont systemFontOfSize:18];
    [cell1.contentView addSubview:label_username];
    
    
    NSString * location = info.city;
    if (info.city.length == 0)
    {
        location = @"未知";
    }
    
    UILabel * label_location=[[UILabel alloc]initWithFrame:CGRectMake(75,41.5,200,20)];
    label_location.text = [NSString stringWithFormat:@"所在地:%@",location];
    label_location.font = [UIFont systemFontOfSize:15];
    label_location.backgroundColor = [UIColor clearColor];
    label_location.textColor = RGBCOLOR(137,137,137);
    [cell1.contentView addSubview:label_location];
    
    
    
    //    if ([_theTitle isEqualToString:@"粉丝"] || ([_theTitle isEqualToString:@"关注"] && ![myUid isEqualToString:_theUid]))
    //    {
    cell1.accessoryType = UITableViewCellAccessoryNone;
    
    UIButton * attention_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    attention_button.frame = CGRectMake(240,22.75,135/2,55/2);
    
    attention_button.tag = 100000 + indexPath.row;
    
    if ([info.isboth intValue]==0)
    {
        [attention_button setImage:[UIImage imageNamed:@"fans_add_guanzhu.png"] forState:UIControlStateNormal];
    }else
    {
        [attention_button setImage:[UIImage imageNamed:@"fans_plus_guanzhu.png"] forState:UIControlStateNormal];
    }
    
    [attention_button addTarget:self action:@selector(attentionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (![myUid isEqualToString:info.uid])
    {
        [cell1.contentView addSubview:attention_button];
    }
    
    return cell1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonInfo * info = [_dataArray objectAtIndex:indexPath.row];
    [_guanzhu_tab deselectRowAtIndexPath:[_guanzhu_tab indexPathForSelectedRow] animated:YES];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    mine.uid = info.uid;
    //    mine.isPop = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:mine animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}



-(void)attentionButton:(UIButton *)button
{
    [self animationStar];
    
    PersonInfo * info = [self.dataArray objectAtIndex:button.tag-100000];
    
    BOOL attention_flg = [info.isboth intValue];
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString* fullURL= [NSString stringWithFormat:attention_flg?URL_QUXIAOGUANZHU:URL_GUANZHU,info.uid,authkey];
    
    ASIHTTPRequest * request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request1;
    
    request1.delegate = self;
    
    [_requset setCompletionBlock:^{
        NSDictionary * dic = [request1.responseData objectFromJSONData];
        
        NSString * string = [dic objectForKey:@"data"];
        
        if ([string isEqualToString:@"取消成功"] || [string isEqualToString:@"添加成功"])
        {
            [button setImage:[UIImage imageNamed:attention_flg?@"fans_add_guanzhu.png":@"fans_plus_guanzhu@2x.png"] forState:UIControlStateNormal];
            
            info.isboth = [NSString stringWithFormat:@"%d",!attention_flg];
            
            [self animationEnd:!attention_flg];
            
            [self.dataArray replaceObjectAtIndex:(button.tag-100000) withObject:info];
            
        }else
        {
            UIAlertView * alet = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注失败,请检查您当前网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            [alet show];
        }
    }];
    
    [_requset setFailedBlock:^{
        UIAlertView * alet = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注失败,请检查您当前网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alet show];
    }];
    
    [request1 startAsynchronous];
    
}



-(void)animationStar
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:NS_DOING];
    [hud setActivity:NO];
    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}

-(void)animationEnd:(BOOL)isFlg
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setCaption:isFlg?@"添加成功":@"取消成功"];
    [hud setActivity:NO];
    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
}



-(void)dealloc
{
    [request clearDelegatesAndCancel];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











