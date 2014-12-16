//
//  newsTableview.m
//  越野e族
//
//  Created by 史忠坤 on 13-12-25.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "FinalshoucangView.h"
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
#import "ShowImagesViewController.h"

#import "NewshoucangTableViewCell.h"

#import "SzkLoadData.h"

@implementation FinalshoucangView{
    newsimage_scro *imagesc;
    newsimage_scro *sec2;
    UIScrollView *twoscro;
    newscellview *  orcell;
    
    
}
@synthesize delegate,activityIndicator=_activityIndicator,tab=tab_;

- (id)initWithFrame:(CGRect)frame Type:(FinalshoucangViewType)thetype
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mytype=thetype;
        
        tab_=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH, self.frame.size.height) style:UITableViewStylePlain];
        [self addSubview:tab_];
        
        tab_.delegate=self;
        tab_.dataSource=self;
        tab_.userInteractionEnabled=YES;
        tab_.backgroundColor=[UIColor whiteColor];
        tab_.separatorColor=[UIColor clearColor];
        
        self.normalarray=[[NSMutableArray alloc]init];
        
        
        if (_refreshHeaderView == nil)
        {
            EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-tab_.bounds.size.height,DEVICE_WIDTH, tab_.bounds.size.height)];
            view.delegate = self;
            _refreshHeaderView = view;
        }
        [_refreshHeaderView refreshLastUpdatedDate];
        [tab_ addSubview:_refreshHeaderView];
        
        nomore=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH, 30)];
        nomore.text=@"没有更多数据";
        nomore.textAlignment=NSTextAlignmentCenter;
        nomore.font=[UIFont systemFontOfSize:13];
        nomore.textColor=[UIColor lightGrayColor];
        
        loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
        loadview.backgroundColor=[UIColor clearColor];
        
        numberofpage=1;
        isloadsuccess=YES;
        
        
        
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
        
        [self loadnewsWithPage];
        //        [self addSubview:_activityIndicator];
        //
    }
    return self;
}

-(void)layoutSubviews{
    
}

-(void)newstabreceivenormaldic:(NSDictionary *)_newsNormalDic;
{
    
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
    
    return self.normalarray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stringidentifier=@"cell";
    
    NewshoucangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringidentifier];
    
    if (!cell) {
        cell=[[NewshoucangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringidentifier];
    }
    
    if (self.mytype==FinalshoucangViewTypeNews) {
        
        NSDictionary *_dic=[self.normalarray objectAtIndex:indexPath.row];
        
        [cell newshoucangTableViewCellSetDic:_dic sNewshoucangTableViewCellStyle:NewshoucangTableViewCellStyleNews thebloc:^(int picID) {
            
            
        }];
        
        
    }else if(self.mytype==FinalshoucangViewTypeTiezi){
        if (self.normalarray.count!=0) {
            NSDictionary *_dic=[self.normalarray objectAtIndex:indexPath.row];
            
            
            [cell newshoucangTableViewCellSetDic:_dic sNewshoucangTableViewCellStyle:NewshoucangTableViewCellStyleTiezi thebloc:^(int picID) {
                
                
            }];
            
        }
        
        
        
        
        
    }else if(self.mytype==FinalshoucangViewTypebankuai){
        
        NSDictionary *_dic=[self.normalarray objectAtIndex:indexPath.row];
        
        
        [cell newshoucangTableViewCellSetDic:_dic sNewshoucangTableViewCellStyle:NewshoucangTableViewCellStyleBankuai thebloc:^(int picID) {
            
            
        }];
        
        
        
    }else if(self.mytype==FinalshoucangViewTypetuji){
        
        NSDictionary *_dic=[self.normalarray objectAtIndex:indexPath.row];
        
        
        [cell newshoucangTableViewCellSetDic:_dic sNewshoucangTableViewCellStyle:NewshoucangTableViewCellStyleTuji thebloc:^(int picID) {
            
            
        }];
        
        
        
    }else if(self.mytype==FinalshoucangViewTypeMyWrite){
        
        NSDictionary *_dic=[self.normalarray objectAtIndex:indexPath.row];
        
        
        [cell newshoucangTableViewCellSetDic:_dic sNewshoucangTableViewCellStyle:NewshoucangTableViewCellStyleTiezi thebloc:^(int picID) {
            
            
        }];

        
        
        
    }else if(self.mytype==FinalshoucangViewTypeMyComment){
        
        NSDictionary *_dic=[self.normalarray objectAtIndex:indexPath.row];
        
        
        [cell newshoucangTableViewCellSetDic:_dic sNewshoucangTableViewCellStyle:NewshoucangTableViewCellStyleTiezi thebloc:^(int picID) {
            
            
        }];

        
        
        
    }
    
    
    return cell;
    
}
#pragma mark--网络请求的

-(void)loadnewsWithPage{
    
    
    NSLog(@"pagegeg===%d",numberofpage);
    
    NSString *string_code = [personal getMyAuthkey];

    __weak typeof(self) wself =self;
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *str_search;
    
    switch (self.mytype) {
        case FinalshoucangViewTypeNews:{
            
            str_search=[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=favoriteslist&type=json&took=%@&datatype=1&page=%d&pagesize=10",string_code,numberofpage];
        }
            
            break;
            
        case FinalshoucangViewTypeTiezi:{
            
            str_search=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/favoritesthread.php?authcode=%@&action=query&formattype=json&page=1&pagesize=2&page=%d&pagesize=10",string_code,numberofpage];        }
            
            break;
            
        case FinalshoucangViewTypebankuai:{
            str_search=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/favoritesforums.php?authcode=%@&action=query&formattype=json",string_code];
        }
            
            break;
            
        case FinalshoucangViewTypetuji:{
            
            str_search=[NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=photo&a=favoriteslist&type=json&took=%@&page=%d&pagesize=10",string_code,numberofpage];
        }
            
            break;
        case FinalshoucangViewTypeMyWrite:{
            
            str_search=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getappmythread.php?authcode=%@&page=%d&pagesize=10",string_code,numberofpage];
        }
            
            break;
        case FinalshoucangViewTypeMyComment:{
            
            str_search=[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/getappmyposts.php?authcode=%@&page=%d&pagesize=10",string_code,numberofpage];
        }
            
            break;

            
            
            
        default:
            break;
    }
    
    
    
    
    [loaddata SeturlStr:str_search mytest:^(NSDictionary *dicinfo, int errcode) {
        
        isloadsuccess=YES;
        
        [[self viewWithTag:234] removeFromSuperview];
        
        [self viewWithTag:222].hidden=YES;
        
        if (errcode==0) {
            
            [wself refreshnewsWithDic:dicinfo];
            
            
        }else{
            //网络有问题
            
        }
        
    }];
    
    
    NSLog(@"幻灯的接口是这个。。=%@",str_search);
    
    
}



-(void)refreshnewsWithDic:(NSDictionary *)dic{
    
    NSLog(@"收藏新闻的数据==%@",dic);
    
    if (self.mytype!=2&&self.normalarray.count>=10&&numberofpage==1) {
        tab_.tableFooterView=loadview;
    }else if (self.mytype!=2&&self.normalarray.count<10&&numberofpage==1){
        tab_.tableFooterView=nomore;
        
        
    }
    [loadview stopLoading:1];
    
    if (numberofpage==1) {
        [self.normalarray removeAllObjects];
    }

    
    NSArray *temparray;
    
    switch (self.mytype) {
        case FinalshoucangViewTypeNews:{
            
            
            temparray=[NSArray arrayWithArray:[dic objectForKey:@"list"]];
        }
            
            break;
            
        case FinalshoucangViewTypeTiezi:{
            
            temparray=[NSArray arrayWithArray:[dic objectForKey:@"bbsinfo"]];
        }
            
            break;
            
        case FinalshoucangViewTypebankuai:{
            temparray=[NSArray arrayWithArray:[dic objectForKey:@"bbsinfo"]];
        }
            
            break;
            
        case FinalshoucangViewTypetuji:{
            
            temparray=[NSArray arrayWithArray:[dic objectForKey:@"list"]];
        }
            
            break;
            
            
        case FinalshoucangViewTypeMyWrite:{
            temparray=[NSArray arrayWithArray:[dic objectForKey:@"bbsinfo"]];

           
        }
            
            break;
        case FinalshoucangViewTypeMyComment:{
            temparray=[NSArray arrayWithArray:[dic objectForKey:@"bbsinfo"]];

           
        }
            
            break;
            
            

    }
    
    if (temparray.count<10&&numberofpage>1) {
        
        tab_.tableFooterView=nomore;
        
        isloadsuccess=NO;

        
    }
    
    
    for (NSDictionary *dic in temparray) {
        [self.normalarray addObject:dic];
    }
    
    
    [tab_ reloadData];
    
    
}

#pragma - mark 删除操作

-(void)deleteWithInfo:(NSDictionary *)dic{
    
    NSLog(@"删除数据==%@",dic);
    
    NSString *string_code = [personal getMyAuthkey];
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *str_delete;
    
    switch (self.mytype) {
        case FinalshoucangViewTypeNews:{ //新闻取消收藏
            
            str_delete = [NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=delfavorites&type=json&took=%@&id=%@",string_code,[dic objectForKey:@"nid"]];
        }
            
            break;
            
        case FinalshoucangViewTypeTiezi://删除帖子
        {
            str_delete = [NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/delfavoritesthread.php?delid=%@&formattype=json&authcode=%@",[dic objectForKey:@"tid"],string_code];
        }
            break;
            
        case FinalshoucangViewTypebankuai:{ //删除板块
            
            str_delete = [NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/delfavorites.php?delid=%@&formattype=json&authcode=%@",[dic objectForKey:@"fid"],string_code];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"forumSectionChange" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"fid"],@"forumSectionId",nil]];
            
        }
            
            break;
            
        case FinalshoucangViewTypetuji:{ //图集取消收藏
            
            str_delete = [NSString stringWithFormat:@"http://cmsweb.fblife.com/ajax.php?c=photo&a=delfavorites&type=json&took=%@&id=%@",string_code,[dic objectForKey:@"nid"]];
        }
            
            break;
            
        case FinalshoucangViewTypeMyComment:{ //我回复的
            
            //没有删除
            
        }
            
            break;
        case FinalshoucangViewTypeMyWrite://我的发布
        {
            
        }
            break;
            
    }
    
    [loaddata SeturlStr:str_delete mytest:^(NSDictionary *dicinfo, int errcode) {
        
        NSLog(@"dicinfo %@ %d",dicinfo,errcode);
        
        NSLog(@"dicinfo %@",[dicinfo objectForKey:@"bbsinfo"]);
        
    }];
    
//    [tab_ reloadData];
}


#pragma - mark UITableViewDataSource


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (self.mytype==0) {
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"title"]];
        
        
        return   [NewshoucangTableViewCell NewshoucangTableViewCellHeightFromstyle:NewshoucangTableViewCellStyleNews comstr:thestring];
        
        
        
    }else if(self.mytype==1){
        
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"subject"]];
        
        return   [NewshoucangTableViewCell NewshoucangTableViewCellHeightFromstyle:NewshoucangTableViewCellStyleTiezi comstr:thestring];
        
        
        
        
    }else if(self.mytype==2){
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"subject"]];
        
        return   [NewshoucangTableViewCell NewshoucangTableViewCellHeightFromstyle:NewshoucangTableViewCellStyleBankuai comstr:thestring];
        
        
        
        
    }else if(self.mytype==3){
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"title"]];
        
        return   [NewshoucangTableViewCell NewshoucangTableViewCellHeightFromstyle:NewshoucangTableViewCellStyleTuji comstr:thestring];
        
    }
    else if(self.mytype==4){
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"subject"]];
        
        return   [NewshoucangTableViewCell NewshoucangTableViewCellHeightFromstyle:NewshoucangTableViewCellStyleTuji comstr:thestring];
        
    }
    else if(self.mytype==5){
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"subject"]];
        
        return   [NewshoucangTableViewCell NewshoucangTableViewCellHeightFromstyle:NewshoucangTableViewCellStyleTuji comstr:thestring];
        
    }

    
    
    return 64;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    newsdetailViewController *   comment_=[[newsdetailViewController alloc]init];
    //
    UIViewController *copyRoot=(UIViewController *)self.delegate;
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    if (self.mytype==0) {
        
        
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"nid"]];
        
        newsdetailViewController *detail_=[[newsdetailViewController alloc]initWithID:thestring];
        [copyRoot.navigationController pushViewController:detail_ animated:YES];
        
        NSLog(@"dicnews==%@",dicnews);
        
        
        
        
    }else if(self.mytype==1){
        
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"tid"]];
        
        bbsdetailViewController *detail_=[[bbsdetailViewController alloc]init];
        
        detail_.bbsdetail_tid=thestring;
      [copyRoot.navigationController pushViewController:detail_ animated:YES];
        
        NSLog(@"dicnews==%@",dicnews);
        
        
        
    }else if(self.mytype==2){
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"fid"]];
        
        
        BBSfenduiViewController *detail_=[[BBSfenduiViewController alloc]init];
        detail_.string_id=thestring;
     
        [copyRoot.navigationController pushViewController:detail_ animated:YES];
        
        
        
        
        NSLog(@"dicnewsbankuai==%@",dicnews);
        
        
        
        
    }else if(self.mytype==3){
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"nid"]];
        
        ShowImagesViewController * showImage = [[ShowImagesViewController alloc] init];
        
        showImage.id_atlas = thestring;
        

        
        
        [copyRoot.navigationController pushViewController:showImage animated:YES];
        
        
        
        
        NSLog(@"dicnews==%@",dicnews);
        
        
        
        
        
    }
    else if(self.mytype==4){
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"tid"]];
        
        bbsdetailViewController *detail_=[[bbsdetailViewController alloc]init];
        
        detail_.bbsdetail_tid=thestring;
        [copyRoot.navigationController pushViewController:detail_ animated:YES];
        
        NSLog(@"dicnews==%@",dicnews);
    
    
    }
    else if(self.mytype==5){
        
        NSDictionary *dicnews=[self.normalarray objectAtIndex:indexPath.row];
        
        NSString *thestring=[NSString stringWithFormat:@"%@",[dicnews objectForKey:@"tid"]];
        
        bbsdetailViewController *detail_=[[bbsdetailViewController alloc]init];
        
        detail_.bbsdetail_tid=thestring;
        [copyRoot.navigationController pushViewController:detail_ animated:YES];
        
        NSLog(@"dicnews==%@",dicnews);
    }
    

    
    
    
    
    
}

//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    if ([tableView isEqual:tab_]) {
        
        if (self.mytype != FinalshoucangViewTypeMyComment && self.mytype != FinalshoucangViewTypeMyWrite) { //我的回复不需要删除
            
           result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
        }
        
    }
    return result;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{//设置是否显示一个可编辑视图的视图控制器。

    if (self.mytype != FinalshoucangViewTypeMyComment && self.mytype != FinalshoucangViewTypeMyWrite) {
        [tab_ setEditing:editing animated:animated];//切换接收者的进入和退出编辑模式。
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    
    if (self.mytype == FinalshoucangViewTypeMyComment || self.mytype == FinalshoucangViewTypeMyWrite)
    {
        return;
    }
    
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
        if (indexPath.row<[self.normalarray count]) {
            
            NSDictionary *dic=[self.normalarray objectAtIndex:indexPath.row];
            
            [self.normalarray removeObjectAtIndex:indexPath.row];//移除数据源的数据
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
            //板块 fid
            
            [self deleteWithInfo:dic];
        }
    }
}


#pragma mark EGORefreshTableHeaderDelegate Methods

-(void)refreshwithrag:(int)tag{
    
    
    numberofpage=1;
    [self loadnewsWithPage];
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
	
    //	[self refreshwithrag:self.tag];
    numberofpage=1;
    
    [self loadnewsWithPage];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //要判断当前是哪一个，有tab_/imagesc/twoscrow/sec2
    
    if (scrollView==tab_) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        if(tab_.contentOffset.y > (tab_.contentSize.height - tab_.frame.size.height+40)&&isloadsuccess==YES&&_mytype!=2&&self.normalarray.count>=10) {
            
            
            [loadview startLoading];
            numberofpage++;
            isloadsuccess=!isloadsuccess;
            
            [self loadnewsWithPage];
            
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


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
