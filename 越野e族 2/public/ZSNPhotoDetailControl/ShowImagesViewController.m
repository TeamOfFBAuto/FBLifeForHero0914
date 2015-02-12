//
//  ShowImagesViewController.m
//  FBCircle
//szk
//  Created by soulnear on 14-5-22.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "ShowImagesViewController.h"
#import "AtlasModel.h"
#import "PraiseAndCollectedModel.h"
#import "CustomInputView.h"
#import "commentViewController.h"
#import "UMSocialSnsPlatformManager.h"
#import "ZkingAlert.h"

#import "ShareView.h"


@interface ShowImagesViewController ()
{
    AtlasModel * atlasModel;
    
    UIButton * pinglun_button;//评论按钮，跳转到评论界面
    UILabel * commit_label;//未弹出键盘，显示评论内容
    UIView * input_back_view;//输入评论背景
    
    UIView * text_background_view;//弹出键盘时输入框的背景
    
    UITextView * text_input_view;//弹出键盘时输入框
    
    
    UIView * _theTouchView;//用于点击空白区域消失键盘
    
    UIButton * send_button;//发送按钮
    
    PraiseAndCollectedModel * praise_model;

    
    CustomInputView * input_view;//输入框
    
    ZkingAlert * _thezkingAlertV;
    
    ShareView *_shareView;

}

@end

@implementation ShowImagesViewController
@synthesize allImagesUrlArray = _allImagesUrlArray;
@synthesize myScrollView = _myScrollView;
@synthesize currentPage = _currentPage;
@synthesize id_atlas = _id_atlas;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void)back
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
}


-(void)setNavgationBar
{
    
    navImageView = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,64)];
    
    navImageView.backgroundColor = [UIColor clearColor];// RGBCOLOR(229,229,229);
    
    [self.view addSubview:navImageView];
    
    
    UIImageView * daohangView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,64)];
    
//    daohangView.image = [UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING];
    
    
    daohangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    daohangView.userInteractionEnabled = YES;
    
    [navImageView addSubview:daohangView];
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(0,20,50,44)];
    
    [button_back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [button_back setImage:[UIImage imageNamed:@"atlas_fanhui"] forState:UIControlStateNormal];
    
    button_back.center = CGPointMake(30,42);
    
    [daohangView addSubview:button_back];
    
    NSArray * imageArray = [NSArray arrayWithObjects:@"atlas_zan-1",@"atlas_collect",@"atlas_zhuanfa",@"atlas_zan-2",@"atlas_collect-1",@"",nil];
    
    for (int i = 0;i < 3;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(DEVICE_WIDTH- 200 + 70*i,20,60,44);
        
        button.backgroundColor = [UIColor clearColor];
        
        button.tag = 10000 + i;
        
        button.userInteractionEnabled = NO;
        
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i+3]] forState:UIControlStateSelected];
        
        if (i == 0 && isPraise)
        {
            button.selected = YES;
        }
        
        [daohangView addSubview:button];
    }
}


#pragma mark - 判断是否收藏


-(void)panduanCollection
{
    NSString * string = [NSString stringWithFormat:GET_ATLAS_COLLECTION_URL,AUTHKEY];
    
    ASIHTTPRequest * c_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:string]];
    
    __block typeof(c_request) request = c_request;
    
    __weak typeof(self) bself = self;
    
    [request setCompletionBlock:^{
        
        NSDictionary * allDic = [c_request.responseString objectFromJSONString];
        
        if ([[allDic objectForKey:@"errno"] intValue] == 0)
        {
            if ([[allDic objectForKey:@"pages"] intValue] != 0)
            {
                NSArray * array = [allDic objectForKey:@"list"];
                
                for (NSDictionary * dic in array)
                {
                    if ([[dic objectForKey:@"nid"] isEqualToString:bself.id_atlas])
                    {
                        UIButton * button = (UIButton *)[navImageView viewWithTag:10001];
                        
                        button.selected = YES;
                        
                        isCollected = YES;
                        
                        return;
                    }
                }
            }
        }
    }];
    
    
    [request setFailedBlock:^{
        
    }];
    
    [c_request startAsynchronous];
}

#pragma mark - 判断是否登陆

-(BOOL)isLogIn
{
    BOOL islogin = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!islogin)
    {
        LogInViewController * logIn = [LogInViewController sharedManager];
        
        logIn.delegate = self;
        
        [self presentViewController:logIn animated:YES completion:NULL];
    }
    
    return islogin;
}


-(void)successToLogIn
{
    
}

-(void)failToLogIn
{
    [input_view.text_input_view resignFirstResponder];
}




#pragma mark - 赞 收藏 转发

-(void)buttonTap:(UIButton *)sender
{
    switch (sender.tag - 10000)
    {
        case 0://赞
        {
            [self cancelAndPraise];
            
            [self changeMySizeAnimationWithView:sender];
        }
            break;
        case 1://收藏
        {
            BOOL islogin = [self isLogIn];
            
            if (islogin)
            {
                [self cancelAndCollectionAtlas];
                
                [self changeMySizeAnimationWithView:sender];
            }
        }
            break;
        case 2://转发
        {
            [self ShareMore];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 赞或取消赞

-(void)cancelAndPraise
{
    if (isPraise)
    {
        UIButton * button = (UIButton *)[navImageView viewWithTag:10000];
        
        button.selected = NO;
        
        isPraise = NO;
        
        [PraiseAndCollectedModel deleteWithId:self.id_atlas];
        
        return;
    }
    
    NSString * fullUrl = [NSString stringWithFormat:ATLAS_PRAISE_URL,self.id_atlas];
    
    ASIHTTPRequest * p_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    
    __block typeof(p_request) request = p_request;
    
    __weak typeof(self) bself = self;
    
    
    [_thezkingAlertV zkingalertShowWithString:@"感兴趣"];
    
    [self performSelector:@selector(ShowAndHiddenAlertView:) withObject:NO afterDelay:0.8];
    
    
    [request setCompletionBlock:^{
        
        @try {
            AtlasModel * model = [self.allImagesUrlArray objectAtIndex:0];
            
            int count = [model.atlas_comment intValue];
            
            model.atlas_comment = [NSString stringWithFormat:@"%d",count+1];
            
            [input_view.pinglun_button setTitle:model.atlas_comment forState:UIControlStateNormal];
            
            isPraise = YES;
            
            [PraiseAndCollectedModel addIntoDataSourceWithId:bself.id_atlas WithPraise:[NSNumber numberWithBool:isPraise]];
            
            UIButton * button = (UIButton *)[navImageView viewWithTag:10000];
            
            button.selected = YES;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        
    }];
    
    [p_request startAsynchronous];
    
}



#pragma mark - 收藏或取消收藏图集


-(void)cancelAndCollectionAtlas
{
    NSString * fullUrl;
    
    if (isCollected)
    {
        fullUrl = [NSString stringWithFormat:ATLAS_CANCEL_COLLECTION_URL,AUTHKEY,self.id_atlas];//取消收藏帖子
    }else
    {
        fullUrl = [NSString stringWithFormat:ATLAS_COLLECTION_URL,AUTHKEY,self.id_atlas];//收藏帖子
    }
    
    NSLog(@"收藏或取消收藏接口----%@",fullUrl);
    
    ASIHTTPRequest * c_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    __block typeof(c_request) request = c_request;
    
    [request setCompletionBlock:^{
        
        @try {
            
            [_thezkingAlertV zkingalertShowWithString:isCollected?@"取消收藏":@"收藏成功"];
            
            [self performSelector:@selector(ShowAndHiddenAlertView:) withObject:NO afterDelay:0.8];
            
            isCollected = !isCollected;
            
            UIButton * button = (UIButton *)[navImageView viewWithTag:10001];
            
            button.selected = isCollected;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    
    [request setFailedBlock:^{
        
    }];
    
    [c_request startAsynchronous];
}


#pragma mark - 放到再缩小动画


-(void)changeMySizeAnimationWithView:(UIView *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        
        sender.transform = CGAffineTransformMakeScale(1.5,1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            sender.transform = CGAffineTransformMakeScale(1,1);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
}




-(void)SavePicturesClick:(UIButton *)sender
{
    QBShowImagesScrollView * scrollView = (QBShowImagesScrollView *)[_myScrollView viewWithTag:_currentPage+1000];
    
    if (scrollView.locationImageView.image)
    {
        UIImageWriteToSavedPhotosAlbum(scrollView.locationImageView.image,self,
                                       @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    myAlertView = [[FBQuanAlertView alloc] initWithFrame:CGRectMake(0,0,138,50)];
    
    [myAlertView setType:FBQuanAlertViewTypeNoJuhua thetext:@"保存图片成功"];
    
    myAlertView.center = CGPointMake(DEVICE_WIDTH/2,DEVICE_HEIGHT/2-20);
    
    [self.view addSubview:myAlertView];

    [self performSelector:@selector(dismissPromptView) withObject:nil afterDelay:1];
}

-(void)dismissPromptView
{
    [myAlertView removeFromSuperview];
    
    myAlertView = nil;
}

-(void)ShowAndHiddenAlertView:(BOOL)isShow
{
    [UIView animateWithDuration:0.6 animations:^{
        
        _thezkingAlertV.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        _thezkingAlertV.hidden = YES;
        
        _thezkingAlertV.alpha = 1;
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = YES;

    [input_view addKeyBordNotification];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [input_view deleteKeyBordNotification];
}

-(void)viewDidDisappear:(BOOL)animated
{
//    [input_view.text_background_view removeFromSuperview];
//    
//    input_view.text_background_view = nil;
    self.edgesForExtendedLayout = UIRectEdgeAll;
}


#pragma mark - 获取图集数据

-(void)loadData
{
    __weak typeof(self) bself = self;
    
    if (!self.allImagesUrlArray)
    {
        _allImagesUrlArray = [NSMutableArray array];
    }
    [atlasModel loadAtlasDataWithId:self.id_atlas WithCompleted:^(NSMutableArray *array) {
        
        input_view.userInteractionEnabled = YES;
        
        _myScrollView.scrollEnabled = YES;
        
        [bself.allImagesUrlArray addObjectsFromArray:array];
        
        atlasModel = [bself.allImagesUrlArray objectAtIndex:bself.currentPage];
        
        string_title = atlasModel.atlas_name;
        
        [bself loadCurrentImageWithUrl:atlasModel.atlas_photo];
        
        [bself loadImageInformationWith:atlasModel];
        
        [input_view.pinglun_button setTitle:atlasModel.atlas_comment forState:UIControlStateNormal];
        
        bself.myScrollView.contentSize = CGSizeMake((DEVICE_WIDTH+20)*self.allImagesUrlArray.count,0);
        bself.myScrollView.contentOffset = CGPointMake((DEVICE_WIDTH+20)*_currentPage,0);
        
        
        commit_label.userInteractionEnabled = YES;
                
        for (int i = 0;i < 3;i++)
        {
            UIButton * button = (UIButton *)[navImageView viewWithTag:10000+i];
            
            button.userInteractionEnabled = YES;
        }

        
    } WithFailedBlock:^(NSString *string) {
        
        QBShowImagesScrollView * scrollView = (QBShowImagesScrollView *)[bself.myScrollView viewWithTag:bself.currentPage+1000];
        
        [scrollView loadDataFailed];
        
    }];
}

-(void)loadImageInformationWith:(AtlasModel *)model
{
    content_back_view.hidden = NO;
    
    [content_back_view reloadInformationWith:model WithCurrentPage:_currentPage+1 WithTotalPage:self.allImagesUrlArray.count];
}


#pragma mark - 加载图片


-(void)loadCurrentImageWithUrl:(NSString *)theUrl
{
    QBShowImagesScrollView * his_scrollview = (QBShowImagesScrollView *)[_myScrollView viewWithTag:1000+_currentPage];
    
    if (his_scrollview)
    {
        if (!his_scrollview.locationImageView.image)
        {
            [his_scrollview.locationImageView loadImageFromURL:theUrl withPlaceholdImage:nil];
        }
        
        return;
    }
    
    QBShowImagesScrollView * scrollView = [[QBShowImagesScrollView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH+20)*_currentPage,0,DEVICE_WIDTH,_myScrollView.frame.size.height) WithUrl:theUrl];
    
    scrollView.aDelegate = self;
    
    scrollView.tag = 1000+_currentPage;
    
    scrollView.backgroundColor = [UIColor blackColor];//RGBCOLOR(242,242,242);
    
    [_myScrollView addSubview:scrollView];
}




-(void)loadImageView
{
    if ([[self.allImagesUrlArray objectAtIndex:0] isKindOfClass:[UIImage class]])
    {
        for (int i = 0;i < self.allImagesUrlArray.count;i++)
        {
            QBShowImagesScrollView * scrollView = [[QBShowImagesScrollView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH+20)*i,0,DEVICE_WIDTH,_myScrollView.frame.size.height) WithUrl:@""];
            
            scrollView.aDelegate = self;
            
            scrollView.tag = 1000+i;
            
            scrollView.locationImageView.image = [self.allImagesUrlArray objectAtIndex:i];
            
            scrollView.backgroundColor = RGBCOLOR(242,242,242);
            
            [_myScrollView addSubview:scrollView];
        }
        
    }else if ([[self.allImagesUrlArray objectAtIndex:0] isKindOfClass:[AtlasModel class]])
    {
        for (int i = 0;i < self.allImagesUrlArray.count;i++)
        {
            AtlasModel * model = [self.allImagesUrlArray objectAtIndex:_currentPage];
            
            NSString * string = model.atlas_photo;
            
            while ([string rangeOfString:@"small"].length) {
                string=[string stringByReplacingOccurrencesOfString:@"small" withString:@"ori"];
            }
            
            QBShowImagesScrollView * scrollView = [[QBShowImagesScrollView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH+20)*_currentPage,0,DEVICE_WIDTH,_myScrollView.frame.size.height) WithUrl:nil];
            
            scrollView.aDelegate = self;
            
            scrollView.tag = 1000+_currentPage;
            
            scrollView.backgroundColor = [UIColor blackColor];//RGBCOLOR(242,242,242);
            
            [_myScrollView addSubview:scrollView];
        }
    }else
    {
        for (int i = 0;i < self.allImagesUrlArray.count;i++)
        {
            NSString * string = [self.allImagesUrlArray objectAtIndex:i];
            
            while ([string rangeOfString:@"small"].length) {
                string=[string stringByReplacingOccurrencesOfString:@"small" withString:@"ori"];
            }
            
            QBShowImagesScrollView * scrollView = [[QBShowImagesScrollView alloc] initWithFrame:CGRectMake((DEVICE_WIDTH+20)*i,0,DEVICE_WIDTH,_myScrollView.frame.size.height) WithUrl:string];
            
            scrollView.aDelegate = self;
            
            scrollView.tag = 1000+i;
            
            scrollView.backgroundColor = RGBCOLOR(242,242,242);
            
            [_myScrollView addSubview:scrollView];
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (MY_MACRO_NAME) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor blackColor];//RGBCOLOR(229,229,229);
    
    praise_model = [[PraiseAndCollectedModel alloc] init];
    
    isPraise = [[[PraiseAndCollectedModel getTeamInfoById:self.id_atlas] praise] intValue];
    
    atlasModel = [[AtlasModel alloc] init];
    
    [self loadData];
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH+20,DEVICE_HEIGHT)];
    _myScrollView.delegate = self;
    _myScrollView.pagingEnabled = YES;
    _myScrollView.backgroundColor = [UIColor blackColor];//RGBCOLOR(242,242,242);
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.contentSize = CGSizeMake((DEVICE_WIDTH+20)*self.allImagesUrlArray.count,0);
    [self.view addSubview:_myScrollView];
    
    _myScrollView.contentOffset = CGPointMake((DEVICE_WIDTH+20)*_currentPage,0);
    _myScrollView.scrollEnabled = NO;
    [self loadCurrentImageWithUrl:nil];
    
    
    
    content_back_view = [[AtlasContentView alloc] initWithFrame:CGRectMake(0,DEVICE_HEIGHT-166,DEVICE_WIDTH,122)];
    
    content_back_view.hidden = YES;
    
    [self.view addSubview:content_back_view];
    
    __weak typeof(self) bself = self;
    
    input_view = [[CustomInputView alloc] initWithFrame:CGRectMake(0,content_back_view.frame.origin.y + content_back_view.frame.size.height,DEVICE_WIDTH,44)];
    
    input_view.userInteractionEnabled = NO;
    
    [input_view loadAllViewWithPinglunCount:@"0" WithType:0 WithPushBlock:^(int type){
        
        
        if (type == 0)
        {
            NSLog(@"跳到评论");
            
            [bself pushToComments];
        }else
        {
            NSLog(@"分类按钮");
        }        
        
        
        
    } WithSendBlock:^(NSString *content, BOOL isForward) {
        
        NSLog(@"发表评论");
        
        [bself submitPingLunTap:content];
        
    }];
    
    [self.view addSubview:input_view];
    
    
    input_view.backgroundColor = RGBCOLOR(3,3,3);
    input_view.top_line_view.backgroundColor = [UIColor clearColor];
    input_view.commot_background_view.backgroundColor = RGBCOLOR(24,26,25);
    input_view.commot_background_view.layer.borderWidth = 0;
    input_view.commit_label.textColor = RGBCOLOR(52,63,62);
    [input_view.pinglun_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    input_view.text_input_view.layer.borderColor = RGBCOLOR(211,211,211).CGColor;
    
    
    
//    input_back_view = [[UIView alloc] initWithFrame:CGRectMake(0,content_back_view.frame.origin.y + content_back_view.frame.size.height,320,44)];
//    
//    input_back_view.backgroundColor = RGBCOLOR(3,3,3);
//    
//    [self.view addSubview:input_back_view];
//    
//    
//    
//    UIView * commot_background_view = [[UIView alloc] initWithFrame:CGRectMake(11,7,255,30)];
//    
//    commot_background_view.backgroundColor = RGBCOLOR(24,26,25);
//    
//    [input_back_view addSubview:commot_background_view];
//    
//    
//    commit_label = [[UILabel alloc] initWithFrame:CGRectMake(5,0,245,30)];
//    
//    commit_label.userInteractionEnabled = NO;
//    
//    commit_label.backgroundColor = [UIColor clearColor];
//    
//    commit_label.textColor = RGBCOLOR(52,63,62);
//    
//    commit_label.text = @"我来说两句...";
//    
//    commit_label.font = [UIFont systemFontOfSize:14];
//    
//    commit_label.textAlignment = NSTextAlignmentLeft;
//    
//    [commot_background_view addSubview:commit_label];
//    
//    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInputView:)];
//    
//    [commit_label addGestureRecognizer:tap];
//    
//    
//    
//    
//    pinglun_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    pinglun_button.frame = CGRectMake(275,7,30,30);
//    
//    pinglun_button.userInteractionEnabled = NO;
//    
//    pinglun_button.titleLabel.textAlignment = NSTextAlignmentRight;
//    
//    [pinglun_button setTitle:@"0" forState:UIControlStateNormal];
//    
//    pinglun_button.titleLabel.font = [UIFont systemFontOfSize:14];
//    
//    [pinglun_button addTarget:self action:@selector(pushToPinglunTap:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [input_back_view addSubview:pinglun_button];
//    
//    
//    
//    UIImageView * pinglun_image_view = [[UIImageView alloc] initWithFrame:CGRectMake(20,0,11,11.5)];
//    
//    pinglun_image_view.image = [UIImage imageNamed:@"atlas_talk"];
//    
//    [pinglun_button addSubview:pinglun_image_view];
//    
//    
//    
//    
//    text_background_view = [[UIView alloc] initWithFrame:CGRectMake(0,(iPhone5?568:480),320,164)];
//    
//    text_background_view.backgroundColor = RGBCOLOR(249,248,249);
//    
//    [self.view addSubview:text_background_view];
//    
//    
//    text_input_view = [[UITextView alloc] initWithFrame:CGRectMake(20,20,280,84)];
//    
//    text_input_view.layer.masksToBounds = NO;
//    
//    text_input_view.delegate = self;
//    
//    text_input_view.layer.borderColor = RGBCOLOR(211,211,211).CGColor;
//    
//    text_input_view.layer.borderWidth = 0.5;
//    
//    [text_background_view addSubview:text_input_view];
//    
//    
//    send_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    send_button.frame = CGRectMake(240,120,60,30);
//    
//    send_button.enabled = NO;
//    
//    [send_button setTitle:@"发送" forState:UIControlStateNormal];
//    
//    [send_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    send_button.backgroundColor = RGBCOLOR(221,221,221);
//    
//    [send_button addTarget:self action:@selector(submitPingLunTap:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [text_background_view addSubview:send_button];
//    
//    

//    
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(handleWillShowKeyboard:)
//												 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(handleWillHideKeyboard:)
//												 name:UIKeyboardWillHideNotification
//                                               object:nil];
    
    
    
    [self panduanCollection];

    [self setNavgationBar];
    
    
    
    
    _thezkingAlertV=[[ZkingAlert alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH,DEVICE_HEIGHT) labelString:@""];
    _thezkingAlertV.hidden=YES;
    [self.view addSubview:_thezkingAlertV];
    
    
    
}


#pragma mark-UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    

    if (page != _currentPage)
    {
        _currentPage = page;
        
        AtlasModel * model = [self.allImagesUrlArray objectAtIndex:page];
        
        [self loadImageInformationWith:model];
        
        [self loadCurrentImageWithUrl:model.atlas_photo];
    }
    
    if (scrollView.contentOffset.x > DEVICE_WIDTH*self.allImagesUrlArray.count + 40)
    {
        [self pushToComments];
    }
}


#pragma mark- QBShowImagesScrollViewDelegate


-(void)singleClicked
{
    UIApplication * app = [UIApplication sharedApplication];
    
    BOOL isHidden = !app.statusBarHidden;
    
    [app setStatusBarHidden:isHidden withAnimation:UIStatusBarAnimationFade];
//
//    CGRect frame = navImageView.frame;
//    
//    frame.origin.y = frame.origin.y + (isHidden?-frame.size.height:frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
//        navImageView.frame = frame;
        navImageView.alpha = isHidden?0:1;
        
        content_back_view.alpha = isHidden?0:1;
        
        input_view.alpha = isHidden?0:1;
        
    } completion:^(BOOL finished) {
        
    }];
}


//重新加载数据

-(void)reloadAtlasData
{
    [self loadData];
}



#pragma mark-点击空白区域消失键盘

-(void)hiddeninputViewTap:(UITapGestureRecognizer *)sender
{
    [text_input_view resignFirstResponder];
}


#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
    
    if (!_theTouchView)
    {
        _theTouchView = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,text_background_view.frame.origin.y)];
        
        _theTouchView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddeninputViewTap:)];
        
        [_theTouchView addGestureRecognizer:tap];
        
        [self.view bringSubviewToFront:_theTouchView];
        
        [self.view addSubview:_theTouchView];
    }else
    {
        _theTouchView.hidden = NO;
    }
}



-(void)textViewDidChange:(UITextView *)textView
{
    commit_label.text = text_input_view.text;
    
    if (text_input_view.text.length > 0)
    {
        send_button.backgroundColor = [UIColor redColor];
        
        send_button.enabled = YES;
    }else
    {
        send_button.enabled = NO;
        
        send_button.backgroundColor = RGBCOLOR(221,221,221);
    }
}


#pragma mark - 发送评论


-(void)submitPingLunTap:(NSString *)sender
{
    [input_view.text_input_view resignFirstResponder];
    
    if (sender.length == 0) {
        [zsnApi showAutoHiddenMBProgressWithText:@"评论内容不能为空" addToView:self.view];
        return;
    }
    
    
//    NSString * fullUrl = [NSString stringWithFormat:ATLAS_COMMENT_URL,atlasModel.atlas_id,sender,atlasModel.atlas_name,AUTHKEY];
    
    
//    NSString *string_102=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentadd&sort=%@&sortid=%d&content=%@&title=%@&fromtype=b5eeec0b&authkey=%@",self.sortString,[self.string_ID integerValue],[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.string_title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    NSString * fullUrl = [NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentadd&sort=%@&sortid=%d&content=%@&title=%@&fromtype=b5eeec0b&authkey=%@",@"15",[self.id_atlas integerValue],sender,atlasModel.atlas_name,AUTHKEY];
    
//    NSString * fullUrl = [NSString stringWithFormat:ATLAS_COMMENT_URL2,atlasModel.atlas_id,sender,atlasModel.atlas_name,atlasModel.atlas_content,atlasModel.atlas_photo,AUTHKEY];
    
    
    NSLog(@"发表图集评论接口 ---   %@",fullUrl);
    
    NSURL * url = [NSURL URLWithString:[fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest * comment_request = [[ASIHTTPRequest alloc] initWithURL:url];
    
    __block typeof(comment_request) request = comment_request;
    
    [request setCompletionBlock:^{
        
        NSDictionary * allDic = [comment_request.responseString objectFromJSONString];
        
        if ([[allDic objectForKey:@"errcode"] intValue] == 0)
        {
            [_thezkingAlertV zkingalertShowWithString:@"评论成功"];
            text_input_view.text = @"";
            input_view.text_input_view.text = @"";
            [self performSelector:@selector(ShowAndHiddenAlertView:) withObject:NO afterDelay:0.8];
            
        }else
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:[allDic objectForKey:@"data"] message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            
            [alertView show];
        }
    }];
    
    [request setFailedBlock:^{
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"发送失败,请重试" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alertView show];
        
    }];
    
    [comment_request startAsynchronous];
    
}




#pragma mark - 分享


#pragma mark-进入分享

-(void)ShareMore{
    
    __weak typeof(_shareView)w_shareView=_shareView;
    
    
    __weak typeof(self)wself=self;
    if (!_shareView) {
        _shareView =[[ShareView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) thebloc:^(NSInteger indexPath) {
            
            NSLog(@"xxx==%d",indexPath);
            
            
            [wself clickedButtonAtIndex:indexPath];
            
            
        }];
        
        [_shareView ShareViewShow];
        
    }else{
        [_shareView ShareViewShow];
        
    }
    
    
    
}

-(void)clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    NSString * string_url = [NSString stringWithFormat:@"http://special.fblife.com/listphoto/%@.html",self.id_atlas];
    
    if(buttonIndex==0){
        
        
        BOOL islogin = [self isLogIn];
        
        if (!islogin)
        {
            return;
        }
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
            
            writeBlogView.theText = [NSString stringWithFormat:@"分享图集:“%@”,链接:%@",string_title,string_url] ;
            
            [self presentViewController:writeBlogView animated:YES completion:NULL];
        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex==3){
        NSLog(@"到新浪微博界面的");
        
        if ([WeiboSDK isWeiboAppInstalled]) {

        WBWebpageObject *pageObject = [ WBWebpageObject object ];
        pageObject.objectID =@"nimeideid";
        pageObject.thumbnailData =UIImageJPEGRepresentation([UIImage imageNamed:@"Icon@2x.png"], 1);
        pageObject.title = @"分享自越野e族客户端";
        pageObject.description = string_title;
        pageObject.webpageUrl = string_url;
        WBMessageObject *message = [ [ WBMessageObject alloc ] init ];
        message.text =[NSString stringWithFormat:@"%@（分享自@越野e族）",string_title] ;
        
        message.mediaObject = pageObject;
        WBSendMessageToWeiboRequest *req = [ [  WBSendMessageToWeiboRequest alloc ] init  ];
        req.message = message;
            [ WeiboSDK sendRequest:req ];
        }else{
                
                
                UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的手机未安装微博客户端" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [myAlert show];
            }

        
    }
    
    else if(buttonIndex==4){
        
        NSLog(@"分享到邮箱");
        
        //        [UMSocialData defaultData].shareText =[NSString stringWithFormat:@"%@（分享自越野e族）  %@<html><a href=http://mobile.fblife.com/>\n点击下载越野e族客户端</a></html>",string_title,string_url] ;
        //
        //        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"email"];
        //
        //        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
        NSString *string_bodyofemail=[NSString stringWithFormat:@"%@ \n %@ \n\n 下载越野e族客户端 http://mobile.fblife.com/download.php",string_title,string_url] ;
        [self okokokokokokowithstring:string_bodyofemail];
        
        
    }else if(buttonIndex==1){
        NSLog(@"分享给微信好友");
        
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alView show];
        }
        
    }
    else if(buttonIndex==2){
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneTimeline;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alView show];
        }
        
        NSLog(@"分享到微信朋友圈");
        
    }
    //分享编辑页面的接口
    
    
    
}




//-(void)ShareMore{
//    
//    my_array =[[NSMutableArray alloc]init];
//    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"  " delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    editActionSheet.actionSheetStyle = UIActivityIndicatorViewStyleGray;
//    
//    
//    
//    [editActionSheet addButtonWithTitle:@"分享到FB自留地"];
//    
//    [editActionSheet addButtonWithTitle:@"分享到微信朋友圈"];
//    
//    [editActionSheet addButtonWithTitle:@"分享给微信好友"];
//    
//    for (NSString *snsName in [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
//        /*2013-07-22 17:09:59.546 UMSocial[4631:907] name==qzone
//         2013-07-22 17:09:59.55x3 UMSocial[4631:907] name==sina
//         2013-07-22 17:09:59.559 UMSocial[4631:907] name==tencent
//         2013-07-22 17:09:59.564 UMSocial[4631:907] name==renren
//         2013-07-22 17:09:59.575 UMSocial[4631:907] name==douban
//         2013-07-22 17:09:59.578 UMSocial[4631:907] name==wechat
//         2013-07-22 17:09:59.583 UMSocial[4631:907] name==wxtimeline
//         2013-07-22 17:09:59.587 UMSocial[4631:907] name==email
//         2013-07-22 17:09:59.592 UMSocial[4631:907] name==sms
//         2013-07-22 17:09:59.595 UMSocial[4631:907] name==facebook
//         2013-07-22 17:09:59.598 UMSocial[4631:907] name==twitter*/
//        
//        if ([snsName isEqualToString:@"facebook"]||[snsName isEqualToString:@"twitter"]||[snsName isEqualToString:@"renren"]||[snsName isEqualToString:@"qzone"]||[snsName isEqualToString:@"douban"]||[snsName isEqualToString:@"tencent"]||[snsName isEqualToString:@"sms"]||[snsName isEqualToString:@"wxtimeline"]) {
//        }else{
//            NSLog(@"weishenmehaiyu===%@",my_array);
//            [my_array addObject:snsName];
//            if ([snsName isEqualToString:@"sina"]) {
//                [editActionSheet addButtonWithTitle:@"分享到新浪微博"];
//                
//            }
//            if ([snsName isEqualToString:@"email"]) {
//                
//            }
//            
//            //            else if([snsName isEqualToString:@"wechat"])
//            //            {
//            //                [editActionSheet addButtonWithTitle:@"分享给微信好友"];
//            //
//            //
//            //            }
//            //            else if([snsName isEqualToString:@"wxtimeline"])
//            //            {
//            //                [editActionSheet addButtonWithTitle:@"分享到微信朋友圈"];
//            //
//            //            }
//            //            else{
//            //                [editActionSheet addButtonWithTitle:@"短信分享"];
//            //
//            //            }
//            //
//            
//        }
//        
//        
//    }
//    
//    [editActionSheet addButtonWithTitle:@"分享到朋友邮箱"];
//    
//    [editActionSheet addButtonWithTitle:@"取消"];
//    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
//    // [editActionSheet showFromTabBar:self.tabBarController.tabBar];
//    [editActionSheet showFromRect:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) inView:self.view animated:YES];
//    editActionSheet.delegate = self;
//    
//    
//    CGRect oldFrame;
//    
//    for (id label in editActionSheet.subviews)
//    {
//        if ([label isKindOfClass:[UILabel class]])
//        {
//            [[(UILabel *)label text] isEqualToString:@"  "];
//            
//            oldFrame = [(UILabel *)label frame];
//        }
//    }
//    
//    
//    UILabel *newTitle = [[UILabel alloc] initWithFrame:oldFrame];
//    newTitle.font = [UIFont systemFontOfSize:18];
//    newTitle.textAlignment = NSTextAlignmentCenter;
//    newTitle.backgroundColor = [UIColor clearColor];
//    newTitle.textColor = RGBCOLOR(160,160,160);
//    newTitle.text = @"分享";
//    [editActionSheet addSubview:newTitle];
//    
//    
//    
//}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString * string_url = [NSString stringWithFormat:@"http://special.fblife.com/listphoto/%@.html",self.id_atlas];
    
    if(buttonIndex==0){
        
        
        BOOL islogin = [self isLogIn];
        
        if (!islogin)
        {
            return;
        }
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
            
            writeBlogView.theText = [NSString stringWithFormat:@"分享论坛:“%@”,链接:%@",string_title,string_url] ;
            
            [self presentViewController:writeBlogView animated:YES completion:NULL];
        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex==3){
        NSLog(@"到新浪微博界面的");
        WBWebpageObject *pageObject = [ WBWebpageObject object ];
        pageObject.objectID =@"nimeideid";
        pageObject.thumbnailData =UIImageJPEGRepresentation([UIImage imageNamed:@"Icon@2x.png"], 1);
        pageObject.title = @"分享自越野e族客户端";
        pageObject.description = string_title;
        pageObject.webpageUrl = string_url;
        WBMessageObject *message = [ [ WBMessageObject alloc ] init ];
        message.text =[NSString stringWithFormat:@"%@（分享自@越野e族）",string_title] ;
        
        message.mediaObject = pageObject;
        WBSendMessageToWeiboRequest *req = [ [  WBSendMessageToWeiboRequest alloc ] init  ];
        req.message = message;
        [ WeiboSDK sendRequest:req ];
        
    }
    
    else if(buttonIndex==4){
        
        NSLog(@"分享到邮箱");
        
        //        [UMSocialData defaultData].shareText =[NSString stringWithFormat:@"%@（分享自越野e族）  %@<html><a href=http://mobile.fblife.com/>\n点击下载越野e族客户端</a></html>",string_title,string_url] ;
        //
        //        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"email"];
        //
        //        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
        NSString *string_bodyofemail=[NSString stringWithFormat:@"%@ \n %@ \n\n 下载越野e族客户端 http://mobile.fblife.com/download.php",string_title,string_url] ;
        [self okokokokokokowithstring:string_bodyofemail];
        
        
    }else if(buttonIndex==2){
        NSLog(@"分享给微信好友");
        
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alView show];
            
        }
        
    }
    else if(buttonIndex==1){
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x.png"]] ;
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = _weburl_Str;
            ext.webpageUrl=string_url;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneTimeline;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的iPhone上还没有安装微信" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alView show];
            
        }
        
        
        NSLog(@"分享到微信朋友圈");
        
    }
    //分享编辑页面的接口
    //
    
    
}


-(void)okokokokokokowithstring:(NSString *)___str{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"分享自越野e族"];
    
    // Fill out the email body text
    NSString *emailBody =___str;
    [picker setMessageBody:emailBody isHTML:NO];
    
    @try {
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    NSString *title = @"Mail";
    
    NSString *msg;
    
    switch (result)
    
    {
            
        case MFMailComposeResultCancelled:
            
            msg = @"Mail canceled";//@"邮件发送取消";
            
            break;
            
        case MFMailComposeResultSaved:
            
            msg = @"Mail saved";//@"邮件保存成功";
            
            // [self alertWithTitle:title msg:msg];
            
            break;
            
        case MFMailComposeResultSent:
            
            msg = @"邮件发送成功";//@"邮件发送成功";
            
            [self alertWithTitle:title msg:msg];
            
            break;
            
        case MFMailComposeResultFailed:
            
            msg = @"邮件发送失败";//@"邮件发送失败";
            
            [self alertWithTitle:title msg:msg];
            
            break;
            
        default:
            
            msg = @"Mail not sent";
            
            // [self alertWithTitle:title msg:msg];
            
            break;
            
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg

{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                          
                                                    message:msg
                          
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
    
}

#pragma mark - 跳转到评论界面
-(void)pushToComments
{
    commentViewController * comment_=[[commentViewController alloc]init];
    comment_.sortString=@"15";//这个是判断图集或者新闻的，图集是15
    comment_.string_ID=self.id_atlas;//这个是图集的id
    comment_.string_title = atlasModel.atlas_name;//@"越野e族";
    //        comment_.string_author = @"越野e族";
    comment_.string_date=@"越野e族";
    [self.navigationController pushViewController:comment_ animated:YES];
}


- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}




-(void)dealloc
{
    myAlertView = nil;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
