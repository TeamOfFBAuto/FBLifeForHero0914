//
//  QrcodeViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-12-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "QrcodeViewController.h"
#import "ASIFormDataRequest.h"
#import "WriteBlogViewController.h"
#import "LogInViewController.h"
@interface QrcodeViewController ()

@end

@implementation QrcodeViewController
@synthesize headImage,nameString,uid,imageString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"QrcodeViewController"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"QrcodeViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    self.uid = [user objectForKey:USER_UID];
    
    self.nameString = [user objectForKey:USER_NAME];
    
    self.imageString = [user objectForKey:USER_FACE];
    
    
    self.view.backgroundColor=RGBCOLOR(247, 247, 247);
//    UILabel *labelbiaoti=[[UILabel alloc]initWithFrame:CGRectMake(35,0,120,44)];
//    labelbiaoti.text=@"二维码";
//    labelbiaoti.textColor=[UIColor blackColor];
//    labelbiaoti.font= [UIFont fontWithName:@"Helvetica" size:20];
//    //[view_daohang addSubview:labelbiaoti];
//    labelbiaoti.backgroundColor=[UIColor clearColor];
//    
//    UIView *biaotiV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 220,44)];
//    biaotiV.backgroundColor=[UIColor clearColor];
//    [biaotiV addSubview:labelbiaoti];
    //
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?35: 23, (44-37/2)/2, 43/2, 38/2)];
    
    
    button_comment.tag=26;
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
    [button_comment addTarget:self action:@selector(simPleshare) forControlEvents:UIControlEventTouchUpInside];
    [button_comment setImage:[UIImage imageNamed:@"zhuanfa_image.png"] forState:UIControlStateNormal];
    button_comment.userInteractionEnabled=NO;
    
    UIButton *   rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightView addTarget:self action:@selector(simPleshare) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button_comment];
    rightView.backgroundColor=[UIColor clearColor];
    
    
    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem=comment_item;

    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
        
    }
    
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = MY_MACRO_NAME?-10:5;
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(0,3,30,44)];
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    [button_back setImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    self.navigationItem.leftBarButtonItems=@[space,back_item];
    
    
    NSString *string_myuid=[[NSUserDefaults standardUserDefaults]objectForKey:USER_UID];
    if ([string_myuid isEqualToString:self.uid]) {
        self.navigationItem.rightBarButtonItem=comment_item;

    }
    
    
    
    
    self.navigationItem.title = @"二维码";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    
    UIImageView *centerimgkuang=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_erweima533_700.png"]];
    centerimgkuang.center=CGPointMake(160, (iPhone5?568-64:480-64)/2);
    [self.view addSubview:centerimgkuang];
    
    
    qrimageview=[[AsyncImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    qrimageview.tag=199;
    qrimageview.frame=CGRectMake(15, 15 ,464/2, 464/2);
   // qrimageview.backgroundColor=[UIColor orangeColor];
    [centerimgkuang addSubview:qrimageview];
    
    
    AsyncImageView * headimageview = [[AsyncImageView alloc] initWithFrame:CGRectMake(15, 564/2, 50, 50)];
    
    [headimageview loadImageFromURL:self.imageString withPlaceholdImage:[UIImage imageNamed:@"touxiang"]];
    
    [centerimgkuang addSubview:headimageview];
    
    if ([string_myuid isEqualToString:self.uid]) {
        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 564/2, 200, 20)];
        namelabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME];
        namelabel.font=[UIFont boldSystemFontOfSize:18];
        namelabel.backgroundColor=[UIColor clearColor];
        [centerimgkuang addSubview:namelabel];
        UILabel *discribelabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 564/2+26, 200, 20)];
        discribelabel.text=@"扫一扫二维码,关注我的主页";
        discribelabel.font=[UIFont systemFontOfSize:14];
        discribelabel.textColor=RGBCOLOR(125, 125, 125);
        [centerimgkuang addSubview:discribelabel];
        discribelabel.backgroundColor=[UIColor clearColor];

    }else{
        
        UILabel *discribelabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 564/2+10, 200, 20)];
        discribelabel.text=@"扫一扫关注我的主页";
        discribelabel.font=[UIFont systemFontOfSize:14];
        discribelabel.textColor=[UIColor blackColor];
        [centerimgkuang addSubview:discribelabel];
        discribelabel.backgroundColor=[UIColor clearColor];


        
    }




    
    
    [self receivemyqrcode];

    

    
    
    
	// Do any additional setup after loading the view.
}


-(void)receivemyqrcode{
    
  
        
        NSString * fullURL= [NSString stringWithFormat:@"http://ucache.fblife.com/ucode/api.php?uid=%@",self.uid];
        NSLog(@"1请求的url = %@",fullURL);
        ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
        
        __block ASIHTTPRequest * _requset = request;
        
        _requset.delegate = self;
        
        [_requset setCompletionBlock:^{
            
            @try {
                NSDictionary * dic = [request.responseData objectFromJSONData];
                NSLog(@"个人信息 -=-=  %@",dic);
                
                if ([[dic objectForKey:@"errcode"] intValue] ==0)
                {
                    NSString *strurl=[NSString stringWithFormat:@"%@",[dic objectForKey:@"codesrc"]];
                //    [self receiveimgdatawithurlstring:strurl];
                   [qrimageview loadImageFromURL:strurl withPlaceholdImage:nil];
                                   }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
     
        }];
        
        
        [_requset setFailedBlock:^{
            
            [request cancel];  
            
        }];
        
        [_requset startAsynchronous];
    
}


-(void)backto{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)handleImageLayout:(AsyncImageView *)tag{
    
    NSLog(@"success........");
}
#define TT_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf
-(void)simPleshare{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
        
        writeBlogView.theText = [NSString stringWithFormat:@"扫描我的二维码，加关注吧"] ;
        
        NSMutableArray *array_shareimg=[[NSMutableArray alloc]init];
        [array_shareimg addObject:qrimageview.image];
        NSMutableArray *array_none=[[NSMutableArray alloc]init];
        [array_none addObject:@"safjakf"];
        writeBlogView.allImageArray1=array_shareimg;
        writeBlogView.allAssesters1=array_none;
        
        [self presentViewController:writeBlogView animated:YES completion:NULL];
    }
    else{
        //没有激活fb，弹出激活提示
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentViewController:login animated:YES completion:nil];
    }


}
-(void)ShareMore{
    
    NSLog(@"Share My QR Code");
    NSString* fullURL = [NSString stringWithFormat:URLIMAGE,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    //  NSString * fullURL = [NSString stringWithFormat:@"http://t.fblife.com/openapi/index.php?mod=doweibo&code=addpicmuliti&fromtype=b5eeec0b&authkey=UmZaPlcyXj8AMQRoDHcDvQehBcBYxgfbtype=json"];
    
    
    NSLog(@"上传图片的url  ——--  %@",fullURL);
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:fullURL]];
    request.delegate = self;
    request.tag = 1;
    
    //得到图片的data
    NSData* data;
    //获取图片质量
    //  NSString *tupianzhiliang=[[NSUserDefaults standardUserDefaults] objectForKey:TUPIANZHILIANG];
    
    NSMutableData *myRequestData=[NSMutableData data];
    
    NSArray *allImageArray=[NSArray arrayWithObjects:qrimageview.image, nil];
    NSLog(@"imagearray -----  %d",allImageArray.count);
    
    for (int i = 0;i < allImageArray.count; i++)
    {
        [request setPostFormat:ASIMultipartFormDataPostFormat];
        
        UIImage *image=[allImageArray objectAtIndex:i];
        
        UIImage * newImage = [personal scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
        
        data = UIImageJPEGRepresentation(newImage,1);
        
        
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [myRequestData length]]];
        
        //设置http body
        
        [request addData:data withFileName:[NSString stringWithFormat:@"boris%d.png",i] andContentType:@"image/PNG" forKey:@"topic[]"];
        
        //  [request addData:myRequestData forKey:[NSString stringWithFormat:@"boris%d",i]];
        
    }
    
    [request setRequestMethod:@"POST"];
    
    request.cachePolicy = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    request.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
    
    [request startAsynchronous];
    
    
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==1) {
        NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
        //    NSString *errcode = [dic objectForKey:ERRCODE];
        
        if ([[dic objectForKey:@"errcode"] intValue] == 1)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"图片上传失败,请重新上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            [alert show];
        }else
        {
            
            NSDictionary * dictionary = [dic objectForKey:DATA];
            
            NSArray * array = [dictionary allKeys];
            
            NSString* authod = @"";
            
            
            for (int i = 0;i < array.count;i++)
            {
                if (i == 0)
                {
                    authod = [array objectAtIndex:i];
                }else
                {
                    authod = [NSString stringWithFormat:@"%@|%@",authod,[array objectAtIndex:i]];
                }
                
            }
            
            
            
            
            NSString* fullURL;
            
            fullURL = [NSString stringWithFormat:URLIMAGEID,[@"扫一扫我的二维码，加关注吧" stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[authod stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
            
            NSLog(@"19请求的url：%@",fullURL);
            
            
            ASIHTTPRequest * request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
            request1.tag = 2;
            request1.delegate = self;
            
            [request1 startAsynchronous];
        }
        
    }else if(request.tag==2){
        NSLog(@"..........");
        UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert_ show];
    }

    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
