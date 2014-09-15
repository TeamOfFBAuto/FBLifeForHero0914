//
//  newsTableview.m
//  越野e族
//
//  Created by 史忠坤 on 13-12-25.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "newsTableview.h"
#import "newsimage_scro.h"
#import "newscellview.h"
#import "recommend.h"
#import "personal.h"
#import "loadingview.h"
#import "newsdetailViewController.h"
#import "testbase.h"
#import "LeveyTabBarController.h"
#import "NewWeiBoDetailViewController.h"
#import "ImagesViewController.h"
#import "WenJiViewController.h"
#import "fbWebViewController.h"
@implementation newsTableview{
    newsimage_scro *imagesc;
    newsimage_scro *sec2;
    UIScrollView *twoscro;
    newscellview *  orcell;

    
}
@synthesize delegate,activityIndicator=_activityIndicator,tab=tab_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<1000; i++) {
            select[i]=0;
        }
        
        tab_=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height) style:UITableViewStylePlain];
        [self addSubview:tab_];
        
        tab_.delegate=self;
        tab_.dataSource=self;
        tab_.userInteractionEnabled=YES;
        tab_.backgroundColor=[UIColor whiteColor];
        tab_.separatorColor=[UIColor clearColor];
        
        self.commentarray=[[NSMutableArray alloc]init];
        self.normalarray=[[NSMutableArray alloc]init];
        
        
        if (_refreshHeaderView == nil)
        {
            EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-tab_.bounds.size.height, 320, tab_.bounds.size.height)];
            view.delegate = self;
            _refreshHeaderView = view;
        }
        [_refreshHeaderView refreshLastUpdatedDate];
        [tab_ addSubview:_refreshHeaderView];
        
        nomore=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        nomore.text=@"没有更多数据";
        nomore.textAlignment=NSTextAlignmentCenter;
        nomore.font=[UIFont systemFontOfSize:13];
        nomore.textColor=[UIColor lightGrayColor];
        
        loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, 320, 40)];
        loadview.backgroundColor=[UIColor clearColor];
        
        numberofpage=1;
        isloadsuccess=YES;
        
        com_id_array=[NSMutableArray array];
        com_link_array=[NSMutableArray array];
        com_type_array=[NSMutableArray array];
        com_title_array=[NSMutableArray array];
        
        UIView *placeview=[[UIView alloc]initWithFrame:tab_.frame];
        placeview.tag=234;
     //   placeview.backgroundColor=RGBCOLOR(222, 222, 222);
        UIImageView *imgcenterlogo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_newsbeijing.png"]];
        imgcenterlogo.center=CGPointMake(tab_.frame.size.width/2, tab_.frame.size.height/2-20);
        [placeview addSubview:imgcenterlogo];
        placeview.hidden=NO;
        
        
        [tab_ addSubview:placeview];
        
        _activityIndicator = [[UIActivityIndicatorView alloc]
                                                          initWithActivityIndicatorStyle:
                                                          UIActivityIndicatorViewStyleGray];
        _activityIndicator.center =CGPointMake(tab_.frame.size.width/2-80,tab_.frame.size.height/2-20);
        _activityIndicator.hidden =NO;
        [_activityIndicator startAnimating];
        _activityIndicator.hidden=NO;
        _activityIndicator.tag=222;
//        [self addSubview:_activityIndicator];
//
    }
    return self;
}

-(void)layoutSubviews{
    
}

-(void)newstabreceivecommentdic:(NSDictionary *)_newsCommentDic normaldic:(NSDictionary *)_newsNormalDic{
    
    
    //这是刷新取数据
    [[self viewWithTag:234] removeFromSuperview];
    [self viewWithTag:222].hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        [tab_ setContentOffset:CGPointMake(0, 0)];
        
        //动画内容
        
    }completion:^(BOOL finished)
     
     {

         
     }];
    

    
    
    [self.normalarray removeAllObjects];
    [self.commentarray removeAllObjects];
    
    
  //  NSLog(@",,..com.%@\nnor%@",_newsCommentDic,_newsNormalDic);
    
    @try {
        NSArray *arraynomal=[_newsNormalDic objectForKey:@"news"];
        NSArray *arraycomment=[_newsCommentDic objectForKey:@"news"];
        for (int i=0; i<[arraynomal count]; i++) {
            
            NSDictionary *dic=[arraynomal objectAtIndex:i];
            [self.normalarray addObject:dic];
            tab_.tableFooterView=loadview;

        }
        
        for (int i=0; i<[arraycomment count]; i++) {
            
            NSDictionary *dic=[arraycomment objectAtIndex:i];
            [self.commentarray addObject:dic];
            
        }
        
        
        
        [tab_ reloadData];

   
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
        
    }
}


-(void)newstabreceivemorenormaldic:(NSDictionary *)_newsNormalDic{
    
    
    
    if ([[_newsNormalDic objectForKey:@"errno"]integerValue ]==0) {
        @try {
            
            
            NSArray *arraynomal=[_newsNormalDic objectForKey:@"news"];
            for (int i=0; i<[arraynomal count]; i++) {
                NSDictionary *dic=[arraynomal objectAtIndex:i];
                [self.normalarray addObject:dic];
                
            }
            
        }
        @catch (NSException *exception) {
            
            tab_.tableFooterView=nomore;
            
            
        }
        @finally {
            [loadview stopLoading:1];
            
            isloadsuccess=YES;
            [tab_ reloadData];
        }

        
    }else{
        tab_.tableFooterView=nomore;

    }
    
 
    

    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentarray.count>0? [self.normalarray count]+1:0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idtentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idtentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idtentifier];
    }
    
    for (UIView *aview in cell.contentView.subviews) {
        [aview removeFromSuperview];
    }
    if (indexPath.row==0) {
        if (self.commentarray.count>0) {
            NSMutableArray *imgarray=[NSMutableArray array];
            
            for ( int i=0; i<[self.commentarray count]; i++) {
                
                NSDictionary *dic_ofcomment=[self.commentarray objectAtIndex:i];
                NSString *strimg=[dic_ofcomment objectForKey:@"photo"];
                [imgarray addObject:strimg];
                
                
                NSString *str_rec_title=[dic_ofcomment objectForKey:@"title"];
                [com_title_array addObject:str_rec_title];
                /*           id = 82920;
                 link = "http://drive.fblife.com/html/20131226/82920.html";
                 photo = "http://cmsweb.fblife.com/attachments/20131226/1388027183.jpg";
                 title = "\U57ce\U5e02\U8de8\U754c\U5148\U950b \U6807\U81f42008\U8bd5\U9a7e\U4f53\U9a8c";
                 type = 1;*/
                
                NSString *str_link=[dic_ofcomment objectForKey:@"link"];
                [com_link_array addObject:str_link];
                NSString *str_type=[dic_ofcomment objectForKey:@"type"];
                [com_type_array addObject:str_type];
                NSString *str__id=[dic_ofcomment objectForKey:@"id"];
                [com_id_array addObject:str__id];
                
                
            }
             int length = 5;
            NSMutableArray *tempArray = [NSMutableArray array];
            for (int i = 0 ; i < length; i++)
            {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[com_title_array objectAtIndex:i]],@"title" ,[NSString stringWithFormat:@"%@",[imgarray objectAtIndex:i]],@"image",[NSString stringWithFormat:@"%@",[com_link_array objectAtIndex:i]],@"link",[NSString stringWithFormat:@"%@",[com_type_array objectAtIndex:i]],@"type",[NSString stringWithFormat:@"%@",[com_id_array objectAtIndex:i]],@"idoftype",nil];
                [tempArray addObject:dict];
            }
            
            NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
            if (length > 1)
            {
                NSDictionary *dict = [tempArray objectAtIndex:length-1];
                SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1] ;
                [itemArray addObject:item];
            }
            for (int i = 0; i < length; i++)
            {
                NSDictionary *dict = [tempArray objectAtIndex:i];
                SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i] ;
                [itemArray addObject:item];
                
            }
            //添加第一张图 用于循环
            if (length >1)
            {
                NSDictionary *dict = [tempArray objectAtIndex:0];
                SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:length];
                [itemArray addObject:item];
            }
            SGFocusImageFrame *bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, 320, 163) delegate:self imageItems:itemArray isAuto:NO];
            [bannerView scrollToIndex:0];
            [cell.contentView addSubview:bannerView];
            

            
        }


   
        
    }else{
        
        orcell=[[newscellview alloc]initWithFrame:CGRectMake(0, 0, 320, 87)];
        [orcell setImv_string:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"photo"]];
        [orcell setTitle_string:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"stitle"]];

        [orcell setDate_string:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"publishtime"]];

        [orcell setDiscribe_string:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"summary"]];
        //判断有木有的
        
        NSMutableArray *array_select=[NSMutableArray array];
        array_select=  [newslooked findbytheid:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"id"]];
        
        [orcell setGrayorblack:array_select.count];
        
        UIView *selectback=[[UIView alloc]initWithFrame:cell.frame];
        selectback.backgroundColor=RGBCOLOR(242, 242, 242);
        cell.selectedBackgroundView=selectback;
        cell.backgroundColor=[UIColor whiteColor];

        [cell.contentView addSubview:orcell];

    }
    
    return cell;
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (indexPath.row==0)
    {
        height=163;
    }else
    {
        height=77+10;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //select[indexPath.row]=1;
    

    
    
        
     newsdetailViewController *   comment_=[[newsdetailViewController alloc]init];
        
    UIViewController *copyRoot=(UIViewController *)self.delegate;

        NSLog(@"222");
        comment_.string_Id=(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"id"];
        // [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
    
    NSMutableArray *array_select=[NSMutableArray array];
    array_select= [newslooked findbytheid:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"id"]];
    
    
    
    NSLog(@"=sa====%@",array_select);
    
    
    
    if (array_select.count==0) {
        
        
        
        int resault=     [newslooked addid:(NSString *)[[self.normalarray objectAtIndex:indexPath.row-1] objectForKey:@"id"]];
        
        NSLog(@"resault===%d",resault);
        
        
        
        
    }

        
        [copyRoot.leveyTabBarController hidesTabBar:YES animated:YES];
        [copyRoot.navigationController pushViewController:comment_ animated:YES];//跳入下一个View
    
    NSIndexPath  *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    NSArray      *indexArray=[NSArray  arrayWithObject:indexPath_1];
    [tab_  reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    
        //[self setHidesBottomBarWhenPushed:NO] ;

    
}
#pragma mark EGORefreshTableHeaderDelegate Methods

-(void)refreshwithrag:(int)tag{
    
    
    numberofpage=1;
    [self.delegate refreshmydatawithtag:tag];
}
#pragma mark-下拉刷新的代理
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tab_];
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    
    [com_id_array removeAllObjects];
    [com_link_array removeAllObjects];
    [com_title_array removeAllObjects];
    [com_type_array removeAllObjects];

	
//	[self refreshwithrag:self.tag];
    [self.delegate refreshmydatawithtag:self.tag];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //要判断当前是哪一个，有tab_/imagesc/twoscrow/sec2
    if (scrollView==tab_) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        if(tab_.contentOffset.y > (tab_.contentSize.height - tab_.frame.size.height+40)&&isloadsuccess==YES) {
            
            
            [loadview startLoading];
            numberofpage++;
            isloadsuccess=!isloadsuccess;
            [self.delegate loadmorewithtage:self.tag page:numberofpage];
            
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
#pragma mark-SGFocusImageItem的代理
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);
    
    UIViewController *copyRoot=(UIViewController *)self.delegate;
    
    if (com_id_array.count>0) {
        
        int type;
        NSString *string_link_;
        @try {
            type=[item.type intValue];
            
            string_link_=item.link;
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
            return;
            
        }@finally {
            switch (type) {
                case 1:
                {
                    
                    
                    
                    NSLog(@"到新闻的");
                    newsdetailViewController *  comment_=[[newsdetailViewController alloc]init];
                  
                    comment_.string_Id=item.idoftype;
                        [copyRoot.leveyTabBarController hidesTabBar:YES animated:YES];
                        [copyRoot.navigationController pushViewController:comment_ animated:YES];//跳入下一个View
                        
 
                }
                    break;
                    
                case 2:{
                    NSLog(@"到论坛的");
                        bbsdetailViewController *_bbsdetail=[[bbsdetailViewController alloc]init];
                        _bbsdetail.bbsdetail_tid=item.idoftype;
                        [copyRoot.navigationController pushViewController:_bbsdetail animated:YES];
                    
                    
                }
                    break;
                case 3:{
                    
                    NSLog(@"到新闻的");
                        copyRoot.navigationController.navigationBarHidden=NO;
                        NSLog(@"第三种情况link=%@",string_link_);
                        fbWebViewController *_web=[[fbWebViewController alloc]init];
                        _web.urlstring=item.link;
                        [copyRoot.navigationController pushViewController:_web animated:YES];
                    
                }
                    
                default:
                    break;
            }
            
            
        }
        
        
        
    }

}
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
