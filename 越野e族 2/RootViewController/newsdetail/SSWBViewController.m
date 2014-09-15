//
//  SSWBViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SSWBViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"
@interface SSWBViewController (){
    UINavigationBar *nav;
    int remainTextNum;//还可以输入的字数
    
    AlertRePlaceView *_replaceAlertView;

}

@end

@implementation SSWBViewController
@synthesize myTextView,string_text,_shareimg;

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
    
    [MobClick endEvent:@"SSWBViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"SSWBViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    UIView *aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view=aview;
    aview.backgroundColor=[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    
    UIView *view_daohang=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    view_daohang.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pinglun_bg@2x.png"]];
    
    [aview addSubview:view_daohang];
    
    UIButton *    button_back=[[UIButton alloc]initWithFrame:CGRectMake(5, 8, 32, 28)];
    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [view_daohang addSubview:button_back];
    UILabel *labelbiaoti;
    
    
    labelbiaoti=[[UILabel alloc]initWithFrame:CGRectMake(140, 8, 100, 28)];
    
    labelbiaoti.font= [UIFont fontWithName:@"Helvetica" size:20];
    labelbiaoti.backgroundColor=[UIColor clearColor];
    labelbiaoti.textColor=[UIColor whiteColor];
    [view_daohang addSubview:labelbiaoti];
    
    button_send=[[UIButton alloc]initWithFrame:CGRectMake(273.5, 8, 40, 28)];
    [button_send addTarget:self action:@selector(imagesend) forControlEvents:UIControlEventTouchUpInside];
    [button_send setBackgroundImage:[UIImage imageNamed:@"send.png"] forState:UIControlStateNormal];
    [button_send setTitle:@"发送" forState:UIControlStateNormal];
    [button_send.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [view_daohang addSubview:button_send];
    
    //主题这两个字
    UILabel *zhutilabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 47, 55, 27)];
    zhutilabel.text=@"新浪分享";
    [aview addSubview:zhutilabel];
    zhutilabel.textAlignment=NSTextAlignmentCenter;
    zhutilabel.backgroundColor=[UIColor clearColor];
    zhutilabel.font=[UIFont systemFontOfSize:18];
    
    
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0,44,320,130-20)];
    myTextView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    myTextView.delegate = self;
    

    
    
    
     myTextView.text = self.string_text;

    myTextView.tag = 101;
    myTextView.textColor = [UIColor blackColor];
    //换不换
    CGSize size = [myTextView.text sizeWithFont: [UIFont boldSystemFontOfSize:15]
                             constrainedToSize: CGSizeMake(327.0f, 9999999.0f)
                                 lineBreakMode: UILineBreakModeCharacterWrap];
    [myTextView setContentSize:size];
    if (myTextView.contentSize.height <= myTextView.frame.size.height) {
        
        [myTextView setUserInteractionEnabled:NO];
    }
    
    myTextView.font = [UIFont systemFontOfSize:17];
    [myTextView becomeFirstResponder];
    
    
    [aview addSubview:myTextView];
    
    
    options_view = [[UIView alloc] initWithFrame:CGRectMake(0,iPhone5?178+88-20-5:178-20-5,320,50)];
    options_view.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
//   options_view.backgroundColor=[UIColor redColor];
    
    UIImageView *share_img=[[UIImageView alloc]initWithFrame:CGRectMake(5,2,self._shareimg.size.width*50/self._shareimg.size.height,47)];
    share_img.image=self._shareimg;
    [options_view addSubview:share_img];

    [aview addSubview:options_view];
    
    wordsNumber_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    wordsNumber_button.frame = CGRectMake(253.5,2+22,60,25);
    
    [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
    
    [wordsNumber_button setTitleColor:RGBCOLOR(154,162,166) forState:UIControlStateNormal];
    
    
    [wordsNumber_button setTitleEdgeInsets:UIEdgeInsetsMake(1,0,0,20)];
    
    
   // [wordsNumber_button setImage:[personal getImageWithName:@"111@2x"] forState:UIControlStateNormal];
    UIImageView *xximg=[[UIImageView alloc]initWithFrame:CGRectMake(40, 8, 9, 9)];
    xximg.image=[UIImage imageNamed:@"111.png"];
    [wordsNumber_button addSubview:xximg];
    

    [wordsNumber_button setImageEdgeInsets:UIEdgeInsetsMake(2,35,0,0)];
    
    
    [wordsNumber_button addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside
     ];
    
    
    [wordsNumber_button setBackgroundImage:[personal getImageWithName:@"4-121-51@2x"] forState:UIControlStateNormal];
    
    [options_view addSubview:wordsNumber_button];
    //提示没有发送成功
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(100, 200, 150, 100) labelString:@"由于网络原因，发送不成功"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow
     addSubview:_replaceAlertView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

	// Do any additional setup after loading the view.
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    [UIView animateWithDuration:0.3 animations:^
     {
         options_view.frame = CGRectMake(0,(iPhone5?568:480)-_keyboardRect.size.height-44-20-11,320,75);
         
     }];
}

#pragma mark-点击显示字数的button会清零textview
-(void)doTap:(UIButton *)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除文字" otherButtonTitles:nil, nil];
    actionSheet.tag = 100000-1;
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        myTextView.text = @"";
        [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
        
    }
}

//内容框字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.tag == 100)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 101;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    
    
    
    if (textView.text.length == 0)
    {
        textView.selectedRange =  NSMakeRange(0, 0);
        textView.textColor = RGBCOLOR(154,162,166);
        textView.tag = 100;
    }
    
    
    NSString  * nsTextContent=textView.text;
    int   existTextNum=[nsTextContent length];
    remainTextNum=140-existTextNum;
    //    wordsNumber_label.text = [NSString stringWithFormat:@"%i",remainTextNum];
    [wordsNumber_button setTitle:[NSString stringWithFormat:@"%i",remainTextNum] forState:UIControlStateNormal];
    //
    //    if ([textView.text isEqualToString:@"分享新鲜事......"])
    //    {
    //        [wordsNumber_button setTitle:@"140" forState:UIControlStateNormal];
    //        textView.selectedRange =  NSMakeRange(0, 0);
    //    }
    //
    
    
}




#pragma mark-跳转到先前的页面
-(void)backH{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark-发送到新浪微博
-(void)imagesend{
    if ([wordsNumber_button.titleLabel.text integerValue]<0) {
        UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"所发文字超过140，请重新编辑" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert_ show];
        
    }else{
        button_send.userInteractionEnabled=NO;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:myTextView.text image:self._shareimg location:nil urlResource:nil completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsFriends is %@",response.data);
            
            //            SnsFriends is {
            //                sina =     {
            //                    data =         {
            //                        "doub_rate" = 0;
            //                        hour = "2013-08-09;11";
            //                        "qzone_rate" = 0;
            //                        "renr_rate" = 0;
            //                        result = updated;
            //                        "send_result" =             {
            //                            id = 3609341116935250;
            //                            idstr = 3609341116935250;
            //                            mid = 3609341116935250;
            //                        };
            //                        "sina_rate" = 0;
            //                        "tenc_rate" = 0;
            //                        today = "2013-08-09";
            //                    };
            //                    msg = "no error";
            //                    st = 200;
            //                };
            //            }
            
            NSDictionary *dicinfo=response.data;
            NSString *string_=[NSString stringWithFormat:@"%@",[[dicinfo objectForKey:@"sina"] objectForKey:@"msg"]];
            NSLog(@"svaaskvklklkl;k;l;ll;;lkl;======%@",string_);
            
                [self dismissModalViewControllerAnimated:YES];
                        
        }];
        
    }
}

#pragma mark-显示框
-(void)hidefromview{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
    NSLog(@"?????");
}
-(void)hidealert{
    _replaceAlertView.hidden=YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
