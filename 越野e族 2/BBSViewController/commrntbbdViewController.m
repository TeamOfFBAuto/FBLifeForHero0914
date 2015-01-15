//
//  commrntbbdViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-19.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "commrntbbdViewController.h"
#import "DraftBoxViewController.h"
#import "QBImagePickerController.h"



@interface commrntbbdViewController (){
    UIButton *button_send;
    NSData* _data;
    QBImagePickerController * imagePickerController;
    
    NSMutableArray * allAssesters;
    
    NSMutableArray * allImageArray;
    
    UIView * morePicView;
    
    UIImageView * morePicImageView;
    
    BOOL image_quality;
    UINavigationBar *nav;
    
    CGFloat _keyboard_y;//记录键盘y
    
    
}

@end

@implementation commrntbbdViewController
@synthesize title_string,string_tid=_string_tid,string_pid,string_fid=_string_fid,string_content,string_subject,string_floor,string_distinguish;
@synthesize allImageUrl;
@synthesize myAllimgUrl;

@synthesize allAssesters1;
@synthesize allImageArray1;


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
    [MobClick beginEvent:@"commrntbbdViewController"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"commrntbbdViewController"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    allImageArray = [[NSMutableArray alloc] init];
    
    allAssesters = [[NSMutableArray alloc] init];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    ///////////////////////////////////
    //[self kaitongfb];
    
    isup=NO;
    keyboardandface=1;
    
    
    //创建navigationbar
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //创建navbar
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,aScreenRect.size.width,IOS_VERSION>=7.0?64:44)];
    //创建navbaritem
    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@""];
    
    nav.barStyle = UIBarStyleBlackOpaque;
    
    [nav pushNavigationItem:NavTitle animated:YES];
    
    [self.view addSubview:nav];
    
    
    UIBarButtonItem * space_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_button.width = MY_MACRO_NAME?-13:5;
    
    
    
//    //创建barbutton 创建系统样式的
//    button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,IOS_VERSION>=7.0?0:8,12,21.5)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
    
    //创建barbutton 创建系统样式的
    button_back=[[UIButton alloc]initWithFrame:CGRectMake(0,0,30,44)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    [button_back setImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];

//    button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,31/2,32/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    NavTitle.leftBarButtonItems=@[space_button,back_item];
    
    UIButton * send_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    send_button.frame = CGRectMake(0,0,40,44);
    
    send_button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [send_button setTitle:@"发表" forState:UIControlStateNormal];
    [send_button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [send_button setTitleColor:RGBCOLOR(89,89,89) forState:UIControlStateNormal];
    
    [send_button addTarget:self action:@selector(imagesend) forControlEvents:UIControlEventTouchUpInside];
    
    NavTitle.rightBarButtonItems = @[space_button,[[UIBarButtonItem alloc] initWithCustomView:send_button]];
    //设置barbutton
    [nav setItems:[NSArray arrayWithObject:NavTitle]];
    
    
    if([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,30)];
    
    title_label.text = self.title_string;
    
    title_label.backgroundColor = [UIColor clearColor];
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.font=TITLEFONT;
    title_label.textAlignment = NSTextAlignmentCenter;
    
    NavTitle.titleView = title_label;
    
    
    UIView *back_zhutiview=[[UIView alloc]initWithFrame:CGRectMake(0, MY_MACRO_NAME?64:44, DEVICE_WIDTH, 38)];
    back_zhutiview.backgroundColor=RGBCOLOR(242, 242, 242);
    [self.view addSubview:back_zhutiview];
    
    
    //主题这两个字
    UILabel *zhutilabel=[[UILabel alloc]initWithFrame:CGRectMake(5,5, 55, 28)];
    zhutilabel.text=@"主题：";
    [back_zhutiview addSubview:zhutilabel];
    zhutilabel.textAlignment=NSTextAlignmentCenter;
    zhutilabel.backgroundColor=[UIColor clearColor];
    zhutilabel.font=[UIFont systemFontOfSize:18];
    
    //回复的帖子的主题
    subjectTextfield=[[UITextField alloc]initWithFrame:CGRectMake(MY_MACRO_NAME? 55:55,zhutilabel.frame.origin.y, DEVICE_WIDTH - 40, 28)];
    subjectTextfield.backgroundColor=[UIColor clearColor];
    subjectTextfield.delegate=self;
    [back_zhutiview addSubview:subjectTextfield];
    
    //中间的分割线
    //    UIImageView *image_blog_sp=[[UIImageView alloc]initWithFrame:CGRectMake(5,IOS_VERSION>=7?40+10+28+20: 40+10+28, 310, 2)];
    //    image_blog_sp.image=[UIImage imageNamed:@"blog_sp.png"];
    //    [self.view addSubview:image_blog_sp];
    //帖子回复的内容
    _contenttextview=[[UITextView alloc]initWithFrame:CGRectMake(0,IOS_VERSION>=7? 64+28+4:44+28+4, DEVICE_WIDTH, 205)];
    [_contenttextview setBackgroundColor:[UIColor clearColor]];
    _contenttextview.font=[UIFont systemFontOfSize:15];
    _contenttextview.delegate=self;
    NSLog(@"content==%@",self.string_content);
    if (self.string_content.length>0) {
        _contenttextview.text=self.string_content;
    }
    
    if (self.string_subject.length>0&&![self.string_subject isEqualToString:@"(null)"]) {
        subjectTextfield.text=self.string_subject;
    }else{
        subjectTextfield.text=@"";
        
    }
    
    [self.view addSubview:_contenttextview];
    if (IOS_VERSION>=7) {
        
        
        _keytop=[[keyboardtopview alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT - 275 +20, DEVICE_WIDTH, 40)];
        
    }else{
        _keytop=[[keyboardtopview alloc]initWithFrame:CGRectMake(0, iPhone5?205+88:205, DEVICE_WIDTH, 40)];
        
    }
    [_keytop FaceAndKeyBoard:1];
    _keytop.delegate=self;
    [self.view addSubview:_keytop];
    
    if ([self.string_distinguish isEqualToString:@"发帖"]) {
        
        subjectTextfield.placeholder=@"请输入帖子主题";
        [subjectTextfield becomeFirstResponder];
    }else if([self.string_distinguish isEqualToString:@"回贴"])
    {
        subjectTextfield.placeholder=@"请输入回复内容主题";
        [_contenttextview becomeFirstResponder];
    }else{
        [_contenttextview becomeFirstResponder];
        
        NSLog(@"回复某一层的主题");
    }
    
    //动态获取键盘高度
    
    //faceview隐藏的刚开始是
    faceScrollView = [[WeiBoFaceScrollView alloc] initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 160+55) target:self];
    //    faceScrollView.pagingEnabled = YES;
    // faceScrollView.contentSize = CGSizeMake(320*2, 160);
    [self.view addSubview:faceScrollView];
    faceScrollView.delegate=self;
    //pagecontrol
    pageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0,900,DEVICE_WIDTH,25)];
    
    pageControl.center = CGPointMake(DEVICE_WIDTH / 2.f,460-12.5);
    
    pageControl.numberOfPages = 3;
    
    pageControl.currentPage = 0;
    
//    [self.view addSubview:pageControl];//lcw
    
    
    
    morePicView = [[UIView alloc] initWithFrame:CGRectMake(0,DEVICE_HEIGHT-215+20,DEVICE_WIDTH,215)];
    
    morePicView.backgroundColor = [UIColor whiteColor];
    
    morePicView.hidden = YES;
    
    [self.view addSubview:morePicView];
    
    
    morePicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,135)];
    
    morePicImageView.userInteractionEnabled = YES;
    
    morePicImageView.backgroundColor = RGBCOLOR(241,241,241);
    
    [morePicView addSubview:morePicImageView];
    
    NSLog(@"self.myallimgurl====%@",myAllimgUrl);
    
    if (self.myAllimgUrl.count>0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self comeonmyimage];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"************************************************************************************************************************");
                
                
                
            });
        });
        
        
        
        
    }else{
        [self setbutton];
    }
    
    
    
    UILabel * highPic_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,150,200,44)];
    
    highPic_titleLabel.text = @"开启上传高清图片";
    
    highPic_titleLabel.backgroundColor = [UIColor clearColor];
    
    highPic_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    highPic_titleLabel.textColor = RGBCOLOR(43,43,43);
    
    [morePicView addSubview:highPic_titleLabel];
    
    
    UISwitch * highPicSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(DEVICE_WIDTH - 80,156,80,25)];
    
    highPicSwitch.on = YES;
    
    image_quality = YES;
    
    [highPicSwitch addTarget:self action:@selector(chooseImageQuality:) forControlEvents:UIControlEventValueChanged];
    
    [morePicView addSubview:highPicSwitch];
    
    
    
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //点击隐藏键盘按钮所触发的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
    // Do any additional setup after loading the view.
}


#pragma mark--多线程取图片

-(void)comeonmyimage{
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    for (int i = 0;i < self.myAllimgUrl.count;i++)
    {
        
        
        NSString *imgurl=[NSString stringWithFormat:@"%@",[self.myAllimgUrl objectAtIndex:i]];
        NSURL *referenceURL = [NSURL URLWithString:imgurl];
        
        __block UIImage *returnValue = nil;
        [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
         {
             
             
             
             //returnValue = [UIImage imageWithCGImage:[asset thumbnail]]; //Retain Added
             ALAssetRepresentation *assetRep = [asset defaultRepresentation];
             
             CGImageRef imgRef = [assetRep fullScreenImage];
             
             returnValue=[UIImage imageWithCGImage:imgRef
                                             scale:assetRep.scale
                                       orientation:(UIImageOrientation)assetRep.orientation];
             [allImageArray addObject:returnValue];
             [allAssesters addObject:imgurl];
             
             NSLog(@"alllimagearray====%@",allImageArray);
             if (allImageArray.count==self.myAllimgUrl.count) {
                 [self setbutton];
             }
             
             
         } failureBlock:^(NSError *error) {
             // error handling
         }];
    }
}



-(void)setbutton{
    for (int i = 0;i < 2;i++)
    {
        for (int j = 0;j < 5;j++)
        {
            UIButton * imageV = [UIButton buttonWithType:UIButtonTypeCustom];
            imageV.frame = CGRectMake(5 + ((DEVICE_WIDTH-10-59*5)/4+59)*j,7+62.75*i,59,59);
            imageV.imageView.clipsToBounds = YES;
            imageV.imageView.contentMode = UIViewContentModeScaleAspectFill;
            if (i == 0 && j == 0)
            {
                [imageV setImage:[UIImage imageNamed:@"write_blog_add_more.png"] forState:UIControlStateNormal];
                [imageV addTarget:self action:@selector(addPicture:) forControlEvents:UIControlEventTouchUpInside];
            }else
            {//WriteBlog_face_image.png
                [imageV setImage:[UIImage imageNamed:@"write_blog_more.png"] forState:UIControlStateNormal];
                
                if (j+i*5-1 < allImageArray.count)
                {
                    [imageV setImage:[allImageArray objectAtIndex:j+i*5-1]  forState:UIControlStateNormal];
                }
                
                [imageV addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            imageV.tag = j+i*5+100;
            NSLog(@"buttontag====%d",imageV.tag);
            [morePicImageView addSubview:imageV];
        }
    }
    
    
}

-(void)chooseImageQuality:(UISwitch *)swith
{
    image_quality = swith.on;
}




-(void)backto{
    //    [_tool stop];
    //    _tool.delegate=nil;
    //    request__.delegate=nil;
    
    
    faceScrollView.hidden = YES;
    
    morePicImageView.hidden = YES;
    
    if (![_contenttextview.text isEqualToString:@""] || ![subjectTextfield.text isEqualToString:@""] || allImageArray.count != 0 || [_contenttextview.text isEqualToString:string_content] || [subjectTextfield.text isEqualToString:string_subject])
    {
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存草稿",@"不保存",nil];
        
        [sheet showInView:self.view];
        
    }else
    {
        
        [self dismissModalViewControllerAnimated:YES];
        
        
    }
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString * morelocationString=[dateformatter stringFromDate:senddate];
        NSLog(@"morelocationString=%@",morelocationString);
        
        
        
        if (string_content.length != 0)
        {
            [DraftDatabase deleteStudentBythecontent:string_content];
        }
        
        
        NSMutableArray * arry = [DraftDatabase findallbytheContent:_contenttextview.text];
        
        if (arry.count!=0)
        {
            [DraftDatabase deleteStudentBythecontent:_contenttextview.text];
        }
        
        
        
        if ([self.string_distinguish isEqualToString:@"发帖"])
        {
            int fatie=    [DraftDatabase addtype:self.string_distinguish content:_contenttextview.text date:morelocationString username:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]] fabiaogid:self.string_fid huifubbsid:@"" weiboid:@"" thehuifubbsfid:@"" thetitle:[NSString stringWithFormat:@"%@",subjectTextfield.text] columns:@"论坛" image:allImageUrl];
            
            NSLog(@"fatie===%d",fatie);
        }else  if ([self.string_distinguish isEqualToString:@"回帖"])
        {
            int huitie=   [DraftDatabase addtype:self.string_distinguish content:_contenttextview.text date:morelocationString username:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]] fabiaogid:@"" huifubbsid:self.string_tid weiboid:@"" thehuifubbsfid:[NSString stringWithFormat:@"%@",self.string_fid] thetitle:[NSString stringWithFormat:@"%@",subjectTextfield.text] columns:@"论坛" image:allImageUrl];
            NSLog(@"fatie===%d",huitie);
            
        }else{
            //fabiaogid=floor,weiboid=pid
            
            int huizhuti=   [DraftDatabase addtype:self.string_distinguish content:_contenttextview.text date:morelocationString username:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]] fabiaogid:[NSString stringWithFormat:@"%@",self.string_floor] huifubbsid:self.string_tid weiboid:[NSString stringWithFormat:@"%@",self.string_pid] thehuifubbsfid:[NSString stringWithFormat:@"%@",self.string_fid] thetitle:[NSString stringWithFormat:@"%@",subjectTextfield.text] columns:@"论坛" image:allImageUrl];
            NSLog(@"fatie===%d",huizhuti);
            
        }
        [self dismissModalViewControllerAnimated:YES];
        
    }else if(buttonIndex == 1)
    {
        //[_tool stop];
        //        _tool.delegate=nil;
        //        request__.delegate=nil;
        
        [self dismissModalViewControllerAnimated:YES];
    }
}



#pragma mark-发帖子
-(void)sendcomment
{
    _tool=[[downloadtool alloc]init];
    
    if ([self.string_distinguish isEqualToString:@"发帖"])
    {
        
        if (subjectTextfield.text.length==0)
        {
            UIAlertView *alertview_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"帖子标题不能为空" delegate:nil cancelButtonTitle:@"请输入标题" otherButtonTitles:nil, nil];
            [alertview_ show];
        }else
        {
            //             [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs2.fblife.com/bbsapinew/postthread.php?fid=%@&&subject=%@&message=%@%@&formattype=json&authcode=%@&aid=%@",self.string_fid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],str_aid]];
            
            
            [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postthread.php?fid=%@&&subject=%@&message=%@%@&formattype=json&authcode=%@&aid=%@",self.string_fid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],str_aid]];
            
            NSLog(@"fullurl ---  %@",[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postthread.php?fid=%@&&subject=%@&message=%@%@&formattype=json&authcode=%@&aid=%@",self.string_fid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],str_aid]);
            
        }
    }else     if ([self.string_distinguish isEqualToString:@"回帖"])
        
    {
        //        [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs2.fblife.com/bbsapinew/postreply.php?fid=%@&tid=%@&subject=%@&message=%@%@&formattype=json&authcode=%@&aid=%@",self.string_fid,self.string_tid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],str_aid]];
        
        
        [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postreply.php?fid=%@&tid=%@&subject=%@&message=%@%@&formattype=json&authcode=%@&aid=%@",self.string_fid,self.string_tid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],str_aid]];
        
        NSLog(@"fullurl ---ds--  %@",[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postreply.php?fid=%@&tid=%@&subject=%@&message=%@%@&formattype=json&authcode=%@&aid=%@",self.string_fid,self.string_tid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],str_aid]);
    }else{
        NSLog(@"这个有图片的亲爱的，要发给某一楼");
        
        [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/quote.php?fid=%@&tid=%@&pid=%@&message=%@%@&number=%@&aid=%@&formattype=json&authcode=%@",self.string_fid,self.string_tid,self.string_pid,[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,self.string_floor,str_aid,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
        
        NSLog(@"完整的地址为：%@",[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/quote.php?fid=%@&tid=%@&pid=%@&message=%@%@&number=%@&aid=%@&formattype=json&authcode=%@",self.string_fid,self.string_tid,self.string_pid,[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str_img,self.string_floor,str_aid,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]);
        
    }
    
    
    [_tool start];
    //需要传的有fid,tid,biaoti,neirong,
    _tool.delegate=self;
    
}
-(void)sendcommentonly
{
    _tool=[[downloadtool alloc]init];
    NSLog(@"111sending...");
    
    if ([self.string_distinguish isEqualToString:@"发帖"])
    {
        if (subjectTextfield.text.length==0)
        {
            button_send.userInteractionEnabled=YES;
            button_back.userInteractionEnabled=YES;
            UIAlertView *alertview_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"帖子标题不能为空" delegate:nil cancelButtonTitle:@"请输入标题" otherButtonTitles:nil, nil];
            [alertview_ show];
        }else
        {    [self updateLoading];

            [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postthread.php?fid=%@&&subject=%@&message=%@&formattype=json&authcode=%@",self.string_fid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
        }
        
    }else if([self.string_distinguish isEqualToString:@"回帖"])
    {    [self updateLoading];

        [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postreply.php?fid=%@&tid=%@&subject=%@&message=%@&formattype=json&authcode=%@",self.string_fid,self.string_tid,[subjectTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
    }else{
        NSLog(@"回复某一楼层");
        [self updateLoading];

        [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/quote.php?fid=%@&tid=%@&pid=%@&message=%@&number=%@&formattype=json&authcode=%@",self.string_fid,self.string_tid,self.string_pid,[_contenttextview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.string_floor,[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
        
    }
    
    [_tool start];
    //需要传的有fid,tid,biaoti,neirong,
    _tool.delegate=self;
    [_contenttextview becomeFirstResponder];
    
}
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    
    @try {
        [hud hide];
        button_send.userInteractionEnabled=YES;
        NSDictionary *dic=[data objectFromJSONData];
        NSLog(@"fabudic==%@",dic);
        [subjectTextfield resignFirstResponder];
        [_contenttextview resignFirstResponder];
        
        if ([[dic objectForKey:@"errcode"] integerValue]==0)
        {
            NSLog(@"diccomment==%@",dic);
            [self dismissModalViewControllerAnimated:YES];
            //在发完消息后发出一个通知
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshmydata" object:self.string_content];
            
        }else
        {
            button_send.userInteractionEnabled=YES;
            button_back.userInteractionEnabled=YES;
            [hud hide];
            NSString *str=[NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsinfo"]];
            UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert_ show];
            [_contenttextview becomeFirstResponder];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
}
-(void)downloadtoolError{
    
    [self saveMydataAndhideHud];
}



-(void)saveMydataAndhideHud{
    
    
    [hud hide];
    
    [hud removeFromParentViewController];
    hud=nil;
    
    
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    NSLog(@"morelocationString=%@",morelocationString);
    
    
    if ([self.string_distinguish isEqualToString:@"发帖"])
    {
        int fatie=    [DraftDatabase addtype:self.string_distinguish content:_contenttextview.text date:morelocationString username:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]] fabiaogid:self.string_fid huifubbsid:@"" weiboid:@"" thehuifubbsfid:@"" thetitle:[NSString stringWithFormat:@"%@",subjectTextfield.text] columns:@"论坛" image:allImageUrl];
        
        NSLog(@"fatie===%d",fatie);
    }else if ([self.string_distinguish isEqualToString:@"回帖"])
    {
        int huitie=   [DraftDatabase addtype:self.string_distinguish content:_contenttextview.text date:morelocationString username:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]] fabiaogid:@"" huifubbsid:self.string_tid weiboid:@"" thehuifubbsfid:[NSString stringWithFormat:@"%@",self.string_fid] thetitle:[NSString stringWithFormat:@"%@",subjectTextfield.text] columns:@"论坛" image:allImageUrl];
        NSLog(@"fatie===%d",huitie);
        
    } else{
        //fabiaogid=floor,weiboid=pid
        int huizhuti=   [DraftDatabase addtype:self.string_distinguish content:_contenttextview.text date:morelocationString username:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]] fabiaogid:[NSString stringWithFormat:@"%@",self.string_floor] huifubbsid:self.string_tid weiboid:[NSString stringWithFormat:@"%@",self.string_pid] thehuifubbsfid:[NSString stringWithFormat:@"%@",self.string_fid] thetitle:[NSString stringWithFormat:@"%@",subjectTextfield.text] columns:@"论坛" image:allImageUrl];
        NSLog(@"huizhuti===%d",huizhuti);
        
    }
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不稳定，已保存到草稿箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    button_send.userInteractionEnabled=YES;
    button_back.userInteractionEnabled=YES;
    
}

#pragma mark-发送图片
-(void)sendimage{
    //ASIFormDataRequest
}

#pragma mark-keyviewdelegate
-(void)clickbutton:(UIButton *)sender{
    
    morePicView.hidden = YES;
    switch (sender.tag) {
        case 301:
            
//            morePicView.hidden = YES;
            
            isup=!isup;
            //刚开始的时候是NO，然后点击之后是yes,faceview show!
            if (isup==YES) {
                [_contenttextview resignFirstResponder];
                [subjectTextfield resignFirstResponder];
//                [_keytop WhenfaceviewFram];
                [_keytop FaceAndKeyBoard:2];//变换图片
                [self faceviewshow];//显示表情面板
                
                //更新 工具条frame
                
                _keytop.top = faceScrollView.top - _keytop.height;
                
            }else{
                [self faceviewhide];
                [_keytop FaceAndKeyBoard:1];
                if (isbiaoti==1) {
                    [subjectTextfield becomeFirstResponder];
                }else{
                    [_contenttextview becomeFirstResponder];
                }
//                [_keytop uping];
            }
            
            break;
        case 302:
            NSLog(@"点击的是拍照");
            [self takePhoto];
            
            break;
            
        case 303:
            NSLog(@"点击的是相册");
            
            [self faceviewhide];
            [self localPhoto];
            break;
            
        default:
            break;
    }
}


-(void)takePhoto
{
    
    if (allImageArray.count >=9)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最多上传9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController * pickerC = [[UIImagePickerController alloc] init];
        pickerC.delegate = self;
        pickerC.allowsEditing = NO;
        pickerC.sourceType = sourceType;
        [self presentViewController:pickerC animated:YES completion:nil];
    }
    else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

-(void)localPhoto
{
    
    morePicView.hidden = NO;
    
//    [_keytop uping];
    
    [_contenttextview resignFirstResponder];
    [subjectTextfield resignFirstResponder];
    //    if (allImageArray.count >=9)
    //    {
    //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最多上传9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    //        [alert show];
    //
    //        return;
    //    }
    
    //更新工具条 frame
    
    _keytop.top = morePicView.top - _keytop.height;
    
}

-(void)addPicture:(UIButton *)button
{
    
    if (allImageArray.count >=9)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最多上传9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    
    
    
    if (!imagePickerController)
    {
        imagePickerController = nil;
    }
    
    imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    
    imagePickerController.assters = allAssesters;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    
    
    navigationController.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    if([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}





-(void)removeimage
{
    currentImage=NULL;
    
}

//上传图片
#define TT_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf

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

#pragma mark-发送图片
-(void)imagesend
{
    button_send.userInteractionEnabled=NO;
    button_back.userInteractionEnabled=NO;
    [self localPhoto];
    NSLog(@"=======allImageArray=%@",allImageArray);
    
    if (allImageArray.count == 0) {
        [self sendcommentonly];
        NSLog(@"没有图.");
    }else{
        NSLog(@"有图.");
        
        NSLog(@"开始");
        
        //                NSString * string = [NSString stringWithFormat:@"http://bbs2.fblife.com/bbsapinew/uploadphoto.php?formattype=json&authcode=%@&fid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD],self.string_fid];
        
        
        if (subjectTextfield.text.length==0)
        {
            button_send.userInteractionEnabled=YES;
            button_back.userInteractionEnabled=YES;
            
            
            UIAlertView *alertview_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"帖子标题不能为空" delegate:nil cancelButtonTitle:@"请输入标题" otherButtonTitles:nil, nil];
            [alertview_ show];
            return;
        }
        
        if (_contenttextview.text.length==0)
        {
            button_send.userInteractionEnabled=YES;
            button_back.userInteractionEnabled=YES;
            UIAlertView *alertview_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"帖子内容不能为空" delegate:nil cancelButtonTitle:@"请输入内容" otherButtonTitles:nil, nil];
            [alertview_ show];
            return;
        }
        
        
        
        NSString * string = [NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/uploadmorephoto.php?formattype=json&fid=%@&authcode=%@",
                             self.string_fid,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
        NSString* fullURL = [NSString stringWithFormat:URLIMAGE,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
        
        NSLog(@"上传图片请求的地址===%@",fullURL);
        //    NSString* fullURL = [NSString stringWithFormat:URLIMAGE,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
        ASIFormDataRequest *     request__ = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:string]];
        request__.delegate = self;
        request__.tag = 123;
        
        
        //得到图片的data
        NSData* data;
        //获取图片质量
        
        NSMutableData *myRequestData=[NSMutableData data];
        
        NSLog(@"imagearray -----  %d",allImageArray.count);
        
        for (int i = 0;i < allImageArray.count; i++)
        {
            [request__ setPostFormat:ASIMultipartFormDataPostFormat];
            
            UIImage *image=[allImageArray objectAtIndex:i];
            
            
            UIImage * newImage = [personal scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
            
            data = UIImageJPEGRepresentation(newImage,image_quality?0.5:0.3);
            
            
            
            [request__ addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [myRequestData length]]];
            
            //设置http body
            
            [request__ addData:data withFileName:[NSString stringWithFormat:@"boris%d.png",i] andContentType:@"image/PNG" forKey:[NSString stringWithFormat:@"pic%d",i]];
            
            //  [request addData:myRequestData forKey:[NSString stringWithFormat:@"boris%d",i]];
            
        }
        
        
        [request__ setRequestMethod:@"POST"];
        
        request__.cachePolicy = TT_CACHE_EXPIRATION_AGE_NEVER;
        
        request__.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
        
        [request__ startAsynchronous];
    }
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"上传完成");
    
    @try {
        button_send.userInteractionEnabled=YES;
        if (request.tag == 123)
        {
            NSLog(@"走了555");
            
            NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
            
            NSLog(@"tupiandic==%@",dic);
            NSString *str_err=[NSString stringWithFormat:@"%@",[dic objectForKey:@"errcode"]];
            NSArray * aid_array;
            
            NSArray * img_array;
            if ([str_err integerValue]==0) {
                
                NSDictionary * array = [dic objectForKey:@"bbsinfo"];
                
                
                aid_array = [array objectForKey:@"aid"];
                
                img_array = [array objectForKey:@"img"];
            }
            
            
            
            if ([[dic objectForKey:@"errcode"] intValue] ==0)
            {
                for (int i = 0;i < aid_array.count;i++)
                {
                    if (i == 0)
                    {
                        str_aid = [aid_array objectAtIndex:i];
                        str_img = [img_array objectAtIndex:i];
                    }else
                    {
                        str_aid = [NSString stringWithFormat:@"%@,%@",str_aid,[aid_array objectAtIndex:i]];
                        str_img = [NSString stringWithFormat:@"%@%@",str_img,[img_array objectAtIndex:i]];
                    }
                }
                
                [self sendcomment];
                
                NSLog(@"kankanzayang  ---  %@ ---  %@",str_img,str_aid);
                
            }else
            {
                [hud hide];
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"上传图片失败,请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                button_send.userInteractionEnabled=YES;
                button_back.userInteractionEnabled=YES;
                [alert show];
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    
    //    NSLog(@"上传失败 error --  %@",request.error);
    //    [hud hide];
    //
    //    button_send.userInteractionEnabled=YES;
    //    button_back.userInteractionEnabled=YES;
    //
    //
    //
    //
    //
    //    UIAlertView *_alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接超时，请稍后发送" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    //    [_alert show];
    
    [self saveMydataAndhideHud];
    
    
    
    
}
#pragma mark-照片获取的实现
-(void)pickImageFromAlbum{
    imagePicker = [[UIImagePickerController alloc] init];//图像选取器
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//打开相册
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//过渡类型,有四种
    //imagePicker.allowsEditing = NO;//禁止对图片进行编辑
    [self presentModalViewController:imagePicker animated:YES];//打开模态视图控制器选择图像
    
}
-(void)pickImageFromCamera{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//照片来源为相机
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:imagePicker animated:YES];
    
}


//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    currentImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
//
//    //得到图片的data
//    //获取图片质量
//    NSString *tupianzhiliang=[[NSUserDefaults standardUserDefaults] objectForKey:TUPIANZHILIANG];
//
//    _data = UIImageJPEGRepresentation([personal fixOrientation:currentImage],0.2);
//
//    if (tupianzhiliang==nil)
//    {
//        NSLog(@"//普通质量");
//
//        _data = UIImageJPEGRepresentation([personal fixOrientation:currentImage],0.2);
//    }else
//    {
//        if ([@"1" isEqualToString:tupianzhiliang])
//        {
//            //高清
//            _data = UIImageJPEGRepresentation([personal fixOrientation: currentImage],0.8);
//        }else if([@"2" isEqualToString:tupianzhiliang])
//        {
//            //普通质量
//            _data = UIImageJPEGRepresentation([personal fixOrientation: currentImage],0.2);
//        }else if([@"3" isEqualToString:tupianzhiliang])
//        {
//            //低质量
//            _data = UIImageJPEGRepresentation([personal fixOrientation: currentImage],0.0001);
//        }else
//        {
//            _data = UIImageJPEGRepresentation([personal fixOrientation: currentImage],0.2);
//        }
//    }
//
//
//
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//    {
//         UIImageWriteToSavedPhotosAlbum(currentImage, nil, nil,nil);
//    }
//
//    [_keytop setImage_:currentImage];
//
//    NSLog(@"currentimagehave===%@",currentImage);
//
//    //调用imageWithImageSimple:scaledToSize:方法
//
//
//    [self dismissModalViewControllerAnimated:YES];//关闭模态视图控制器
//}
-(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    
    UIGraphicsEndImageContext();//关闭当前环境
    
    return newImage;
}

#pragma mark - 键盘状态监测


- (void) keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary * info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:0.1];
    
    NSLog(@"----- %f",kbRect.size.height);
    
    NSLog(@"----- y : %f",kbRect.origin.y);
    
    CGFloat keyboad_y = kbRect.origin.y;
    
    _keyboard_y = keyboad_y;
    
    if (isbiaoti) {
        
        [_keytop bottoming];
    }else
    {
        _keytop.top = keyboad_y - _keytop.height;
        
    }
    
}

//- (void) keyboardWillShow:(NSNotification *)notification {
//    
//    NSDictionary * info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    //
//    //    [UIView beginAnimations:nil context:nil];
//    //    [UIView setAnimationDuration:0.1];
//    
//    NSLog(@"----- %f",kbSize.height);
//    
//    if (kbSize.height == 252) {
//        ischinese=0;
//        [_keytop chinesekeyuping];
//        
//        
//    }else {
//        ischinese=1;
//        
//        [_keytop uping];
//    }
//    
//    
//    
//    int heightofkeyboard=(int)kbSize.height;
//    switch (heightofkeyboard) {
//        case 252:
//        {
//            ischinese=0;
//            [_keytop chinesekeyuping];
//            
//            
//        }
//            break;
//            
//            
//        case 216:
//        {
//            ischinese=1;
//            
//            [_keytop uping];
//            
//        }
//            break;
//        case 251:
//        {
//            ischinese=2;
//            [_keytop jiugonggechineseuping];
//            
//            
//        }
//            break;
//        case 184:
//        {
//            ischinese=3;
//            [_keytop jiugonggepinyinuping];
//            
//            
//        }
//            break;
//            
//            
//            
//        default:
//            break;
//    }
//    
//    
//    
//    
//    
//    //    [UIView commitAnimations];
//}
- (void)keyboardWillHide:(NSNotification *)note
{
    
    
}
-(void)faceviewshow{
    if (IOS_VERSION>=7) {
        faceScrollView.frame = CGRectMake(0, DEVICE_HEIGHT - 140-44+3+20-55, DEVICE_WIDTH, 215) ;
        pageControl.frame=CGRectMake(0, DEVICE_HEIGHT - 44+3, 320, 25);
        
    }else{
        faceScrollView.frame = CGRectMake(0, DEVICE_HEIGHT - 140-44+3-55, DEVICE_WIDTH, 215) ;
        pageControl.frame=CGRectMake(0, DEVICE_HEIGHT - 44+3-20, 320, 25);
        
    }
    
    [_contenttextview resignFirstResponder];
}
-(void)faceviewhide{
    faceScrollView.frame= CGRectMake(0, 900, DEVICE_WIDTH, 215) ;
    pageControl.frame=CGRectMake(0, 900, DEVICE_WIDTH, 25);
    [_contenttextview resignFirstResponder];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    //获取当前页码
    int index = fabs(faceScrollView.contentOffset.x) / faceScrollView.frame.size.width;
    
    //设置当前页码
    pageControl.currentPage = index;
}
-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    NSLog(@"name=%@isbiaoti==%d",name,isbiaoti);
    if (isbiaoti==1) {
        subjectTextfield.text=[NSString stringWithFormat:@"%@%@",subjectTextfield.text,name];
    }else{
        _contenttextview.text=[NSString stringWithFormat:@"%@%@",_contenttextview.text,name];
    }
    
    //   _contenttextview.text=
    //    subjectTextfield.text=
    //text_write.text=[NSString stringWithFormat:@"%@%@",text_write.text,name];
}
#pragma mark UITextFieldDelegate

-(void)textFieldDiEditing:(UITextField *)textField{
    
    //    isbiaoti = 1;//是标题
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_contenttextview resignFirstResponder];
    
    [_keytop bottoming];//隐藏
    
    isbiaoti=1;
    isup = NO;
    
    [_keytop FaceAndKeyBoard:1];
}

#pragma mark UITextViewDelegate

-(void)textViewDidEndEditing:(UITextView *)textView{
    //    isbiaoti = 0;
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    if (isbiaoti) {
        
        [subjectTextfield resignFirstResponder];
        isbiaoti = 0;
    }
    isup = NO;
    [_keytop FaceAndKeyBoard:1];
    
    _keytop.top = _keyboard_y - _keytop.height;//显示
    
}


#pragma mark - QBImagePickerControllerDelegate


-(void)removeSelf:(UIButton *)button
{
    NSLog(@"buttonssstag=%d===count===%d",button.tag,allImageArray.count);
    if (button.tag-101 < allImageArray.count)
    {
        NSLog(@"?????????");
        
        [allImageArray removeObjectAtIndex:button.tag-101];
        [allAssesters removeObjectAtIndex:button.tag-101];
        
        
        [self returnAllImageUrl];
        
        for (UIButton *oldbutton in morePicImageView.subviews) {
            [oldbutton removeFromSuperview];
        }
        
        
        [self setbutton];
        
        
        
    }
}


-(void)takeAphoto
{
    [self takePhoto];
}


- (void)image:(UIImage *)image didFinishSavingWithError:
(NSError *)error contextInfo:(void *)contextInfo;
{
    NSLog(@"contextInfo ----  %@",contextInfo);
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:image1.CGImage orientation:(ALAssetOrientation)image1.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error )
     {
         //here is your URL : assetURL
         
         NSString * string = [assetURL absoluteString];
         
         if (allImageUrl.length != 0)
         {
             allImageUrl = [NSString stringWithFormat:@"%@||%@",allImageUrl,string];
         }else
         {
             allImageUrl = string;
         }
         
         [allAssesters addObject:assetURL];
         
     }];
    NSLog(@"...........imarray__url======%@",allImageUrl);
    
    //  [allAssesters addObject:[info objectForKey:@"UIImagePickerControllerReferenceURL"]];
    
    
    //    if (allImageUrl.length != 0)
    //    {
    //        allImageUrl = [NSString stringWithFormat:@"%@||%@",allImageUrl,[info objectForKey:@"UIImagePickerControllerReferenceURL"]];
    //    }
    
    int all = allImageArray.count;
    
    UIButton * imageV = (UIButton *)[morePicImageView viewWithTag:101+all];
    [imageV setImage:image forState:UIControlStateNormal];
    imageV.imageView.clipsToBounds = YES;
    imageV.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [allImageArray addObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    morePicView.hidden = NO;
    
    [_contenttextview resignFirstResponder];
    [subjectTextfield resignFirstResponder];
    
    
    [picker dismissModalViewControllerAnimated:YES];
}


-(void)returnAllImageUrl
{
    allImageUrl = @"";
    
    for (int i = 0;i < allAssesters.count;i++)
    {
        NSString * string = [allAssesters objectAtIndex:i];
        
        if (i == 0)
        {
            allImageUrl = [NSString stringWithFormat:@"%@",string];
        }else
        {
            allImageUrl = [NSString stringWithFormat:@"%@||%@",allImageUrl,string];
        }
    }
    
    // NSLog(@"------  %@",allImageUrl);
    
}


- (void)imagePickerController1:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    
    NSArray *mediaInfoArray = (NSArray *)info;
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    int all = allImageArray.count;
    
    for (int i = 0;i < mediaInfoArray.count;i++)
    {
        UIButton * imageV = (UIButton *)[morePicImageView viewWithTag:i+101+all];
        [imageV setImage:[[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
        [allImageArray addObject:[[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerOriginalImage"]];
        
        [allAssesters addObject:[[mediaInfoArray objectAtIndex:i] objectForKey:@"UIImagePickerControllerReferenceURL"]];
    }
    
    
    
    [self returnAllImageUrl];
    
    
    
    morePicView.hidden = NO;
    [_contenttextview resignFirstResponder];
    [subjectTextfield resignFirstResponder];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Cancelled");
    
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";//@"すべての写真を選択";
}

- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";//@"すべての写真の選択を解除";
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return @"";//[NSString stringWithFormat:@"写真%d枚", numberOfPhotos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    return @"";//[NSString stringWithFormat:@"ビデオ%d本", numberOfVideos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    return @"";//[NSString stringWithFormat:@"写真%d枚、ビデオ%d本", numberOfPhotos, numberOfVideos];
}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
