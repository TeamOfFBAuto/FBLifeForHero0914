//
//  fbWebViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-20.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "fbWebViewController.h"

#import "newsdetailViewController.h"
#import "commentViewController.h"
#import "JSONKit.h"
#import "personal.h"
#import "ASIHTTPRequest.h"
#import "loadingview.h"
#import "DefaultConstant.h"
#import "LogInViewController.h"
#import "fbWebViewController.h"
#import "NewMineViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"
#import "WriteBlogViewController.h"
#import "SSWBViewController.h"
@interface fbWebViewController (){

    ShareView *_shareView;
    UILabel   *titleLabel;

}

@end

@implementation fbWebViewController
@synthesize urlstring;


-(void)downloadtoolError{
}


-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{

}
-(void)NoticeFrameHigh{
}
-(void)NoticeFrameLow{
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO ];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault ];

    
    
    
    [MobClick beginEvent:@"fbWebViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"fbWebViewController"];
}

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    self.navigationController.navigationBarHidden=NO;

    [super viewDidLoad];
    
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,44)];
    topView.backgroundColor = [UIColor clearColor];
    //    //导航栏上的label
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_MACRO_NAME? 20:0, 0, 180, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font= [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.text=@"xx";
    titleLabel.tag=200;
    
    [topView addSubview:titleLabel];
    
    self.navigationItem.titleView = topView;

    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME? -3:5, 0, 12, 43/2)];
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIButton *leftview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 43/2)];
////    leftview.backgroundColor=[UIColor redColor];
//    [leftview addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [leftview addSubview:button_back];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:leftview];
//    self.navigationItem.leftBarButtonItem=back_item;
//
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:IOS_VERSION>=7?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]: [UIImage imageNamed:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    
    button_comment=[[UIButton alloc]initWithFrame:CGRectMake(23, 0, 44, 44)];
    
    button_comment.backgroundColor=[UIColor clearColor];
    
    
    button_comment.tag=26;
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
//    [button_comment setBackgroundImage:[UIImage imageNamed:@"ios_zhuanfa44_37.png"] forState:UIControlStateNormal];
    
    [button_comment setImage:[UIImage imageNamed:@"ios_zhuanfa44_37.png"] forState:UIControlStateNormal];
    
    [button_comment setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];

    button_comment.userInteractionEnabled=NO;
    
    
    UIButton *buttonright=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [buttonright addSubview:button_comment];
    [buttonright addTarget:self action:@selector(ShareMore) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:buttonright];
    
    self.navigationItem.rightBarButtonItem=comment_item;

    
  
    // self.urlstring=@"http://cmsweb.fblife.com/waptopicmlxytzs/newslist.html";
    NSURL *url =[NSURL URLWithString:self.urlstring];
//    NSURL *url =[NSURL URLWithString:@"http://www.baidu.com"];

    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    awebview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64-40:480-64-40)];
    awebview.delegate=self;
    [awebview loadRequest:request];
    awebview.scalesPageToFit = YES;
    [self.view addSubview:awebview];;
    
    UIView *toolview=[[UIView alloc]initWithFrame:CGRectMake(0, iPhone5?568-40-64:480-64-40, 320, 40)];
   // toolview.backgroundColor=[UIColor redColor];
    toolview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios7_webviewbar.png"]];
    [self.view addSubview:toolview];
    
    
    NSArray *array_imgname=[NSArray arrayWithObjects:@"ios7_goback4032.png",@"ios7_goahead4032.png",@"ios7_refresh4139.png", nil];
    for (int i=0; i<3; i++) {
        UIImage *img=[UIImage imageNamed:[array_imgname objectAtIndex:i]];
        
        UIButton *tool_Button=[[UIButton alloc]initWithFrame:CGRectMake(5+i*70, 5, img.size.width, img.size.height)];
        tool_Button.center=CGPointMake(22+i*i*68.5, 20);
        
        tool_Button.tag=99+i;
        [tool_Button setBackgroundImage:[UIImage imageNamed:[array_imgname objectAtIndex:i]] forState:UIControlStateNormal];
        
        [tool_Button addTarget:self action:@selector(dobuttontool:) forControlEvents:UIControlEventTouchUpInside];
        [toolview addSubview:tool_Button];
        
    }
    
    
//    [awebview goBack];
//    - (void)reload;
//    - (void)stopLoading;
//    
//    - (void)goBack;
//    - (void)goForward;
    
}


-(void)dobuttontool:(UIButton *)sender{
    switch (sender.tag) {
        case 99:
            [awebview goBack];
            break;
        case 100:
            [awebview goForward];
            break;
        case 101:
            [awebview reload];
            break;

            
        default:
            break;
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    string_title=[NSString stringWithFormat:@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    NSLog(@"wca==%@",string_title);
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    string_title=[NSString stringWithFormat:@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];

//    string_title=@"中国人民";
    
//    UILabel *labe_t=(UILabel *)[self.view viewWithTag:200];
    
    if (string_title.length>12) {
        
        
        string_title=[string_title substringToIndex:12];
    }
    
    
    titleLabel.text= string_title;
    
    NSLog(@"wca==%@",string_title);

    
    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:16],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;

    button_comment.userInteractionEnabled=YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}

-(void)backto{
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark-进入分享


-(void)ShareMore{
    
    
    
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
    if(buttonIndex==0){
        NSLog(@"跳到FB微博");
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
            
            writeBlogView.theText = [NSString stringWithFormat:@"分享新闻:“%@”,链接:%@",string_title,self.urlstring] ;
            
            NSMutableArray *array_shareimg=[[NSMutableArray alloc]init];
            // [array_shareimg addObject:[UIImage imageNamed:@"Icon@2x.png"]];
            NSMutableArray *array_none=[[NSMutableArray alloc]init];
            [array_none addObject:@"safjakf"];
            writeBlogView.allImageArray1=array_shareimg;
            writeBlogView.allAssesters1=array_none;
            
            [self presentModalViewController:writeBlogView animated:YES];
            
        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex==2){
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            NSLog(@"????share==%@",[UIImage imageNamed:@"Icon@2x.png"]);
            
            [message setThumbImage:[self scaleToSize:[UIImage imageNamed:@"Icon@2x.png"] size:CGSizeMake([UIImage imageNamed:@"Icon@2x.png"].size.width/5, [UIImage imageNamed:@"Icon@2x.png"].size.height/5)] ];
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = self.urlstring;
            ext.webpageUrl=self.urlstring;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneTimeline;
            
            [WXApi sendReq:req];
        }
        
        else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
            [alView show];
            
        }
        
        
        
        NSLog(@"分享到微信朋友圈");
        
        
    }
    
    else if(buttonIndex==4){
        
        
        NSString *string_bodyofemail=[NSString stringWithFormat:@"%@ \n %@ \n\n下载越野e族客户端 http://mobile.fblife.com/download.php",string_title,self.urlstring] ;
        [self okokokokokokowithstring:string_bodyofemail];
        
    }else if(buttonIndex==1){
        NSLog(@"分享给微信好友");
        
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description =string_title;
            
            //  [message setThumbImage:[self scaleToSize:[UIImage imageNamed:@"Icon@2x.png"] size:CGSizeMake([UIImage imageNamed:@"Icon@2x.png"].size.width/5, [UIImage imageNamed:@"Icon@2x.png"].size.height/5)] ];
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = self.urlstring;
            ext.webpageUrl=self.urlstring;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"下载微信", nil];
            [alView show];
            
        }
    }
    else if ( buttonIndex==3){
        
        NSLog(@"到新浪微博界面的");
        
        WBWebpageObject *pageObject = [ WBWebpageObject object ];
        pageObject.objectID =@"nimeideid";
        pageObject.thumbnailData =UIImageJPEGRepresentation([self scaleToSize:[UIImage imageNamed:@"Icon@2x.png"] size:CGSizeMake([UIImage imageNamed:@"Icon@2x.png"].size.width/5, [UIImage imageNamed:@"Icon@2x.png"].size.height/5)], 1);
        pageObject.title = @"分享自越野e族客户端";
        pageObject.description = string_title;
        pageObject.webpageUrl = self.urlstring;
        WBMessageObject *message = [ [ WBMessageObject alloc ] init ];
        message.text =[NSString stringWithFormat:@"%@（分享自@越野e族）",string_title] ;
        
        message.mediaObject = pageObject;
        WBSendMessageToWeiboRequest *req = [ [  WBSendMessageToWeiboRequest alloc ] init  ];
        req.message = message;
        [ WeiboSDK sendRequest:req ];
        
        
    }
    
    
}



//-(void)ShareMore{
//    
//    my_array =[[NSMutableArray alloc]init];
//    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"  " delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    
//    
//    
//    
//    editActionSheet.actionSheetStyle = UIActivityIndicatorViewStyleGray;
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
//        
//        if ([snsName isEqualToString:@"facebook"]||[snsName isEqualToString:@"twitter"]||[snsName isEqualToString:@"renren"]||[snsName isEqualToString:@"qzone"]||[snsName isEqualToString:@"douban"]||[snsName isEqualToString:@"tencent"]||[snsName isEqualToString:@"sms"]||[snsName isEqualToString:@"wxtimeline"]||[snsName isEqualToString:@"wechat"]||[snsName isEqualToString:@"email"]) {
//        }else{
//            [my_array addObject:snsName];
//            //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
//            
//            if ([snsName isEqualToString:@"sina"]) {
//                [editActionSheet addButtonWithTitle:@"分享到新浪微博"];
//                
//            }
//            
//            
//            
//            
//            
//        }
//        
//        
//    }
// 
//    [editActionSheet addButtonWithTitle:@"分享朋友到邮箱"];
//    
//    
//    [editActionSheet addButtonWithTitle:@"取消"];
//    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
//    // [editActionSheet showFromTabBar:self.tabBarController.tabBar];
//    [editActionSheet showFromRect:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) inView:self.view animated:YES];
//    editActionSheet.delegate = self;
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
//}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }else if(buttonIndex==0){
        NSLog(@"跳到FB微博");
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
        {
            WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
            
            writeBlogView.theText = [NSString stringWithFormat:@"分享新闻:“%@”,链接:%@",string_title,self.urlstring] ;
            
            NSMutableArray *array_shareimg=[[NSMutableArray alloc]init];
           // [array_shareimg addObject:[UIImage imageNamed:@"Icon@2x.png"]];
            NSMutableArray *array_none=[[NSMutableArray alloc]init];
            [array_none addObject:@"safjakf"];
            writeBlogView.allImageArray1=array_shareimg;
            writeBlogView.allAssesters1=array_none;
            
            [self presentModalViewController:writeBlogView animated:YES];
            
        }
        else{
            //没有激活fb，弹出激活提示
            LogInViewController *login=[LogInViewController sharedManager];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        
    }else if(buttonIndex==1){
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description = string_title;
            NSLog(@"????share==%@",[UIImage imageNamed:@"Icon@2x.png"]);
            
            [message setThumbImage:[self scaleToSize:[UIImage imageNamed:@"Icon@2x.png"] size:CGSizeMake([UIImage imageNamed:@"Icon@2x.png"].size.width/5, [UIImage imageNamed:@"Icon@2x.png"].size.height/5)] ];
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = self.urlstring;
            ext.webpageUrl=self.urlstring;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneTimeline;
            
            [WXApi sendReq:req];
        }
        
        else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
            [alView show];
            
        }
        
        
        
        NSLog(@"分享到微信朋友圈");

        
    }
    
    else if(buttonIndex==4){
        
        
        NSString *string_bodyofemail=[NSString stringWithFormat:@"%@ \n %@ \n\n下载越野e族客户端 http://mobile.fblife.com/download.php",string_title,self.urlstring] ;
        [self okokokokokokowithstring:string_bodyofemail];
        
    }else if(buttonIndex==2){
        NSLog(@"分享给微信好友");
        
        
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = string_title;
            message.description =string_title;
            
          //  [message setThumbImage:[self scaleToSize:[UIImage imageNamed:@"Icon@2x.png"] size:CGSizeMake([UIImage imageNamed:@"Icon@2x.png"].size.width/5, [UIImage imageNamed:@"Icon@2x.png"].size.height/5)] ];
            WXWebpageObject *ext = [WXWebpageObject object];
            //ext.imageData = self.urlstring;
            ext.webpageUrl=self.urlstring;
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            req.message = message;
            req.scene=WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"下载微信", nil];
            [alView show];
            
        }
    }
    else if ( buttonIndex==3){
        
        NSLog(@"到新浪微博界面的");
        
        WBWebpageObject *pageObject = [ WBWebpageObject object ];
        pageObject.objectID =@"nimeideid";
        pageObject.thumbnailData =UIImageJPEGRepresentation([self scaleToSize:[UIImage imageNamed:@"Icon@2x.png"] size:CGSizeMake([UIImage imageNamed:@"Icon@2x.png"].size.width/5, [UIImage imageNamed:@"Icon@2x.png"].size.height/5)], 1);
        pageObject.title = @"分享自越野e族客户端";
        pageObject.description = string_title;
        pageObject.webpageUrl = self.urlstring;
        WBMessageObject *message = [ [ WBMessageObject alloc ] init ];
        message.text =[NSString stringWithFormat:@"%@（分享自@越野e族）",string_title] ;
        
        message.mediaObject = pageObject;
        WBSendMessageToWeiboRequest *req = [ [  WBSendMessageToWeiboRequest alloc ] init  ];
        req.message = message;
        [ WeiboSDK sendRequest:req ];

        
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
    
    [self  dismissModalViewControllerAnimated:YES];
    
    
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
- (void) sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body
{
    NSString* str = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@",
                     to, cc, subject, body];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
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





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
