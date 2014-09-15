//
//  SliderRightSettingViewController.m
//  越野e族
//
//  Created by soulnear on 14-7-8.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderRightSettingViewController.h"
#import "UMUFPTableView.h"
#import "SDImageCache.h"
#import "FullyLoaded.h"
#import "UMFeedbackViewController.h"
#import "AboutViewController.h"
#import "UMTableViewController.h"

@interface SliderRightSettingViewController ()
{
    UMUFPTableView * _mTableView;
    
    NSArray * arrayofjingpinyingyong;
    
    UIButton * logOut_button;//退出/登陆按钮
}

@end

@implementation SliderRightSettingViewController
@synthesize myTableView = _myTableView;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    self.title = @"设置";
    
    title_array = [NSArray arrayWithObjects:@"",@"清除缓存",@"意见反馈",@"版本更新",@"关于",@"",@"精品应用",@"",@"",nil];
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-20 - 44) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    
    self.myTableView.separatorColor = RGBCOLOR(230,230,230);
    
    self.myTableView.dataSource = self;
    
    self.myTableView.backgroundColor = RGBCOLOR(248,248,248);
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myTableView.showsHorizontalScrollIndicator = NO;
    
    self.myTableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.myTableView];
    
    
    
    _mTableView = [[UMUFPTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain appkey:@"5153e5e456240b79e20006b9" slotId:nil currentViewController:self];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
    
    [_mTableView requestPromoterDataInBackground];
    
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(successLogIn) name:@"LogIn" object:nil];//登陆成功通知
    
}

-(void)leftButtonTap:(UIButton *)sender
{
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [app.pushViewController setNavigationHiddenWith:YES WithBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 登陆成功

-(void)successLogIn
{
    [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:8 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark--取精品应用数据回调


- (void)loadDataFailed {
    
    NSLog(@"获取精品应用数据失败");
    
}

//该方法在成功获取广告数据后被调用
- (void)UMUFPTableViewDidLoadDataFinish:(UMUFPTableView *)tableview promoters:(NSArray *)promoters {
    
    arrayofjingpinyingyong=[NSArray arrayWithArray:promoters];
    
    if ([promoters count] > 0)
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:7 inSection:0];
        [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}



#pragma mark - UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return title_array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 5) {
        return 23;
    }else if(indexPath.row == 8)
    {
        return 90;
    }else if (indexPath.row == 7)
    {
        return 233/2;
    }else
    {
        return 54;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [title_array objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0.5)];
    
    lineView.backgroundColor = RGBCOLOR(231,231,231);
    
    [cell.contentView addSubview:lineView];
    
    if (indexPath.row == 0 || indexPath.row == 5)
    {
//        cell.separatorInset = UIEdgeInsetsZero;
        
        lineView.center = CGPointMake(160,0.25);
        
        cell.backgroundColor = RGBCOLOR(248,248,248);
    }else if (indexPath.row == 6)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        lineView.center = CGPointMake(160,0.25);
    }else if (indexPath.row == 7)
    {
        for (int i=0; i<4; i++) {
            
            if (arrayofjingpinyingyong.count > i) {
                NSDictionary *dicjingpininfo=[arrayofjingpinyingyong objectAtIndex:i];
                
                UIButton *suggest_button=[[UIButton alloc]initWithFrame:CGRectMake(11.25+80*i,18, 115/2, 115/2)];
                suggest_button.tag=99+i;
                suggest_button.backgroundColor=[UIColor clearColor];
                [suggest_button addTarget:self action:@selector(domysuggestbutton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:suggest_button];
                
                AsyncImageView *imgbuttonbg=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 115/2, 115/2)];
                
                [ imgbuttonbg loadImageFromURL:[NSString stringWithFormat:@"%@",[dicjingpininfo objectForKey:@"icon"]] withPlaceholdImage:nil];
                
                [suggest_button addSubview:imgbuttonbg];
                
                
                UILabel *labelofname=[[UILabel alloc]initWithFrame:CGRectMake(8+80*i, 18+115/2+3, 67, 20)];
                labelofname.text=[NSString stringWithFormat:@"%@",[dicjingpininfo objectForKey:@"title"]];
                labelofname.font=[UIFont systemFontOfSize:12];
                labelofname.backgroundColor = [UIColor clearColor];
                labelofname.textAlignment=NSTextAlignmentCenter;
                [cell.contentView addSubview:labelofname];
            }
        }
        
        
        lineView.center = CGPointMake(174,0.25);
        
    }else if (indexPath.row == 8)
    {
        cell.backgroundColor = RGBCOLOR(248,248,248);
        
        lineView.center = CGPointMake(160,0.25);
        
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        
        
        NSLog(@"dadajsdlajdaksj 0--------%d",isLogIn);
        
        
        logOut_button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        logOut_button.frame = CGRectMake(14,23,584/2,85/2);
        
        [logOut_button setTitle:isLogIn?@"退出登录":@"立即登录" forState:UIControlStateNormal];
        
        [logOut_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        logOut_button.backgroundColor = RGBCOLOR(120,121,123);
        
        [logOut_button addTarget:self action:@selector(logOutTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:logOut_button];
        
        
    }else if (indexPath.row == 1)
    {
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/data"];
        
        lineView.center = CGPointMake(160,0.25);
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(208,0,100,54)];
        
        label.textAlignment = NSTextAlignmentRight;
        
        label.backgroundColor = [UIColor clearColor];
        
        label.text = [zsnApi fileSizeAtPath:path];
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.textColor = RGBCOLOR(194,194,194);
        
        [cell.contentView addSubview:label];
        
        
    }else if (indexPath.row == 2)
    {
        lineView.center = CGPointMake(174,0.25);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 3)
    {
        lineView.center = CGPointMake(174,0.25);
    }else if (indexPath.row == 4)
    {
        lineView.center = CGPointMake(174,0.25);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)//清除缓存
    {
        [self removeCache];
    }else if (indexPath.row == 2)//意见反馈
    {
        UMFeedbackViewController *feedb=[[UMFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedb animated:YES];
    }else if (indexPath.row == 3)//版本更新
    {
        [self checkVersionUpdate];
    }else if (indexPath.row == 4)//关于
    {
        AboutViewController * aboutVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else if (indexPath.row == 6)//精品应用
    {
        UMTableViewController *controller = [[UMTableViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}



-(void)domysuggestbutton:(UIButton *)sender{
    
    NSLog(@"点击的是第%d个Button",sender.tag-99);
    int index=sender.tag-99;
    NSDictionary *promoter = [_mTableView.mPromoterDatas objectAtIndex:index];
    
    [_mTableView didClickPromoterAtIndex:promoter index:index];
    
}


-(void)logOutTap:(UIButton *)sender
{
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (isLogIn)
    {
        [logOut_button setTitle:@"立即登录" forState:UIControlStateNormal];
        
        [self deletetoken];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clearolddata" object:nil];
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"" forKey:USER_NAME] ;
        [user setObject:@"" forKey:USER_PW] ;
        [user setObject:@"" forKey:USER_AUTHOD] ;
        [user setObject:@"" forKey:USER_UID] ;
        [user setObject:@"" forKey:USER_FACE];
        
        [user setBool:NO forKey:USER_IN];
        
        [user removeObjectForKey:@"friendList"];
        [user removeObjectForKey:@"RecentContact"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clean" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTheTimer" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutToChangeHeader" object:nil];
        
        [user synchronize];
        
        
        [FbFeed deleteAllByType:0];
        [FbFeed deleteAllByType:2];
        
    }else
    {
        LogInViewController * logIn = [LogInViewController sharedManager];
        
        logIn.delegate = self;
        
        [self presentViewController:logIn animated:YES completion:^{
            
        }];
    }
}


#pragma mark - 登录代理


-(void)successToLogIn
{
    [logOut_button setTitle:@"退出登录" forState:UIControlStateNormal];
}

-(void)failToLogIn
{
    
}


#pragma mark-退出登录，消除devicetoken

-(void)deletetoken{
    /*http://bbs2.fblife.com/localapi/user_app_token.php?action=deltoken&authcode=sdfasfdsafdasdf&token=ssdfasdfaddfgdsgf2a&token_key=01b1f00235ae1d46432ba45771beb2d1&datatype=json*/
    
    
    NSString *stringdevicetoken=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]];
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:@"http://bbs2.fblife.com/localapi/user_app_token.php?action=deltoken&authcode=%@&token=%@&token_key=01b1f00235ae1d46432ba45771beb2d1&datatype=json",authkey,stringdevicetoken];
    NSLog(@"删除的urlurl = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"删除消息 -=-=  %@",dic);
            
            if ([[dic objectForKey:@"errcode"] intValue] ==0)
            {
                
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


#pragma mark - 清除缓存

-(void)removeCache
{
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[FullyLoaded sharedFullyLoaded] removeAllCacheDownloads];
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSArray *arra=[NSArray arrayWithObject:reloadIndexPath];
    [ _myTableView reloadRowsAtIndexPaths:arra withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    
    //弹出提示信息
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"缓存清除成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - 检查版本更新

-(void)checkVersionUpdate
{
    NSURL * fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/version.php?appversion=%@",NOW_VERSION]];
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:fullUrl];
    
    __block ASIHTTPRequest * _request = request;
    
    
    request.delegate = self;
    
    [_request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            NSString * bbsInfo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsinfo"]];
            NSLog(@"dic===%@",dic);
            if (![bbsInfo isEqualToString:NOW_VERSION])
            {
                NSString * new = [NSString stringWithFormat:@"我们的%@版本已经上线了,赶快去更新吧!",bbsInfo];
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:new delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:@"稍后提示",nil];
                
                alert.delegate = self;
                
                alert.tag = 10000;
                
                [alert show];
                
                
            }else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"版本更新检查" message:@"您目前使用的是最新版本" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    
    [_request setFailedBlock:^{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测失败,请检查您当前网络是否正常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
    }];
    
    [request startAsynchronous];
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
