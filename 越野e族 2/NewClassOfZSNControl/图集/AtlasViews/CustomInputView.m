//
//  CustomInputView.m
//  越野e族
//
//  Created by soulnear on 14-7-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "CustomInputView.h"

@implementation CustomInputView
@synthesize commit_label,pinglun_button,text_background_view,text_input_view,send_button,commot_background_view,top_line_view;

@synthesize content_dictionary = _content_dictionary;

@synthesize fenye_button = _fenye_button;

@synthesize isShowFenYe = _isShowFenYe;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGBCOLOR(251,251,251);
    }
    return self;
}


-(void)loadAllViewWithPinglunCount:(NSString *)theCount WithType:(int)theType WithPushBlock:(InputViewButtonTap)thePushBlock WithSendBlock:(InputViewSendToPinglunBlock)theSendBlock
{
    
    inputViewButtonTap_block = thePushBlock;
    
    sendPingLun_block = theSendBlock;
    
    top_line_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0.5)];
    
    top_line_view.backgroundColor = RGBCOLOR(211,211,211);
    
    [self addSubview:top_line_view];
        
    
    if (self.isShowFenYe)
    {
        _fenye_button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _fenye_button.frame = CGRectMake(0,0,50,self.frame.size.height);
        
        _fenye_button.center = CGPointMake(25,self.frame.size.height/2);
        
        _fenye_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_fenye_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _fenye_button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _fenye_button.backgroundColor=[UIColor clearColor];
        
        
        _mylabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 1, 50, self.frame.size.height-1)];
        
        _mylabel.font=[UIFont systemFontOfSize:14];
        
        _mylabel.backgroundColor=RGBCOLOR(250, 250, 250);
        
        _mylabel.textAlignment=NSTextAlignmentCenter;
        
        [_fenye_button addSubview:_mylabel];
        
        
        
        
        

        
//        [_fenye_button setImage:[UIImage imageNamed:@"bottom_fenye_image"] forState:UIControlStateNormal];
        
        [_fenye_button addTarget:self action:@selector(fenyeTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_fenye_button];
    }
    
    
    commot_background_view = [[UIView alloc] initWithFrame:CGRectMake(11+(_isShowFenYe?40:0),(self.bounds.size.height-30)/2,255-(_isShowFenYe?40:0),30)];
    
    commot_background_view.backgroundColor = [UIColor whiteColor];
    
    commot_background_view.layer.masksToBounds = NO;
    
    commot_background_view.layer.borderColor = RGBCOLOR(230,230,230).CGColor;
    
    commot_background_view.layer.borderWidth = 0.5;
    
    [self addSubview:commot_background_view];
    
    
    
    commit_label = [[UILabel alloc] initWithFrame:CGRectMake(5,0,commot_background_view.frame.size.width-10,30)];
    
    commit_label.userInteractionEnabled = YES;
    
    commit_label.backgroundColor = [UIColor clearColor];
    
    commit_label.textColor = RGBCOLOR(175,175,175);
    
    commit_label.text = @"发表评论";
    
    commit_label.font = [UIFont systemFontOfSize:14];
    
    commit_label.textAlignment = NSTextAlignmentLeft;
    
    [commot_background_view addSubview:commit_label];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInputView:)];
    
    [commit_label addGestureRecognizer:tap];
    
    
    
    
    pinglun_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    pinglun_button.backgroundColor = [UIColor clearColor];
    
    pinglun_button.frame = CGRectMake(275,7,30,30);
    
    pinglun_button.userInteractionEnabled = YES;
    
    pinglun_button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [pinglun_button setTitle:theCount forState:UIControlStateNormal];
    
    pinglun_button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [pinglun_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [pinglun_button addTarget:self action:@selector(pushToPinglunTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:pinglun_button];
    
    
    UIImageView * pinglun_image_view = [[UIImageView alloc] initWithFrame:CGRectMake(25,0,11,11.5)];
    
    pinglun_image_view.image = [UIImage imageNamed:@"atlas_talk"];
    
    [pinglun_button addSubview:pinglun_image_view];
    
    
    
    text_background_view = [[UIView alloc] initWithFrame:CGRectMake(0,(iPhone5?568:480),320,250)];
    
    text_background_view.backgroundColor = RGBCOLOR(249,248,249);
    
    [[UIApplication sharedApplication].keyWindow addSubview:text_background_view];
    
    
    text_input_view = [[UITextView alloc] initWithFrame:CGRectMake(20,20,280,84)];
    
    text_input_view.layer.masksToBounds = NO;
    
    text_input_view.delegate = self;
    
    text_input_view.layer.borderColor = RGBCOLOR(211,211,211).CGColor;
    
    text_input_view.layer.borderWidth = 0.5;
    
    [text_background_view addSubview:text_input_view];
    
    
    send_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    send_button.frame = CGRectMake(240,120,60,30);
    
    send_button.enabled = NO;
    
    [send_button setTitle:@"发送" forState:UIControlStateNormal];
    
    [send_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    send_button.backgroundColor = RGBCOLOR(221,221,221);
    
    send_button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [send_button addTarget:self action:@selector(submitPingLunTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [text_background_view addSubview:send_button];
    
    
    isForward = NO;
    
    UIButton * mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    mark_button.frame = CGRectMake(20,126.5,14,14);
    
    mark_button.layer.masksToBounds = NO;
    
    mark_button.layer.borderWidth = 0.5;
    
    mark_button.layer.borderColor = RGBCOLOR(174,172,178).CGColor;
    
    mark_button.backgroundColor = RGBCOLOR(248,248,248);
    
  //  [mark_button addTarget:self action:@selector(markTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [text_background_view addSubview:mark_button];
    
    
    mark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"writeblog_mark_image.png"]];
    mark.center = CGPointMake(mark_button.bounds.size.width/2,mark_button.bounds.size.height/2);
    mark.hidden = NO;
    [mark_button addSubview:mark];
    
    
    UILabel * content_label = [[UILabel alloc] initWithFrame:CGRectMake(42,126,200,15)];
    
    content_label.text = @"同时转发到自留地";
    
    content_label.font = [UIFont systemFontOfSize:15];
    
    content_label.textAlignment = NSTextAlignmentLeft;
    
    content_label.textColor = RGBCOLOR(88,88,88);
    
    content_label.backgroundColor = [UIColor clearColor];
    
    [text_background_view addSubview:content_label];
}


#pragma mark - 是否发送到微博选项

-(void)markTap:(UIButton *)button
{
    isForward = !isForward;
    
    mark.hidden = !isForward;
    
}


#pragma mark - 监测键盘弹出收起以及高度变化

-(void)handleWillShowKeyboardForCustomInputView:(NSNotification *)notification
{
    __weak typeof(self) bself = self;
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardY = [[UIApplication sharedApplication].keyWindow convertRect:keyboardRect fromView:nil].origin.y;
    
    [UIView animateWithDuration:0.33f animations:^{
        
        CGRect frame = bself.text_background_view.frame;
        
        frame.origin.y = keyboardY - 164;;
        
        bself.text_background_view.frame = frame;
        
        _theTouchView.frame = CGRectMake(0,0,320,bself.text_background_view.frame.origin.y);
        
    } completion:^(BOOL finished) {
        
    }];
    
}


-(void)handleWillHideKeyboardForCustomInputView:(NSNotification *)notification
{
    [self hiddenInputView];
}


-(void)hiddenInputView
{
    __weak typeof(self) bself = self;
    
    [UIView animateWithDuration:0.275f animations:^{
        _theTouchView.hidden = YES;
        bself.text_background_view.frame = CGRectMake(0,(iPhone5?568:480),320,250);
        
        _theTouchView.frame = CGRectMake(0,0,320,bself.text_background_view.frame.origin.y);
    } completion:^(BOOL finished) {
        
    }];
}



#pragma  mark - 弹出评论框

-(void)showInputView:(UITapGestureRecognizer *)sender
{
    BOOL islogin = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (!islogin)
    {
        LogInViewController * logIn = [LogInViewController sharedManager];
        
        [[(AppDelegate *)[UIApplication sharedApplication].delegate RootVC] presentViewController:logIn animated:YES completion:NULL];
        
        return;
    }
    
    [text_input_view becomeFirstResponder];
}

#pragma mark - 分类按钮

-(void)fenyeTap:(UIButton *)sender
{
    if (inputViewButtonTap_block)
    {
        inputViewButtonTap_block(1);
    }
}


#pragma mark - 跳到评论界面

-(void)pushToPinglunTap:(UIButton *)sender
{
    if (inputViewButtonTap_block)
    {
        inputViewButtonTap_block(0);
    }
    
}


#pragma mark - 发送评论

-(void)submitPingLunTap:(UIButton *)sender
{
    sendPingLun_block(text_input_view.text,isForward);
    
    [text_input_view resignFirstResponder];
    
    text_input_view.text = @"";
    
    commit_label.text = @"";
}




#pragma mark - UITextViewDelegate


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    if (!_theTouchView)
    {
        _theTouchView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.text_background_view.frame.origin.y)];
        
        _theTouchView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddeninputViewTap1)];
        
        [_theTouchView addGestureRecognizer:tap];
        
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_theTouchView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_theTouchView];
    }else
    {
        _theTouchView.hidden = NO;
    }
    
    
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    [textView becomeFirstResponder];
    
    
}

-(void)hiddeninputViewTap1
{
    [text_input_view resignFirstResponder];
    
    _theTouchView.hidden = YES;
}


-(void)hiddeninputViewTap
{
    [text_input_view resignFirstResponder];
    
    text_input_view.text = @"";
    
    commit_label.text = @"发表评论";
    
    _theTouchView.hidden = YES;
}


-(void)textViewDidChange:(UITextView *)textView
{
    commit_label.text = text_input_view.text;
    
    if (text_input_view.text.length > 0)
    {
        send_button.backgroundColor = RGBCOLOR(235,79,83);
        
        send_button.enabled = YES;
    }else
    {
        send_button.enabled = NO;
        
        send_button.backgroundColor = RGBCOLOR(221,221,221);
    }
}


-(void)dealloc
{
    
    
}


#pragma mark - 添加删除键盘检测通知


-(void)addKeyBordNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboardForCustomInputView:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboardForCustomInputView:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)deleteKeyBordNotification
{
    [self hiddeninputViewTap];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark - 同步到自留地


-(void)ForwardingToWeiBoWith:(NSDictionary *)theDictionary
{
    self.content_dictionary = theDictionary;
    
    UIImage * image = (UIImage *)[theDictionary objectForKey:@"image"];
    
    NSMutableArray * arry = [NSMutableArray arrayWithObjects:image,nil];

    [self uploadImageWithImage:arry];
}



#pragma mark - 发送

#define TT_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf


#pragma mark - 上传图片
- (void)uploadImageWithImage:(NSMutableArray *)allImageArray
{
    
    NSString* fullURL = [NSString stringWithFormat:URLIMAGE,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    //  NSString * fullURL = [NSString stringWithFormat:@"http://t.fblife.com/openapi/index.php?mod=doweibo&code=addpicmuliti&fromtype=b5eeec0b&authkey=UmZaPlcyXj8AMQRoDHcDvQehBcBYxgfbtype=json"];
    
    
    NSLog(@"上传图片的url  ——--  %@",fullURL);
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    //得到图片的data
    NSData* data;
    //获取图片质量
    //  NSString *tupianzhiliang=[[NSUserDefaults standardUserDefaults] objectForKey:TUPIANZHILIANG];
    
    NSMutableData *myRequestData=[NSMutableData data];
    
    for (int i = 0;i < allImageArray.count; i++)
    {
        [request setPostFormat:ASIMultipartFormDataPostFormat];
        
        UIImage *image=[allImageArray objectAtIndex:i];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedImage%d.png",i]];
        //also be .jpg or another
        NSData *imageData = UIImagePNGRepresentation(image);
        //UIImageJPEGRepresentation(image)
        [imageData writeToFile:savedImagePath atomically:NO];
        
        
        UIImage * newImage = [personal scaleToSizeWithImage:image size:CGSizeMake(image.size.width>1024?1024:image.size.width,image.size.width>1024?image.size.height*1024/image.size.width:image.size.height)];
        
        data = UIImageJPEGRepresentation(newImage,0.5);
        
        
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [myRequestData length]]];
        
        //设置http body
        
        [request addData:data withFileName:[NSString stringWithFormat:@"boris%d.png",i] andContentType:@"image/PNG" forKey:@"topic[]"];
        
        //  [request addData:myRequestData forKey:[NSString stringWithFormat:@"boris%d",i]];
        
    }
    
    [request setRequestMethod:@"POST"];
    
    request.cachePolicy = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    request.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
    
    [request startAsynchronous];
    
    
    __block typeof(request) theRequest = request;
    
    [theRequest setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
            
            NSLog(@"上传图片返回结果 ------   %@",dic);
            //    NSString *errcode = [dic objectForKey:ERRCODE];
            
            
            if ([[dic objectForKey:@"errcode"] intValue] == 0)
            {
                
                NSDictionary * dictionary = [dic objectForKey:DATA];
                
                NSArray * array2 = [dictionary allKeys];
                
                NSArray *array = [array2 sortedArrayUsingSelector:@selector(compare:)];
                
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
                
                NSLog(@"authod -------   %@",authod);
                
                
                [self sendWeiBoWithAuthod:authod];
                
                
            }
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
        
        
    }];
    
    [theRequest setFailedBlock:^{
        
    }];
}


#pragma mark - 发布微博

-(void)sendWeiBoWithAuthod:(NSString *)authod
{
    NSString* fullURL;
    fullURL = [NSString stringWithFormat:URLIMAGEID,[[self.content_dictionary objectForKey:@"content"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[authod stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],AUTHKEY];
    
    NSLog(@"19请求的url：%@",fullURL);
    
    
    ASIHTTPRequest * request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block typeof(request1) request  = request1;
    
    [request setCompletionBlock:^{
        NSDictionary * jieguo = [request1.responseData objectFromJSONData];
        
        NSLog(@"request.tag1111 = 2 ==%@",[jieguo objectForKey:@"data"]);
    }];
    
    [request setFailedBlock:^{
        
    }];
    
    [request1 startAsynchronous];
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
