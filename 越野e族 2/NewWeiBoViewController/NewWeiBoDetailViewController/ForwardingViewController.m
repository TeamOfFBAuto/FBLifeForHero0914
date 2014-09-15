//
//  ForwardingViewController.m
//  FbLife
//
//  Created by szk on 13-3-18.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "ForwardingViewController.h"
#import "WeiBoFaceScrollView.h"
#import "NewFaceView.h"
#import "FriendListViewController.h"
#import "rtLabel.h"

@class RTLabelComponent;
@class RTLabelExtractedComponent;


@interface ForwardingViewController ()
{
    WeiBoFaceScrollView * scrollView;
    AlertRePlaceView * _replaceAlertView;
    
}

@end

@implementation ForwardingViewController
@synthesize info = _info;
@synthesize myTextView;
@synthesize tid;
@synthesize rid;
@synthesize username;
@synthesize theTitle;
@synthesize totid;
@synthesize theText;
@synthesize zhuanfa;
@synthesize delegate;


#pragma mark-显示框
-(void)hidefromview{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
    NSLog(@"?????");
}
-(void)hidealert{
    _replaceAlertView.hidden=YES;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
    hud.delegate=nil;
    [hud removeFromParentViewController];
    hud=nil;
    
    [MobClick endEvent:@"ForwardingViewController"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"ForwardingViewController"];
}


-(NSString *)exchangeString:(NSString *)theString
{
    NSString * _text = [theString stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    RTLabelExtractedComponent *component = [RTLabel extractTextStyleFromText:_text paragraphReplacement:@"\n"];
    
    return component.plainText;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isZhuanFa = NO;
    
    if (![tid isEqualToString:@""] && tid.length > 0 && ![tid isEqual:[NSNull null]])
    {
        self.info.tid = tid;
        self.info.rtid = rid;
        self.info.content = theTitle;
        self.totid = totid;
    }
    
    if (self.info.userName.length !=0)
    {
        username = self.info.userName;
    }
    
    if ([zhuanfa isEqualToString:@"1"])
    {
        isZhuanFa = YES;
    }
    
    
    
    //自定义navigation
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //创建navbar
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, aScreenRect.size.width,IOS_VERSION>=7.0?64:44)];
    //创建navbaritem
    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@"转发微博"];
    nav.barStyle = UIBarStyleBlackOpaque;
    [nav pushNavigationItem:NavTitle animated:YES];
    
    [self.view addSubview:nav];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = MY_MACRO_NAME?-4:5;
    
    
    //创建barbutton 创建系统样式的
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,31/2,32/2)];
    
    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    
    NavTitle.leftBarButtonItems=@[negativeSpacer,back_item];
    
    UIButton * send_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    send_button.frame = CGRectMake(0,0,40,40);
    
    send_button.backgroundColor = [UIColor clearColor];
    
    [send_button setTitleEdgeInsets:UIEdgeInsetsMake(5,0,0,0)];
    
    send_button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [send_button setTitle:@"发送" forState:UIControlStateNormal];
    
    send_button.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [send_button setTitleColor:RGBCOLOR(89,89,89) forState:UIControlStateNormal];
    
    [send_button addTarget:self action:@selector(fasong:) forControlEvents:UIControlEventTouchUpInside];
    
    NavTitle.rightBarButtonItems = @[negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:send_button]];
    //设置barbutton
    [nav setItems:[NSArray arrayWithObject:NavTitle]];
    
    if([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,30)];
    
    title_label.text = @"转发微博";
    
    title_label.backgroundColor = [UIColor clearColor];
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.font = TITLEFONT;
    
    title_label.textAlignment = NSTextAlignmentCenter;
    
    NavTitle.titleView = title_label;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    myTextView = [[MyTextViewForForward alloc] initWithFrame:CGRectMake(10,IOS_VERSION>=7.0?64:44,300,100)];
    myTextView.backgroundColor = [UIColor clearColor];
    myTextView.delegate = self;
    myTextView.delegate1 = self;
    myTextView.canCancelContentTouches = NO;
    myTextView.delaysContentTouches = NO;
    myTextView.font = [UIFont systemFontOfSize:16];
    myTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //    [myTextView sizeToFit];
    if (theText.length ==0)
    {
        myTextView.tag = 100;
        myTextView.text = @"分享新鲜事......";
        myTextView.textColor = RGBCOLOR(146,146,146);
        
        myTextView.selectedRange =  NSMakeRange(0, 0);
    }else
    {
        myTextView.tag = 101;
        myTextView.text = theText;
        myTextView.textColor = [UIColor blackColor];
    }
    
    
    [myTextView becomeFirstResponder];
    [self.view addSubview:myTextView];
    
    
    if ([self.info.totid intValue] > 0 || [self.info.rsort intValue]==5|| [self.info.rsort intValue]==6|| [self.info.rsort intValue]==7|| [self.info.rsort intValue]==8|| [self.info.rsort intValue]==9 || [self.info.type isEqualToString:@"both"] || [self.info.type isEqualToString:@"forward"])
    {
        myTextView.text = [NSString stringWithFormat:@"//@%@ :%@",username,[self exchangeString:[zsnApi FBEximgreplace:self.info.content]]];
        myTextView.tag = 101;
        myTextView.selectedRange =  NSMakeRange(0, 0);
        myTextView.textColor = [UIColor blackColor];
    }
    
    
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,73)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    face_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,30)];
    face_view.backgroundColor = [UIColor whiteColor];
    [backView addSubview:face_view];
    
    
    wordsNumber_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    wordsNumber_button.frame = CGRectMake(260,2.5,60,25);
    
    [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
    
    [wordsNumber_button setTitleColor:RGBCOLOR(154,162,166) forState:UIControlStateNormal];
    
    wordsNumber_button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [wordsNumber_button setTitleEdgeInsets:UIEdgeInsetsMake(1,0,0,12)];
    
    UIImageView *xximg=[[UIImageView alloc]initWithFrame:CGRectMake(40,9,9,9)];
    xximg.image=[UIImage imageNamed:@"writeblog_delete_image.png"];
    [wordsNumber_button addSubview:xximg];
    
    
    
    [wordsNumber_button setImageEdgeInsets:UIEdgeInsetsMake(2,35,0,0)];
    
    [wordsNumber_button addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside
     ];
    
    //    [wordsNumber_button setBackgroundImage:[personal getImageWithName:@"4-121-51@2x"] forState:UIControlStateNormal];
    
    wordsNumber_button.backgroundColor = [UIColor clearColor];
    
    [face_view addSubview:wordsNumber_button];
    
    
    
    weibo_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,30,320,43)];
    weibo_view.userInteractionEnabled = YES;
    weibo_view.image = [personal getImageWithName:@"write_blog_back@2x"];
    [backView addSubview:weibo_view];
    
    
    UIButton * huatiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    huatiButton.frame = CGRectMake(23/2-4.5,11.5,43/2,43/2);
    
    [huatiButton addTarget:self action:@selector(huati:) forControlEvents:UIControlEventTouchUpInside];
    
    [huatiButton setImage:[personal getImageWithName:@"talk_write@2x"] forState:UIControlStateNormal];
    
    [weibo_view addSubview:huatiButton];
    
    UIButton * at_button = [UIButton buttonWithType:UIButtonTypeCustom];
    at_button.frame = CGRectMake(76.25-4.5,11.5,43/2,43/2);
    [at_button addTarget:self action:@selector(at:) forControlEvents:UIControlEventTouchUpInside];
    [at_button setImage:[personal getImageWithName:@"write_blog_at@2x"] forState:UIControlStateNormal];
    [weibo_view addSubview:at_button];
    
    
    
    UIButton * face_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    face_button.tag = 9999;
    
    face_button.frame = CGRectMake(141-4.5,11.5,43/2,43/2);
    
    [face_button addTarget:self action:@selector(face:) forControlEvents:UIControlEventTouchUpInside];
    
    [face_button setImage:[personal getImageWithName:@"smile_write@2x"] forState:UIControlStateNormal];
    
    [weibo_view addSubview:face_button];
    
    
    UIImageView * zhuanfaMark = [[UIImageView alloc] initWithFrame:CGRectMake(10,5,35/2,35/2)];
    
    zhuanfaMark.image = [UIImage imageNamed:@"writeblog_kunag.png"];
    
    zhuanfaMark.userInteractionEnabled = YES;
    
    zhuanfaMark.center = CGPointMake(20,15);
    
    zhuanfaMark.backgroundColor = [UIColor clearColor];
    
    [face_view addSubview:zhuanfaMark];
    
    UITapGestureRecognizer * zhuanfa_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChooseMark:)];
    [zhuanfaMark addGestureRecognizer:zhuanfa_tap];
    
    
    mark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"writeblog_mark_image.png"]];
    mark.center = CGPointMake(zhuanfaMark.bounds.size.width/2,zhuanfaMark.bounds.size.height/2);
    mark.hidden = !isZhuanFa;
    [zhuanfaMark addSubview:mark];
    
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40,0,200,26)];
    
    label.text = [NSString stringWithFormat:@"同时评论给%@",username];
    
    label.font = [UIFont systemFontOfSize:15];
    
    label.textColor = RGBCOLOR(93,100,108);
    
    label.textAlignment = NSTextAlignmentLeft;
    
    label.backgroundColor = [UIColor clearColor];
    
    [face_view addSubview:label];
    
    
    scrollView = [[WeiBoFaceScrollView alloc] initWithFrame:CGRectMake(0,(iPhone5?(568-215):(480-215))-(MY_MACRO_NAME?0:20),320,215) target:self];
    scrollView.hidden = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(320*3,0);
    //    [self.view addSubview:scrollView];
    
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
    pageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0,0,320,25)];
    
    //    pageControl.center = CGPointMake(160,(iPhone5?568-20:480-20) - (IOS_VERSION >=7.0?0:20));
    
    pageControl.center = CGPointMake(160,215-20);
    
    pageControl.numberOfPages = 3;
    
    pageControl.currentPage = 0;
    
    [scrollView addSubview:pageControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    pageControl.center = CGPointMake(160+scrollView1.contentOffset.x,215-20);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    //获取当前页码
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    //设置当前页码
    pageControl.currentPage = index;
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0,(iPhone5?568:480)-(IOS_VERSION >= 7.0?0:20)-_keyboardRect.size.height-(myTextView.inputView==scrollView?72:73),320,73);
        
        myTextView.frame = CGRectMake(myTextView.frame.origin.x,IOS_VERSION>=7.0?64:44,myTextView.frame.size.width,(iPhone5?568-20-73-44-_keyboardRect.size.height:480-20-73-44-_keyboardRect.size.height)-(MY_MACRO_NAME?0:20));
    }];
    
}

-(void)huati:(UIButton *)sender
{
    
    if (myTextView.tag == 100)
    {
        myTextView.text = @"";
        myTextView.textColor = [UIColor blackColor];
        myTextView.tag = 101;
    }
    
    
    if (remainTextNum < 0)
    {
        return;
    }
    // 获得光标所在的位置
    int location = myTextView.selectedRange.location;
    // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
    NSString *content = myTextView.text;
    NSString *result = [NSString stringWithFormat:@"%@#插入新话题#%@",[content substringToIndex:location],[content substringFromIndex:location]];
    // 将调整后的字符串添加到UITextView上面
    myTextView.text = result;
    myTextView.selectedRange = NSMakeRange(location+6, 0);
    
    
    NSString  * nsTextContent=myTextView.text;
    int   existTextNum=[nsTextContent length];
    remainTextNum= 140-existTextNum;
    //    wordsNumber_label.text = [NSString stringWithFormat:@"%i",remainTextNum];
    
    [wordsNumber_button setTitle:[NSString stringWithFormat:@"%i",remainTextNum] forState:UIControlStateNormal];
}

-(void)at:(UIButton *)button
{
    //@某人
    FriendListViewController * list = [[FriendListViewController alloc] init];
    list.delegate = self;
    UINavigationController * list_nav = [[UINavigationController alloc] initWithRootViewController:list];


    [self presentViewController:list_nav animated:YES completion:NULL];
}



//文字太多提示

-(void)warningMessage
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"内容不能超过140个字"];
    [hud setActivity:NO];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [self performSelector:@selector(hidehudindelegate) withObject:nil afterDelay:1];
}
-(void)hidehudindelegate{
    
    
    
    
    [hud removeFromParentViewController];
    hud=nil;
}
//正在发送

-(void)updateLoading
{
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    //    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:@"正在发送"];
    [hud setActivity:YES];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
}

-(void)fasong:(UIButton *)sender
{
    //URL_FORWARD @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=addforward&content=%@&tid=%@&forwardtid=%@&type=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"
    
    
    if (myTextView.text.length > 140)
    {
        [self warningMessage];
        return;
    }
    if ((myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])||myTextView.text == nil||[myTextView.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NS_TISHI message:NS_TISHI_KONG
                                                       delegate:self cancelButtonTitle:NS_KNOWED otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    
    [self updateLoading];
    
    backView.frame = CGRectMake(0,(iPhone5?568:480)-(IOS_VERSION >= 7.0?0:20)-72,320,73);
    [myTextView resignFirstResponder];
    pageControl.hidden = YES;
    
    
    
    
    NSString * _forwardId = self.info.rtid;
    if (![_forwardId isEqual:[NSNull null]]&&![_forwardId isEqualToString:@"(null)"]) {
        
    }else
    {
        _forwardId = self.info.tid;
    }
    
    
    NSString * fullUrl = [NSString stringWithFormat:URL_FORWARD,[myTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.info.tid,_forwardId,isZhuanFa?@"both":@"forward",AUTHKEY];
    
    NSLog(@"评论 请求的url ==  %@",fullUrl);
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setFailedBlock:^{
        NSLog(@"_request.error = %@",request.error);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送失败,请重试" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
    }];
    
    
    [_requset setCompletionBlock:^{
        
        
        @try {
            [hud hide];
            
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            NSString * string = [dic objectForKey:@"errcode"];
            
            
            NSLog(@"转发结果----%@",dic);
            
            if ([string isEqualToString:@"0"])
            {
                if (delegate && [delegate respondsToSelector:@selector(ForwardingSuccessWihtTid:IndexPath:SelectView: WithComment:)])
                {
                    [delegate ForwardingSuccessWihtTid:self.info.tid IndexPath:self.theIndexPath SelectView:self.theSelectViewIndex WithComment:isZhuanFa];
                }
                
                [self dismissModalViewControllerAnimated:YES];
            }else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送失败,请重试" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
        
    }];
    
    [_requset setFailedBlock:^{
        [hud hide];
        
        
        
        [self saveWeiBo];
        
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络不稳定,已保存到草稿箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        alertView.delegate = self;
        [alertView show];
        
    }];
    
    
    [_requset startAsynchronous];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [hud hide];
}

-(void)ChooseMark:(UITapGestureRecognizer *)sender
{
    isZhuanFa = !isZhuanFa;
    mark.hidden = !isZhuanFa;
}

-(void)doTap:(UIButton *)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除文字" otherButtonTitles:nil, nil];
    actionSheet.tag = 100000-1;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1000000)
    {
        if (buttonIndex == 0)
        {
            [self saveWeiBo];
            
            [self dismissModalViewControllerAnimated:YES];
            
        }else if(buttonIndex ==1)
        {
            [self dismissModalViewControllerAnimated:YES];
        }
    }else
    {
        if (buttonIndex == 0)
        {
            myTextView.text = @"";
            //        wordsNumber_label.text = @"140";
            [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
        }
    }
}




-(void)saveWeiBo
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    NSLog(@"morelocationString=%@",morelocationString);
    
    
    
    if (theText.length != 0)
    {
        [DraftDatabase deleteStudentBythecontent:theText];
    }
    
    
    NSMutableArray * arry = [DraftDatabase findallbytheContent:myTextView.text];
    
    if (arry.count!=0)
    {
        [DraftDatabase deleteStudentBythecontent:myTextView.text];
    }
    
    
    
    
    [DraftDatabase addtype:@"微博转发" content:myTextView.text date:morelocationString username:[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] fabiaogid:self.info.rtid huifubbsid:self.info.totid weiboid:self.info.tid thehuifubbsfid:self.info.content thetitle:isZhuanFa?@"1":@"0" columns:@"微博" image:username];
}



-(void)face:(UIButton *)button
{
    isFace = !isFace;
    [button setImage:[personal getImageWithName:isFace?@"write_blog_key@2x":@"smile_write@2x"] forState:UIControlStateNormal];
    scrollView.hidden = !isFace;
    
    if (isFace)
    {
        //弹出表情
        pageControl.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            backView.frame = CGRectMake(0,(iPhone5?568:480)-(IOS_VERSION >= 7.0?0:20)-72-215,320,73);
            myTextView.frame = CGRectMake(myTextView.frame.origin.x,IOS_VERSION>=7.0?64:44,myTextView.frame.size.width,(iPhone5?568-20-73-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
            [myTextView resignFirstResponder];
        }];
        myTextView.inputView = scrollView;
    }else
    {
        [myTextView resignFirstResponder];
        
        myTextView.inputView = nil;
        //弹出键盘
    }
    
    [myTextView becomeFirstResponder];
}

#pragma mark-expressionDelegate

-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    
    if (myTextView.tag == 100)
    {
        myTextView.text = @"";
        myTextView.textColor = [UIColor blackColor];
        myTextView.tag = 101;
    }
    
    NSRange range = myTextView.selectedRange;
    
    NSMutableString * temp_text = [NSMutableString stringWithString:myTextView.text];
    
    [temp_text insertString:name atIndex:range.location];
    
    myTextView.text = temp_text;
    
    myTextView.selectedRange = NSMakeRange(range.location+name.length,range.length);
}

#pragma mark-FriendListDelegate

-(void)atSomeBodys:(NSString *)string
{
    
    if (isFace)
    {
        pageControl.hidden = NO;
        //弹出表情
        [UIView animateWithDuration:0.3 animations:^{
            backView.frame = CGRectMake(0,(iPhone5?568:480)-(IOS_VERSION >= 7.0?0:20)-72-215,320,73);
            myTextView.frame = CGRectMake(myTextView.frame.origin.x,IOS_VERSION>=7.0?64:44,myTextView.frame.size.width,(iPhone5?568-20-73-44-215:480-20-73-44-215)-(MY_MACRO_NAME?0:20));
            [myTextView resignFirstResponder];
        }];
    }else
    {
        //弹出键盘
        [myTextView becomeFirstResponder];
    }
    
    
    if (string.length == 0 || [string isEqualToString:@""])
    {
        return;
    }
    
    if (myTextView.tag == 100)
    {
        myTextView.text = @"";
        myTextView.textColor = [UIColor blackColor];
        myTextView.tag = 101;
    }
    
    
    myTextView.text = [myTextView.text stringByAppendingFormat:@" @%@",string];
}


///////////////UITextViewDelegate////////////////////

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //    UIButton * button = (UIButton *)[self.view viewWithTag:9999];
    //    isFace = NO;
    //    [button setImage:[personal getImageWithName:isFace?@"write_blog_key@2x":@"smile_write@2x"] forState:UIControlStateNormal];
    
    return YES;
}

//内容框字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    //    if (textView.tag == 100)
    //    {
    //        textView.text = @"";
    //        textView.textColor = [UIColor blackColor];
    //    }
    
    
    
    if (textView.tag == 100)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 101;
    }
    
    
    if (range.location>=140)
    {
        return  NO;
    }else{
        return YES;
    }
}
//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == 100 && [textView.text isEqualToString:@"分享新鲜事......"])
    {
        textView.tag = 101;
        textView.text = @"";
    }
    
    if (textView.text.length == 0)
    {
        textView.text = @"分享新鲜事......";
        textView.textColor = RGBCOLOR(146,146,146);
        textView.tag = 100;
    }
    
    
    
    NSString  * nsTextContent=textView.text;
    int   existTextNum=[nsTextContent length];
    remainTextNum=140-existTextNum;
    //    wordsNumber_label.text = [NSString stringWithFormat:@"%i",remainTextNum];
    [wordsNumber_button setTitle:[NSString stringWithFormat:@"%i",remainTextNum] forState:UIControlStateNormal];
    
    
    if ([textView.text isEqualToString:@"分享新鲜事......"])
    {
        [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
        textView.selectedRange =  NSMakeRange(0, 0);
    }
}


-(void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"分享新鲜事......"]&&textView.selectedRange.location != 0&&textView.tag == 100)
    {
        [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
        textView.selectedRange =  NSMakeRange(0, 0);
    }
}

-(void)clickMyTextView
{
    isFace = YES;
    
    UIButton * button = (UIButton *)[self.view viewWithTag:9999];
    
    [self face:button];
}

-(void)backH
{
    [myTextView resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0,(iPhone5?568:480)-(IOS_VERSION >= 7.0?0:20)-73,320,73);
        
        myTextView.frame = CGRectMake(myTextView.frame.origin.x,IOS_VERSION>=7.0?64:44,myTextView.frame.size.width,(iPhone5?568-20-73-44:480-20-73-44)-(MY_MACRO_NAME?0:20));
    }];
    
    
    
    
    if ((myTextView.tag == 100 && [myTextView.text isEqualToString:@"分享新鲜事......"])||[theText isEqualToString:myTextView.text])
    {
        [self dismissModalViewControllerAnimated:YES];
    }else
    {
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存草稿",@"不保存",nil];
        
        sheet.delegate = self;
        
        sheet.tag = 1000000;
        
        [sheet showInView:self.view];
        
    }
    //    [self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
