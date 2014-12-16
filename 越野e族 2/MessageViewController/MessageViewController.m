//
//  MessageViewController.m
//  FbLife
//
//  Created by soulnear on 13-8-2.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "MessageViewController.h"
#import "CustomMessageCell.h"
#import "MessageInfo.h"
#import "FBNotificationViewController.h"
#import "MyChatViewController.h"
#import "LogInViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize myTableView = _myTableView;
@synthesize request_ = _request_;
@synthesize data_array = _data_array;
@synthesize newsMessage_request = _newsMessage_request;
@synthesize string_messageorfbno;



+(MessageViewController *)shareManager
{
    static MessageViewController * message = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        message = [[self alloc] init];
    });
    return message;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        authcode = [[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
        
        if (authcode.length>0)
        {
            //            [self checkNewMessage];
            
            theTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
            
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAuthCode:) name:USER_AUTHOD object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTheTimer) name:@"removeTheTimer" object:nil];
        
    }
    return self;
}

#pragma mark-删除

-(void)removeTheTimer
{
    [theTimer invalidate];
    theTimer = nil;
}

#pragma mark-获取到私信的通知
-(void)notificationAuthCode:(NSNotification *)notification
{
    authcode = (NSString *)notification.object;
    theTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
}


#pragma mark-获取私信列表
-(void)initHttpRequest
{
    if (_request_)
    {
        [_request_ cancel];
        _request_.delegate  = nil;
        _request_ = nil;
    }
    
    
    NSString * string = [[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSURL * fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://msg.fblife.com/api.php?c=index&authcode=%@",string]];
    
    
    NSLog(@"私信首页url --  %@",fullUrl);
    
    
    _request_ = [ASIHTTPRequest requestWithURL:fullUrl];
    
    _request_.delegate = self;
    
    _request_.shouldAttemptPersistentConnection = NO;
    
    
    __block ASIHTTPRequest * request = _request_;
    
    __weak typeof(self) bself = self;
    
    [request setCompletionBlock:^{
        
        [label_havenoshuju stopLoading:1];
        
        @try {
            
            NSDictionary * allDic = [_request_.responseData objectFromJSONData];
            
            
            [bself.data_array removeAllObjects];
            NSArray * infoArray = [allDic objectForKey:@"info"];
            
            NSLog(@"info===%@",infoArray);
            
            for (NSDictionary * dic in infoArray)
            {
                MessageInfo * info = [[MessageInfo alloc] initWithDictionary:dic];
                
                [bself.data_array addObject:info];
                
            }
            NSLog(@"这里。。。。。%@",self.data_array);
            
            NSUserDefaults *stau=[NSUserDefaults standardUserDefaults];
            [stau setObject:infoArray forKey:@"whyhavenodata"];
            NSLog(@"youmuyou==%@",[stau objectForKey:@"whyhavenodata"]);
            [stau synchronize];
            
            
            if (bself.data_array.count == 0)
            {
                label_havenoshuju.normalLabel.text = @"没有私信消息";
                bself.myTableView.tableFooterView = label_havenoshuju;
            }else
            {
                label_havenoshuju.normalLabel.text = @"";
            }
            
            
            [bself.myTableView reloadData];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        [label_havenoshuju stopLoading:1];
    }];
    
    [_request_ startAsynchronous];
    
    
    
}

#pragma mark-newMessageViewControllerDelegate

-(void)sucessToSendWithName:(NSString *)userName Uid:(NSString *)theUid
{
    MessageInfo * info = [[MessageInfo alloc] init];
    
    info.to_username = userName;
    
    info.othername = userName;
    
    info.to_uid = theUid;
    
    info.from_username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    
    info.from_uid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
    
    MyChatViewController * chat = [[MyChatViewController alloc] init];
    
    chat.info = info;
    
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self.navigationController pushViewController:chat animated:YES];
}

-(void)writeMessage:(UIButton *)button
{
    NewMessageViewController * newMessage = [[NewMessageViewController alloc] init];
    newMessage.delegate = self;
    [self presentViewController:newMessage animated:YES completion:NULL];
}

-(void)cleanTheOldData
{
    NSUserDefaults *stau=[NSUserDefaults standardUserDefaults];
    [stau removeObjectForKey:@"whyhavenodata"];
    [stau synchronize];
}


-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginEvent:@"MessageViewController"];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(cleanTheOldData) name:@"clearolddata" object:nil];
    [self initHttpRequest];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        if (NewsMessageNumber > 0 || self.data_array.count == 0)
        {
            [self initHttpRequest];
        }
        
        NSString *string_uid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]];
        NSLog(@"string_uid==%@",string_uid);
        if (string_uid.length==0||[string_uid isEqualToString:@"(null)"]) {
            [self receivemyuid];
        }
    }
    
    else{
        //        [self viewDidLoad];
        //        LogInViewController *login=[[LogInViewController alloc]init];
        //        [self presentViewController:login animated:YES completion:nil];
    }
    
    
//    self.navigationController.navigationBarHidden = NO;
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
}


-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    //    self.leveyTabBarController.tabBar.tixing_label.hidden = YES;
    
    [MobClick endEvent:@"MessageViewController"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(celearolddatafirst) name:@"LogIn" object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(celearolddatafirst) name:@"clean" object:nil];
    
    
    isnewfbnotification=NO;
    NewsMessageNumber = 0;
    numberoftixing=0;
    //    [self AllNumberofNotification];
    array_whichperson=[[NSMutableArray alloc]init];
    
    self.data_array = [[NSMutableArray alloc] init];
    
//    self.navigationController.navigationBarHidden=NO;
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    
//    UIBarButtonItem * space_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space_button.width = MY_MACRO_NAME?-4:5;
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(5,8,12,21.5)];
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back@2x.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    
//    self.navigationItem.leftBarButtonItems=@[space_button,back_item];
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    
//    self.navigationItem.title = @"消息中心";
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    UIButton * button_send=[[UIButton alloc]initWithFrame:CGRectMake(270,8,39/2,38/2)];
//    [button_send addTarget:self action:@selector(writeMessage:) forControlEvents:UIControlEventTouchUpInside];
//    [button_send setBackgroundImage:[personal getImageWithName:@"weibo_write_image@2x"] forState:UIControlStateNormal];
//    //    [button_send setTitle:@"写私信" forState:UIControlStateNormal];
//    [button_send.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    
//    self.navigationItem.rightBarButtonItems = @[space_button,[[UIBarButtonItem alloc] initWithCustomView:button_send]];
    
    
    self.title = @"私信";
    
    self.rightImageName = WRITE_DEFAULT_IMAGE;
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    
    
 

    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, - self.myTableView.bounds.size.height, self.view.frame.size.width, self.myTableView.bounds.size.height)];
		view.delegate = self;
        //  view.backgroundColor=[UIColor redColor];
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    self.myTableView.rowHeight = 76;
    
    if (MY_MACRO_NAME)
    {
        self.myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    self.myTableView.tableHeaderView = _refreshHeaderView;
    
    [self.view addSubview:self.myTableView];
    
    
    label_havenoshuju = [[LoadingIndicatorView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,40)];
    
//    self.myTableView.tableFooterView = label_havenoshuju;
    
    [label_havenoshuju startLoading];
    
    UIView * vvvv = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,0)];
    
    self.myTableView.tableFooterView = vvvv;
    
    [self getmychachearray];
 
}

#pragma mark - 返回

-(void)leftButtonTap:(UIButton *)sender
{
    [_request_ clearDelegatesAndCancel];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightButtonTap:(UIButton *)sender
{
    [self writeMessage:sender];
}

//-(void)leftButtonTap:(UIButton *)sender
//{
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//    app.root_nav.navigationBarHidden = YES;
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

#pragma mark-在缓存中去数据
-(void)celearolddatafirst
{
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"whyhavenodata"];
    NewsMessageNumber = 0;
    [self.data_array removeAllObjects];
    
    [self.myTableView reloadData];
}
-(void)getmychachearray
{
    NSArray * infoArray =[[NSUserDefaults standardUserDefaults]objectForKey:@"whyhavenodata"];
    
    for (NSDictionary * dic in infoArray)
    {
        MessageInfo * info = [[MessageInfo alloc] initWithDictionary:dic];
        
        [self.data_array addObject:info];
        
    }
    
    if (self.data_array.count>0)
    {
        
        [self.myTableView reloadData];
        
    }else
    {
//        [label_havenoshuju startLoading];
        NSLog(@"=--=-=-=-=-=-=-=-=-=-=-=");
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"1";
}


#pragma mark-TableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data_array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    CustomMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[CustomMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.headImageView.image = nil;
    cell.NameLabel.text = @"";
    cell.timeLabel.text = @"";
    cell.contentLabel1.text = @"";
    cell.contentLabel.text = @"";
    
 
    cell.tixing_label.hidden=YES;
    
    MessageInfo * info = [self.data_array objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cell setAllViewWithType:0];
    
    [cell setInfoWithType:0 withMessageInfo:info];
    
    UIColor *color = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor =color;
    return cell;
}

-(float )boolLabelLength:(NSString *)strString
{
    CGSize labsize = [strString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(170, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    return labsize.width;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomMessageCell * cell = (CustomMessageCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
    
   
    cell.tixing_label.hidden = YES;
    
    MessageInfo * info = [self.data_array objectAtIndex:indexPath.row];
    
    MyChatViewController * chat = [[MyChatViewController alloc] init];
    
    chat.info = info;
    //        self.leveyTabBarController.tabBar.tixing_label.hidden=YES;
    
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:chat animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deletemypersonalmessage:indexPath.row];;
        [self.data_array removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source.
        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark-删除私信
-(void)deletemypersonalmessage:(NSInteger)indexPathofrow
{
    MessageInfo * info = [self.data_array objectAtIndex:indexPathofrow];
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:@"http://msg.fblife.com/api.php?c=manage&a=delindex&uid=%@&authcode=%@",info.otheruid,authkey];
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSLog(@"个人信息 -=-=  %@",dic);
        
        @try
        {
            if ([[dic objectForKey:@"errcode"] intValue] !=1)
            {
                NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
                NSLog(@"dictionary=%@",dictionary);
                
                //            [_myTableView reloadData];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
    
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(editingStyle == UITableViewCellEditingStyleInsert)
//    {
//    }
//    else if(editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        //删除一条条目时，更新numberOfRowsInSection
//
//        DraftDatabase *drafts=[array_info objectAtIndex:indexPath.row];
//        [DraftDatabase deleteStudentBythecontent:drafts.content];
//        [array_info removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationBottom];
//    }
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


#pragma mark-获取通知总数
//-(void)AllNumberofNotification{
//    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
//
//
//}
-(void)checkallmynotification
{
    NSString *string_code=[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD];
    
    //    NSLog(@"steing_code ----   %@",string_code);
    
    if (string_code.length !=0 && ![string_code isEqual:[NSNull null]])
    {
        if (!allnotificationtool)
        {
            allnotificationtool=[[downloadtool alloc]init];
        }
        
        [allnotificationtool setUrl_string:[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]];
        
        //  NSLog(@"未读消息接口 ----   %@",[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]);
        
        allnotificationtool.delegate=self;
        [allnotificationtool start];
    }
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        if (tool==allnotificationtool)
        {
            NewsMessageNumber = 0;
            
            NSDictionary * alertnum_dic = [dic objectForKey:@"alertnum"];
            
              NSLog(@"未读消息 ------  %@",alertnum_dic);
            
            for (int i = 0;i <= 16;i++)
            {
                if (i == 6)
                {
                    if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                    {
                        //                        self.leveyTabBarController.tabBar.tixing_label.hidden = NO;
                        [self initHttpRequest];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"postNewMessage" object:nil];
                    }
                }else
                {
                    NewsMessageNumber += [[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue];
                }
            }
            
            
            
//            //   NewsMessageNumber=8;
//            if (NewsMessageNumber != 0)
//            {
//                //                self.leveyTabBarController.tabBar.tixing_label.hidden = NO;
//                isnewfbnotification=YES;
//                
//                numberoftixing=NewsMessageNumber;
//                [self.myTableView reloadData];
//            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
-(void)receivemyuid
{
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:URL_USERMESSAGE,@"(null)",authkey];
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    __weak typeof(self) bself = self;
    
    [_requset setCompletionBlock:^{
        NSDictionary * dic = [request.responseData objectFromJSONData];
        NSLog(@"个人信息 -=-=  %@",dic);
        
        
        @try {
            if ([[dic objectForKey:@"errcode"] intValue] !=1)
            {
                NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
                NSLog(@"dictionary=%@",dictionary);
                
                NSString *string_uid=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]];
                [[NSUserDefaults standardUserDefaults]setObject:string_uid forKey:USER_UID];
                NSLog(@"string_uid===%@",string_uid);
                
                [bself.myTableView reloadData];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
}


-(void)downloadtoolError{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
    
    
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
    
}
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self initHttpRequest];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


-(void)dealloc
{
    
    
    
}


@end






























