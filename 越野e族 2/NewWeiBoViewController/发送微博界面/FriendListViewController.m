//
//  FriendListViewController.m
//  FbLife
//
//  Created by szk on 13-3-13.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "FriendListViewController.h"
#import "JSONKit.h"
#import "PersonInfo.h"
#import "MyChatViewController.h"
#import "MessageInfo.h"

@interface FriendListViewController ()
{
    AlertRePlaceView * _replaceAlertView;
}

@end

@implementation FriendListViewController

@synthesize myTableView = _myTableView;
@synthesize uid = _uid;
@synthesize dataArray = _dataArray;
@synthesize delegate = _delegate;
@synthesize tempArray = _tempArray;
@synthesize _listContent;
@synthesize RecentContact_array = _RecentContact_array;

@synthesize request_friend = _request_friend;

@synthesize request_recentcontact = _request_recentcontact;

@synthesize title_name_string = _title_name_string;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)initRecentContactRequest
{
    
    if (_request_recentcontact)
    {
        [_request_recentcontact cancel];
        _request_recentcontact.delegate = nil;
        _request_recentcontact = nil;
    }
    
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString * url = [NSString stringWithFormat:@"http://msg.fblife.com/api.php?c=getrecent&authcode=%@",authkey];
    
    NSLog(@"最近联系人url：%@",url);
    
    _request_recentcontact = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    _request_recentcontact.delegate = self;
    
    __block ASIHTTPRequest * request__ = _request_recentcontact;
    
    
    [request__ setCompletionBlock:^{
        
        @try {
            [self.RecentContact_array removeAllObjects];
            
            NSDictionary * dic = [_request_recentcontact.responseData objectFromJSONData];
            
            NSLog(@"最近联系人 ----  %@",dic);
            NSArray * array = [dic objectForKey:@"info"];
            
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:array forKey:@"RecentContact"];
            
            [self exchangeContent:array];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    [_request_recentcontact startAsynchronous];
}


-(void)initHttpRequest
{
    
    if (_request_friend)
    {
        [_request_friend cancel];
        _request_friend.delegate = nil;
        _request_friend = nil;
    }
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    
    NSString* fullURL;
    
    //    fullURL= [NSString stringWithFormat:URL_GUANZHULIST,[_uid stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding], authkey,pageCount];
    
    fullURL= [NSString stringWithFormat:URL_ALL_GUANZHULIST,authkey];
    
    
    
    NSLog(@"请求的url:%@",fullURL);
    
    _request_friend = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
    
    _request_friend.shouldAttemptPersistentConnection = NO;
    
    [_request_friend setDelegate:self];
    
    
    __block ASIHTTPRequest * request = _request_friend;
    
    [request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[_request_friend.responseData objectFromJSONData]];
            
            NSDictionary * content = [dic objectForKey:@"data"];
            
            [self exchangeData:content isCache:NO];
        }
        @catch (NSException *exception) {
            NSLog(@"exception ---  %@",exception);
        }
        @finally {
            
        }
    }];
    
    [_request_friend startAsynchronous];
    
}


-(void)requestFailed:(ASIHTTPRequest *)request1
{
    NSLog(@"error == %@",request1.error);
    //    [refreshButton.layer removeAnimationForKey:@"animation"];
    
    _replaceAlertView.hidden=NO;
    [_replaceAlertView hide];
    
}

#pragma mark-显示框
-(void)hidefromview{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
    NSLog(@"?????");
}
-(void)hidealert{
    _replaceAlertView.hidden=YES;
    
}



-(void)exchangeContent:(NSArray *)array
{
    for (NSDictionary * dic1 in array)
    {
        PersonInfo * info = [[PersonInfo alloc] initWithDictionary:dic1];
        
        if (info.username.length>0)
        {
            [self.RecentContact_array addObject:info];
        }
    }
    
    [_myTableView reloadData];
}

-(void)exchangeData:(NSDictionary *)content isCache:(BOOL)isCache
{
    [self.dataArray removeAllObjects];
    [_listContent removeAllObjects];
    [self.tempArray removeAllObjects];
    [number_array removeAllObjects];
    
    @try {
        if (content.count == 0)
        {
            return;
        }
        
        
        NSArray * array123 = [content allKeys];
        
        for (int i = 0;i < [array123 count];i++)
        {
            //        PersonInfo * theInfo = [[PersonInfo alloc] initWithDictionary:[content objectForKey:[[content allKeys] objectAtIndex:i]]];
            
            PersonInfo * theInfo = [[PersonInfo alloc] init];
            
            theInfo.uid = [NSString stringWithFormat:@"%@",[array123 objectAtIndex:i]];
            
            theInfo.username = [NSString stringWithFormat:@"%@",[content objectForKey:[array123 objectAtIndex:i]]];
            
            if (theInfo.username.length != 0)
            {
                [_dataArray addObject:theInfo];
            }
        }
        
        ///////////////////////////////////////////////////////////////
        UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];//这个是建立索引的核心
        
        //    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
        
        for (PersonInfo * info in self.dataArray)
        {
            NSInteger sect = [theCollation sectionForObject:info collationStringSelector:@selector(getFirstName)];//getLastName是实现中文安拼音检索的核心，见NameIndex类
            info._sectionNum = sect; //设定姓的索引编号
            
            if (![number_array containsObject:[NSNumber numberWithInt:sect]])
            {
                [number_array addObject:[NSNumber numberWithInt:sect]];
            }
        }
        
        NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        
        NSArray *arr1 = [number_array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
        
        [number_array removeAllObjects];
        
        [number_array addObjectsFromArray:arr1];
        
        NSInteger highSection = [[theCollation sectionTitles] count]; //返回的应该是27，是a－z和＃
        
        NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection]; //tableView 会被分成27个section
        
        for (int i=0; i<=highSection; i++)
        {
            
            NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
            [sectionArrays addObject:sectionArray];
        }
        
        for (PersonInfo * item in self.dataArray)
        {
            [(NSMutableArray *)[sectionArrays objectAtIndex:item._sectionNum] addObject:item];
        }
    
    
    
        for (NSMutableArray *sectionArray in sectionArrays)
        {
            if (sectionArray.count != 0)
            {
                NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(getFirstName)]; //同
                [_listContent addObject:sortedSection];
            }
        }
        
        ///////////////////////////////////////////////////////////////
        
        [_myTableView reloadData];
    
        if (!isCache)
        {
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:content forKey:@"friendList"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


-(void)refreshData:(UIButton *)button
{
    [self initHttpRequest];
    [self initRecentContactRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"FriendListViewController"];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"FriendListViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ios7_height = 0;
    
//    if (IOS_VERSION>=7.0)
//    {
//        ios7_height = 20;
//    }
//    
    
    searchOrCancell = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.view.backgroundColor = RGBCOLOR(242,242,242);
    
    
    _listContent = [NSMutableArray arrayWithCapacity:1];//_allFriends 是一个NSMutableArray型的成员变量
    
    _RecentContact_array = [[NSMutableArray alloc] init];
    number_array = [[NSMutableArray alloc] init];
    _tempArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    pageCount = 1;
    _uid = @"";
    
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [user objectForKey:@"friendList"];
    
    if (dic.count>0)
    {
        [self exchangeData:dic isCache:YES];
        NSArray * array = [user objectForKey:@"RecentContact"];
        [self exchangeContent:array];
        
    }else
    {
        [self initRecentContactRequest];
        [self initHttpRequest];
    }
    
    
//    //自定义navigation
//    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
//    //创建navbar
//    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,aScreenRect.size.width,44+ios7_height)];
//    //创建navbaritem
//    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:self.title_name_string];
//    nav.barStyle = UIBarStyleBlackOpaque;
//    [nav pushNavigationItem:NavTitle animated:YES];
//    
//    [self.view addSubview:nav];
//    
//    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space.width = MY_MACRO_NAME?-4:5;
//    
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(0,0,12,21.5)];
//    
//    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back.png"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    NavTitle.leftBarButtonItems=@[space,back_item];
//    [nav setItems:[NSArray arrayWithObject:NavTitle]];
//    
//    [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    
//    
//    UIButton *button_refresh=[[UIButton alloc]initWithFrame:CGRectMake(10,8,41/2,39/2)];
//    
//    [button_refresh addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
//    [button_refresh setBackgroundImage:[UIImage imageNamed:@"ios7_refresh4139.png"] forState:UIControlStateNormal];
//    button_refresh.titleLabel.font=[UIFont systemFontOfSize:14];
//    
//    NavTitle.rightBarButtonItems = @[space,[[UIBarButtonItem alloc] initWithCustomView:button_refresh]];
//    
//    
//    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,44)];
//    
//    title_label.text = @"联系人";
//    
//    title_label.backgroundColor = [UIColor clearColor];
//    
//    title_label.textAlignment = NSTextAlignmentCenter;
//    
//    title_label.textColor = [UIColor blackColor];
//    
//    title_label.font = TITLEFONT;
//    
//    NavTitle.titleView = title_label;
    
    
    self.title = self.title_name_string;
    
    self.rightImageName = @"ios7_refresh4139.png";
    
    self.leftImageName = @"logIn_close.png";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    
    
    
    
    search_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,40)];
    search_view.backgroundColor = [UIColor whiteColor];//RGBCOLOR(242,242,242);
    [self.view addSubview:search_view];
    
    
    imgbc=[[UIImageView alloc]initWithFrame:CGRectMake(10,6,DEVICE_WIDTH-20,56/2)];
    
    imgbc.image=[[UIImage imageNamed:@"ios7_newssearchbar.png"] stretchableImageWithLeftCapWidth:50 topCapHeight:7];
    
    [search_view addSubview:imgbc];
    
    
    
    search_tf =[[UITextField alloc]initWithFrame:CGRectMake(30+10,6,210,56/2)];
    search_tf.delegate=self;
    search_tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    search_tf.backgroundColor=[UIColor clearColor];
    search_tf.font=[UIFont systemFontOfSize:12.f];
    search_tf.returnKeyType=UIReturnKeySearch;
    search_tf.userInteractionEnabled = TRUE;
    
    [search_view addSubview:search_tf];
    
    
    cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(DEVICE_WIDTH,6,DEVICE_WIDTH-517/2,61/2)];
    cancelButton.backgroundColor = [UIColor clearColor];
    cancelButton.userInteractionEnabled=YES;
    [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(searchcancell) forControlEvents:UIControlEventTouchUpInside];
    [search_view addSubview:cancelButton];
    
    
    
    if ([self.title_name_string isEqualToString:@"联系人"])
    {
        search_tf.placeholder=@"在联系人中搜索";
    }else
    {
        search_tf.placeholder=@"搜索@某人";
    }
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,40,DEVICE_WIDTH,DEVICE_HEIGHT-64-40) style:UITableViewStylePlain];
    
    if (IOS_VERSION >=6.0)
    {
        self.myTableView.sectionIndexColor = RGBCOLOR(139,147,150);
        
        self.myTableView.sectionIndexTrackingBackgroundColor = [UIColor lightGrayColor];
    }
    
    if (IOS_VERSION >=7.0)
    {
        self.myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
        self.myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = 0;
    _myTableView.rowHeight = 55;
    [self.view addSubview:_myTableView];
    
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.center = CGPointMake(DEVICE_WIDTH/2,DEVICE_HEIGHT/2);
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
}


-(void)leftButtonTap:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)rightButtonTap:(UIButton *)sender
{
    [self refreshData:nil];
}

//-(void)leftButtonTap:(UIButton *)sender
//{
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    [app.pushViewController setNavigationHiddenWith:YES WithBlock:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//
//}



#pragma mark-UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{
        
        nav.frame = CGRectMake(0,-(ios7_height),DEVICE_WIDTH,44+ios7_height);
        search_view.frame = CGRectMake(0,ios7_height,DEVICE_WIDTH,40);
        _myTableView.frame = CGRectMake(0,40+ios7_height,DEVICE_WIDTH,DEVICE_HEIGHT-60);
        
        
        imgbc.frame = CGRectMake(10,6,DEVICE_WIDTH-61,56/2);
        
        cancelButton.frame = CGRectMake(DEVICE_WIDTH-80,6,DEVICE_WIDTH-517/2,61/2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searching];
    return YES;
}




-(void)searchcancell
{
    [search_tf resignFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^
     {
         nav.frame = CGRectMake(0,0,DEVICE_WIDTH,ios7_height);
         
         search_view.frame = CGRectMake(0,ios7_height,DEVICE_WIDTH,40);
         
         _myTableView.frame = CGRectMake(0,40+ios7_height,DEVICE_WIDTH,DEVICE_HEIGHT-64-40);
         
         
         imgbc.frame = CGRectMake(10,6,DEVICE_WIDTH-20,56/2);
         
         cancelButton.frame = CGRectMake(DEVICE_WIDTH,6,DEVICE_WIDTH-517/2,61/2);
         
     } completion:^(BOOL finished)
     {
         
     }];
}



-(void)LogOut
{
    [hud show];
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"没有"];
    [hud setActivity:NO];
    [hud show];
    [hud hideAfter:3];
}



-(void)cancelSearch:(UIButton *)button
{
    searchOrCancell = !searchOrCancell;
    
    [button1 setTitle:searchOrCancell?@"取消":@"搜索" forState:UIControlStateNormal];
    
    if (searchOrCancell)
    {
        [self searching];
    }else
    {
        
        [_dataArray removeAllObjects];
        
        [_myTableView reloadData];
        
        [self dismissSearch];
    }
    
    
}

-(void)backH
{
    if (delegate && [delegate respondsToSelector:@selector(atSomeBodys:)])
    {
        [delegate atSomeBodys:@""];
    }
    [_isloadingIv removeFromSuperview];
    _isloadingIv = nil;
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - scrollViewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40) && scrollView.contentOffset.y > 0)
    //    {
    //        if (![loadview.normalLabel.text isEqualToString:@"没有更多了"])
    //        {
    //            [loadview startLoading];
    //            pageCount++;
    //            [self initHttpRequest];
    //        }
    //    }
}




#pragma mark - Table view data source

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (self.tempArray.count > 0)
//    {
//        return nil;
//    }
//
//    if (self.RecentContact_array.count && section == 0)
//    {
//        return @"最近联系人";
//    }else
//    {
//        if ([[_listContent objectAtIndex:self.RecentContact_array.count?section-1:section] count] > 0)
//        {
//            return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:[[number_array objectAtIndex:self.RecentContact_array.count?section-1:section] intValue]];
//        }
//        return nil;
//    }
//}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,24)];
    label.backgroundColor=RGBCOLOR(235, 235, 235);
    [label setFont:[UIFont systemFontOfSize:14]];
    
    label.textColor=RGBCOLOR(17,17,17);
    
    if (self.tempArray.count > 0)
    {
        
        return label;
    }
    
    if (self.RecentContact_array.count && section == 0)
    {
        label.text=@"  最近联系人";
        NSLog(@"返联系人？");
        return label;
        
        
    }else
    {
        if ([[_listContent objectAtIndex:self.RecentContact_array.count?section-1:section] count] > 0)
        {
            label.text= [NSString stringWithFormat:@"  %@",[[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:[[number_array objectAtIndex:self.RecentContact_array.count?section-1:section] intValue]]];
            NSLog(@"zhege====%@",[[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:[[number_array objectAtIndex:self.RecentContact_array.count?section-1:section] intValue]]);
            return label;
            
        }
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_tempArray.count>0) {
        return 0;
    }else{
        return 24;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.tempArray.count > 0)
    {
        return 0;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 0;
    } else
    {
        if (title == UITableViewIndexSearch)
        {
            [tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
            return -1;
        } else
        {
            int retrn_number = 0;
            for (int i = 0;i < number_array.count;i++)
            {
                int number = [[number_array objectAtIndex:i] intValue];
                
                if (number == [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index-1])
                {
                    retrn_number = self.RecentContact_array.count?i+1:i;
                    break;
                }
            }
            
            return retrn_number;
        }
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if (self.tempArray.count > 0)
    {
        return nil;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    } else
    {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
                [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tempArray.count > 0)
    {
        return 1;
    }
    
    return self.RecentContact_array.count?_listContent.count+1:_listContent.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.tempArray.count > 0)
    {
        return self.tempArray.count;
    }
    
    
    if (self.RecentContact_array.count && section == 0)
    {
        return self.RecentContact_array.count;
    }else
    {
        return [[_listContent objectAtIndex:self.RecentContact_array.count?section-1:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }else
    {
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    
    AsyncImageView * _Head_ImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(10,10,35,35)];
    
    _Head_ImageView.layer.cornerRadius = 5;
    _Head_ImageView.layer.borderColor = (__bridge  CGColorRef)([UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]);
    _Head_ImageView.layer.borderWidth =1.0;
    _Head_ImageView.layer.masksToBounds = YES;
    
    [cell.contentView addSubview:_Head_ImageView];
    
    
    
    UILabel * _name_label = [[UILabel alloc] initWithFrame:CGRectMake(60,10,200,35)];
    
    _name_label.backgroundColor = [UIColor clearColor];
    
    _name_label.textAlignment = NSTextAlignmentLeft;
    
    [cell.contentView addSubview:_name_label];
    
    
    PersonInfo * info = [[PersonInfo alloc] init];
    
    
    if (self.tempArray.count > 0)
    {
        info = [self.tempArray objectAtIndex:indexPath.row];
    }else
    {
        if (self.RecentContact_array.count && indexPath.section == 0)
        {
            info = [self.RecentContact_array objectAtIndex:indexPath.row];
            
        }else
        {
            info = [[_listContent objectAtIndex:self.RecentContact_array.count?indexPath.section-1:indexPath.section] objectAtIndex:indexPath.row];
            
        }
    }
    
    
    _name_label.text = info.username;
    [_Head_ImageView loadImageFromURL:[zsnApi returnUrl:info.uid] withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_isloadingIv removeFromSuperview];
    
    _isloadingIv = nil;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    PersonInfo * info = [[PersonInfo alloc] init];
    
    if (self.tempArray.count > 0)
    {
        info = [self.tempArray objectAtIndex:indexPath.row];
    }else
    {
        if (self.RecentContact_array.count && indexPath.section == 0)
        {
            info = [self.RecentContact_array objectAtIndex:indexPath.row];
            
        }else
        {
            info = [[_listContent objectAtIndex:self.RecentContact_array.count?indexPath.section-1:indexPath.section] objectAtIndex:indexPath.row];
        }
    }
    
    if ([self.title_name_string isEqualToString:@"联系人"]||[self.title_name_string isEqualToString:@"mine"])
    {
        if (delegate && [delegate respondsToSelector:@selector(returnUserName:Uid:)])
        {
            [delegate returnUserName:info.username Uid:info.uid];
        }
    }else
    {
        if (delegate && [delegate respondsToSelector:@selector(atSomeBodys:)])
        {
            [delegate atSomeBodys:info.username];
        }
    }
}


-(void)setDelegate:(id<FriendListViewControllerDelegate>)delegate1
{
    delegate = delegate1;
}

-(void)dismissSearch
{
    [search_tf resignFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^
     {
         nav.frame = CGRectMake(0,0,DEVICE_WIDTH,ios7_height);
         
         search_view.frame = CGRectMake(0,ios7_height,DEVICE_WIDTH,40);
         
         _myTableView.frame = CGRectMake(0,40+ios7_height,DEVICE_WIDTH,DEVICE_HEIGHT-64-40);
         
         imgbc.frame = CGRectMake(10,6,DEVICE_WIDTH-20,56/2);
         
         cancelButton.frame = CGRectMake(DEVICE_WIDTH,6,DEVICE_WIDTH-517/2,61/2);
         
     } completion:^(BOOL finished)
     {
         
     }];
}


-(void)searching
{
    _uid = search_tf.text;
    
    for (PersonInfo * info in self.dataArray)
    {
        if ([info.username rangeOfString:search_tf.text].length)
        {
            [self.tempArray addObject:info];
        }
    }
    
    if (self.tempArray.count>0)
    {
        [self.myTableView reloadData];
        
    }else{
        if (!_isloadingIv)
        {
            _isloadingIv=[[UILabel alloc]initWithFrame:CGRectMake(100, 200, 150/2, 100/2) ];
            // labelString:@"没有找到该联系人"
            _isloadingIv.text=@"没有找到该联系人";
            _isloadingIv.numberOfLines=0;
            _isloadingIv.textAlignment=NSTextAlignmentCenter;
            _isloadingIv.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.8];
            [_isloadingIv setTextColor:[UIColor whiteColor]];
            [_isloadingIv setFont:[UIFont systemFontOfSize:16]];
            _isloadingIv.center=CGPointMake(DEVICE_WIDTH/2, DEVICE_HEIGHT/2);
            
        }
        
        [[UIApplication sharedApplication].keyWindow
         addSubview:_isloadingIv];
        _isloadingIv.hidden=NO;
        [self performSelector:@selector(isloadingimagevdismiss) withObject:nil afterDelay:1.5];
        
        
    }
    
    [self dismissSearch];
}
-(void)isloadingimagevdismiss
{
    [_isloadingIv removeFromSuperview];
    _isloadingIv = nil;
}



@end










