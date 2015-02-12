//
//  PicShowViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-16.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "PicShowViewController.h"

#import "PicShowTableViewCell.h"

#import "SzkLoadData.h"

#import "UIViewController+MMDrawerController.h"

#import "ShowImagesViewController.h"

#import "NewMainViewModel.h"


@interface PicShowViewController ()

@end

@implementation PicShowViewController

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
    
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:self.isMain];
    numberofpage=1;
    isloadsuccess=YES;
    normalinfoAllArray=[NSMutableArray array];
    [self prepairNavigationBar];
    [self loadNomalData];
    
}



#pragma mark-准备uinavigationbar

-(void)prepairNavigationBar{
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:self.isMain? CGRectMake(MY_MACRO_NAME? -2:5, (44-33/2)/2, 36/2, 33/2):CGRectMake(MY_MACRO_NAME? -5:5, (44-43/2)/2, 12, 43/2)];
    
    [button_back addTarget:self action:@selector(doback) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:self.isMain? [UIImage imageNamed:@"homenewz36_33.png"]:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(doback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
    
    
    //[UIImage imageNamed:@"fblifelogo102_38_.png"];
    
    self.navigationItem.title = @"图集";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    

    
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?37: 25, (44-34/2)/2, 37/2, 34/2)];
    
    
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    if (self.isMain) {
        button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
        [button_comment addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [button_comment setBackgroundImage:[UIImage imageNamed:@"menewz37_36.png"] forState:UIControlStateNormal];
        
        UIButton *  rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        [rightView addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:button_comment];
        rightView.backgroundColor=[UIColor clearColor];
        
        
        
        
        UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
        
        self.navigationItem.rightBarButtonItem=comment_item;
        
    }
  
    
}

-(void)rightDrawerButtonPress{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
}

-(void)loadView{
    [super loadView];
    
    nomore=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH, 30)];
    nomore.text=@"没有更多数据";
    nomore.textAlignment=NSTextAlignmentCenter;
    nomore.font=[UIFont systemFontOfSize:13];
    nomore.textColor=[UIColor lightGrayColor];
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    loadview.backgroundColor=[UIColor clearColor];

    
    mainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    mainTabView.delegate=self;
    mainTabView.dataSource=self;
    mainTabView.backgroundColor=[UIColor whiteColor];
    mainTabView.separatorColor=[UIColor clearColor];
    [self.view addSubview:mainTabView];
    
    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-mainTabView.bounds.size.height, DEVICE_WIDTH, mainTabView.bounds.size.height)];
        view.delegate = self;
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    [mainTabView addSubview:_refreshHeaderView];
    
    
    
}

#pragma mark-准备下面的数据

-(void)loadNomalData{
    
    
    
    
    __weak typeof(self) wself =self;
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *str_search=[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=getappindex&page=%d&type=json&pagesize=10&datatype=2",numberofpage];
    
    [loaddata SeturlStr:str_search mytest:^(NSDictionary *dicinfo, int errcode) {
        
        NSLog(@"新版普通的数据dicinfo===%@",dicinfo);
        
        if (errcode==0) {
            
            [wself refreshNormalWithDic:dicinfo];
            
            
        }else{
            //网络有问题
            
        }
        
    }];
    
    NSLog(@"新版普通的的接口是这个。。=%@",str_search);
    
    
}

-(void)refreshNormalWithDic:(NSDictionary *)dicc{
    
    
    isloadsuccess=YES;
    if (numberofpage==1) {
        [normalinfoAllArray removeAllObjects];
    }
    
    NSArray *arraycomment=[dicc objectForKey:@"app"];
    
    for (int i=0; i<[arraycomment count]; i++) {
        
        NSDictionary *dic=[arraycomment objectAtIndex:i];
        [normalinfoAllArray addObject:dic];
        
        if (arraycomment.count<10) {
            mainTabView.tableFooterView=nomore;

        }else{
            mainTabView.tableFooterView=loadview;

        
        }
        
    }

    
    
    [mainTabView reloadData];
    
    
    
}





-(void)doback{

    if (self.isMain) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
    
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    [XTSideMenuManager resetSideMenuRecognizerEnable:YES];

    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //    self.navigationController.navigationBarHidden=YES;
    
}


#pragma mark-uitableviewdelegate datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return normalinfoAllArray.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    /**
     * 1.幻灯，2,推的文章。3图集。4不清楚啊
     */
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *stringidentifier=@"cell";
    
    PicShowTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringidentifier];
    
    if (!cell) {
        cell=[[PicShowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringidentifier];
    }
    
    NSDictionary *dic=[normalinfoAllArray objectAtIndex:indexPath.row];
    
    [cell picCellSetDic:dic];
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic=[normalinfoAllArray objectAtIndex:indexPath.row];
    
    NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
    
    [_newmodel NewMainViewModelSetdic:dic];
    
    ShowImagesViewController * showImage = [[ShowImagesViewController alloc] init];
    
    showImage.id_atlas = _newmodel.tid;
    
    [self.navigationController pushViewController:showImage animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return IMAGE_HEIGHT + 77;
    
}





#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mainTabView];
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    
   
    
	
    //	[self refreshwithrag:self.tag];
//    [self.delegate refreshmydatawithtag:self.tag];
    [self loadNomalData];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //要判断当前是哪一个，有mainTabView/imagesc/twoscrow/sec2
    if (scrollView==mainTabView) {
        
//        if (scrollView.contentOffset.y==-64) {
//            scrollView.contentOffset=CGPointMake(0, 0);
//        }
//        
        
        
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        if(mainTabView.contentOffset.y > (mainTabView.contentSize.height - mainTabView.frame.size.height+40)&&isloadsuccess==YES&&normalinfoAllArray.count>=10) {
            
            
            [loadview startLoading];
            numberofpage++;
            isloadsuccess=!isloadsuccess;
            [self loadNomalData];
        }
        
        
        if (scrollView.contentOffset.x<-40)
        {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
        }else if(scrollView.contentOffset.x>40)
        {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
        
    }
    
  
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return ccif data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
	return [NSDate date]; // should return date data source was last changed
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
