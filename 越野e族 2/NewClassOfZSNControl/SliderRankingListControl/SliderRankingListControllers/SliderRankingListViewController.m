//
//  SliderRankingListViewController.m
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderRankingListViewController.h"
#import "RankingListSegmentView.h"
#import "RankingListModel.h"
#import "bbsdetailViewController.h"
#import "BBSfenduiViewController.h"
#import "SliderForumCollectionModel.h"

@interface SliderRankingListViewController ()
{
    RankingListSegmentView * ranking_segment;
    
    RankingListModel * myModel;
}

@end

@implementation SliderRankingListViewController
@synthesize myTableView = _myTableView;
@synthesize data_array = _data_array;
@synthesize currentPage = _currentPage;
@synthesize bbs_forum_collection_array = _bbs_forum_collection_array;
@synthesize bbs_post_collection_array = _bbs_post_collection_array;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?@"sliderBBSNavigationBarImage":@"sliderBBSNavigationBarImage_ios6"] forBarMetrics: UIBarMetricsDefault];
    }
    

    [self.myTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    self.title = @"排行榜";
    
    
    _data_array = [NSMutableArray arrayWithObjects:[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],nil];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.separatorColor = RGBCOLOR(223,223,223);
    
    if (MY_MACRO_NAME) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:_myTableView];
    
    __weak typeof(self) bself = self;
    
    _currentPage = 1;
    
    ranking_segment = [[RankingListSegmentView alloc] initWithFrame:CGRectMake(0,0,320,56.5) WithBlock:^(int index) {
        
        bself.currentPage = index + 1;
        
        [bself.myTableView reloadData];
        
        if ([[bself.data_array objectAtIndex:index] count] == 0)
        {
            [bself loadRankingListDataWithIndex:index+1];
        }
    }];
    
    _myTableView.tableHeaderView = ranking_segment;
    
    
    [self loadRankingListDataWithIndex:_currentPage];
    
    [self loadAllBBSPostData];
    
}

-(void)leftButtonTap:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 请求排行榜数据

-(void)loadRankingListDataWithIndex:(int)index
{
    if (!myModel)
    {
        myModel = [[RankingListModel alloc] init];
    }
    
    __weak typeof(self) bself = self;
    
    [myModel loadRankingListDataWithType:index WithComplicationBlock:^(NSMutableArray *array)
    {
        [bself.data_array replaceObjectAtIndex:index-1 withObject:array];
        
        [bself.myTableView reloadData];
        
    } WithFailedBlock:^(NSString *errinfo) {
        
    }];
}


#pragma mark - 请求收藏的所有的帖子


-(void)loadAllBBSPostData
{
    
    
//    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
//    
//    
//    if (!isLogin) {
//        LogInViewController * logIn = [LogInViewController sharedManager];
//        
//        [self presentViewController:logIn animated:YES completion:NULL];
//        
//        return;
//    }
    

    
    
    
    if (!_bbs_post_collection_array) {
        _bbs_post_collection_array = [NSMutableArray array];
    }else
    {
        [_bbs_post_collection_array removeAllObjects];
    }
    
    NSString * fullUrl = [NSString stringWithFormat:GET_COLLECTION_BBS_POST_URL,AUTHKEY];
    
    NSLog(@"获取收藏帖子接口 --   %@",fullUrl);
    
    ASIHTTPRequest * bbs_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    
    __block typeof(bbs_request) request = bbs_request;
    
    __weak typeof(self) bself = self;
    
    [request setCompletionBlock:^{
       
        @try
        {
            NSDictionary * allDic = [bbs_request.responseString objectFromJSONString];
            
            if ([[allDic objectForKey:@"errcode"] intValue] == 0)
            {
                NSArray * array = [allDic objectForKey:@"bbsinfo"];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                    
                    for (NSDictionary * dic in array)
                    {
                        [bself.bbs_post_collection_array addObject:[dic objectForKey:@"tid"]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (bself.currentPage == 1)
                        {
                            [bself.myTableView reloadData];
                        }
                    });
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        
    }];
    
    [bbs_request startAsynchronous];
}




#pragma mark - UITableViewDelegate


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}



#pragma  mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data_array objectAtIndex:_currentPage-1] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    RankingListCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[RankingListCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RankingListModel * model = [[_data_array objectAtIndex:_currentPage-1] objectAtIndex:indexPath.row];
    
    [cell setInfoWith:indexPath.row + 1 WithModel:model WithType:self.currentPage];
    
    NSLog(@"---=--=-----  %@",self.bbs_forum_collection_array);
    
    cell.collection_button.selected = [self.currentPage==1?self.bbs_post_collection_array:self.bbs_forum_collection_array containsObject:model.ranking_id];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentPage-1 == 0)
    {
        RankingListModel * model = [[_data_array objectAtIndex:_currentPage-1] objectAtIndex:indexPath.row];
        
        bbsdetailViewController * detail = [[bbsdetailViewController alloc] init];
        
        detail.bbsdetail_tid = model.ranking_id;
        
        detail.collection_array = self.bbs_post_collection_array;
        
        [self.navigationController pushViewController:detail animated:YES];
    }else
    {
        
        if ([[_data_array objectAtIndex:_currentPage-1] count] > 0)
        {
            RankingListModel * model = [[_data_array objectAtIndex:_currentPage-1] objectAtIndex:indexPath.row];
            
            BBSfenduiViewController * detail = [[BBSfenduiViewController alloc] init];
            
            detail.string_id = model.ranking_id;
            
            detail.string_name = model.ranking_title;
            
            detail.collection_array = self.bbs_forum_collection_array;
            
            [self.navigationController pushViewController:detail animated:YES];
            
        }
    }
}



#pragma mark - RankingListCellDelegate

#pragma mark - 收藏或取消收藏

-(void)cancelOrCollectSectionsWith:(RankingListCustomCell *)cell
{
    
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    
    if (!isLogin) {
        LogInViewController * logIn = [LogInViewController sharedManager];
        
        [self presentViewController:logIn animated:YES completion:NULL];
        
        return;
    }
    

    
    NSIndexPath * indexPath = [_myTableView indexPathForCell:cell];
    
    RankingListModel * model = [[_data_array objectAtIndex:_currentPage-1] objectAtIndex:indexPath.row];
    
    NSString * fullUrl = @"";
    
    BOOL isCollected;
    
    if (self.currentPage == 1)
    {
        isCollected = [self.bbs_post_collection_array containsObject:model.ranking_id];
                
        if (!isCollected)
        {
            fullUrl = [NSString stringWithFormat:COLLECTION_BBS_POST_URL,AUTHKEY,model.ranking_id];
        }else
        {
            fullUrl = [NSString stringWithFormat:DELETE_COLLECTION_BBS_POST_URL,model.ranking_id,AUTHKEY];
        }
        
    }else
    {
        isCollected = [self.bbs_forum_collection_array containsObject:model.ranking_id];
        
        if (!isCollected)
        {
            fullUrl = [NSString stringWithFormat:COLLECTION_FORUM_SECTION_URL_OLD,model.ranking_id,AUTHKEY];
        }else
        {
            fullUrl = [NSString stringWithFormat:COLLECTION_CANCEL_FORUM_SECTION_URL_OLD,model.ranking_id,AUTHKEY];
        }
    }
    
    NSLog(@"收藏取消收藏 ---  %@",fullUrl);
    
    
    NSURL * url = [NSURL URLWithString:fullUrl];
    
    
    ASIHTTPRequest * collect_request = [[ASIHTTPRequest alloc] initWithURL:url];
    
    __block typeof(collect_request) request = collect_request;
    
    __weak typeof(self) bself = self;
    
    [request setCompletionBlock:^{
        
        cell.collection_button.selected = !isCollected;
        
        if (isCollected)//取消收藏
        {
            if (bself.currentPage == 1)
            {
                if ([bself.bbs_post_collection_array containsObject:model.ranking_id])
                {
                    [bself.bbs_post_collection_array removeObject:model.ranking_id];
                }
            }else
            {
//                if ([bself.bbs_forum_collection_array containsObject:model.ranking_id])
//                {
//                    [bself.bbs_forum_collection_array removeObject:model.ranking_id];
//                }
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"forumSectionChange" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:model.ranking_id,@"forumSectionId",nil]];
            }
            
        }else//收藏
        {
            if (bself.currentPage == 1)
            {
                if (![bself.bbs_post_collection_array containsObject:model.ranking_id])
                {
                    [bself.bbs_post_collection_array addObject:model.ranking_id];
                }
            }else
            {
//                if (![bself.bbs_forum_collection_array containsObject:model.ranking_id])
//                {
//                    [bself.bbs_forum_collection_array addObject:model.ranking_id];
//                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"forumSectionChange" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:model.ranking_id,@"forumSectionId",nil]];
            }
            
        }
    }];
    
    [request setFailedBlock:^{
        
    }];
    
    [collect_request startAsynchronous];
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
