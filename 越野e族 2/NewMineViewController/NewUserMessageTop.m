//
//  NewUserMessageTop.m
//  FbLife
//
//  Created by soulnear on 13-12-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewUserMessageTop.h"

@implementation NewUserMessageTop
@synthesize background_imageview = _background_imageview;
@synthesize header_imageview = _header_imageview;
@synthesize username_label = _username_label;
@synthesize sendMessage_button = _sendMessage_button;
@synthesize attention_button = _attention_button;
@synthesize tap_background_view = _tap_background_view;
@synthesize info = _info;
@synthesize data_array = _data_array;
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _data_array = [[NSMutableArray alloc] init];
        
        //背景图片
        if (!_background_imageview)
        {
            _background_imageview = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,320,97.5)];
            
            _background_imageview.backgroundColor = [UIColor clearColor];
            
            _background_imageview.delegate = self;
            
            _background_imageview.image = [UIImage imageNamed:@"underPageBackGround.png"];
            
            [self addSubview:_background_imageview];
        }
        
        
        //头像
        
        
        if (!_header_imageview)
        {
            _header_imageview = [[AsyncImageView alloc] initWithFrame:CGRectMake(11.5,55.5,80,80)];
            
            _header_imageview.layer.masksToBounds = NO;
            
            _header_imageview.image = [UIImage imageNamed:@"touxiang.png"];
            
            _header_imageview.layer.shadowColor = [UIColor blackColor].CGColor;
            
            _header_imageview.layer.shadowOffset = CGSizeMake(0.5,0.5);
            
            _header_imageview.layer.shadowRadius = 1;
            
            _header_imageview.layer.shadowOpacity = 0.5;
            
//            _header_imageview.layer.borderWidth = 0.5;
//            
//            _header_imageview.layer.borderColor = RGBCOLOR(205,205,205).CGColor;
            
            [self addSubview:_header_imageview];
        }
        
        
        
        if (!_username_label)
        {
            _username_label = [[UILabel alloc] initWithFrame:CGRectMake(106.5,60,200,30)];
            
            _username_label.textColor = [UIColor whiteColor];
            
            _username_label.backgroundColor = [UIColor clearColor];
            
            _username_label.textAlignment = NSTextAlignmentLeft;
            
            _username_label.layer.masksToBounds = NO;
            
            _username_label.layer.shadowColor = [UIColor blackColor].CGColor;
            
            _username_label.layer.shadowOffset = CGSizeMake(0,1);
            
            _username_label.layer.shadowRadius = 0.5;
            
            _username_label.layer.shadowOpacity = 0.8;
            
            _username_label.font = [UIFont systemFontOfSize:19];
            
            [self addSubview:_username_label];
        }
        
        
        
        //私信
        
        if (!_sendMessage_button)
        {
            _sendMessage_button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [_sendMessage_button setImage:[UIImage imageNamed:@"sixin.png"] forState:UIControlStateNormal];
            
            _sendMessage_button.frame = CGRectMake(_header_imageview.frame.origin.x + _header_imageview.frame.size.width + 15,106,187/2,59/2);
            
            _sendMessage_button.hidden = YES;
            
            [_sendMessage_button addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_sendMessage_button];
        }
        
        
        //关注
        
        
        if (!_attention_button)
        {
            _attention_button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _attention_button.frame = CGRectMake(_sendMessage_button.frame.origin.x + _sendMessage_button.frame.size.width + 14,106,187/2,59/2);
            
            _attention_button.hidden = YES;
            
            [_attention_button addTarget:self action:@selector(sendAttention:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_attention_button];
        }
        
        
        //资料背景
        
        
        if (!_tap_background_view)
        {
            UIImageView * backV = [[UIImageView alloc] initWithFrame:CGRectMake(0,145,320,50)];
            
//            backV.image = [UIImage imageNamed:@"di-1.png"];
            
            backV.backgroundColor = [UIColor whiteColor];
            
            backV.userInteractionEnabled = YES;
            
            backV.layer.masksToBounds = NO;
            
            backV.layer.borderColor = RGBCOLOR(214,214,214).CGColor;
            
            backV.layer.borderWidth = 0.5;
            
            [self addSubview:backV];
            
            _tap_background_view = [[UIScrollView alloc] initWithFrame:backV.bounds];
            
            _tap_background_view.backgroundColor = [UIColor clearColor];
            
            _tap_background_view.showsHorizontalScrollIndicator = NO;
            
            _tap_background_view.showsVerticalScrollIndicator = NO;
            
            [backV addSubview:_tap_background_view];
        }
        
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,195,320,6)];
        
        view.backgroundColor = RGBCOLOR(248,247,248);
        
        [self addSubview:view];
        
        UIView * view_line_view = [[UIView alloc] initWithFrame:CGRectMake(0,5.5,320,0.5)];
        
        view_line_view.backgroundColor = RGBCOLOR(216,215,216);
        
        [view addSubview:view_line_view];
        
        
    }
    return self;
}


-(void)setAllViewWithPerson:(PersonInfo *)info type:(int)type
{
    
    if (_data_array)
    {
        [_data_array removeAllObjects];
    }
    
    BOOL is_shangjia = NO;
    
    
    if ([info.is_shangjia isEqualToString:@"1"])
    {
        is_shangjia = YES;
    }
    
    
    NSString * myUid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
    
    if (![myUid isEqualToString:info.uid])
    {
        _sendMessage_button.hidden = NO;
        
        _attention_button.hidden = NO;
    }
    
    
    
    if (info.uid.length == 0)
    {
        _background_imageview.image = [UIImage imageNamed:@"new_banner.jpg"];
    }else
    {
        if (is_shangjia)
        {
            [_background_imageview loadImageFromURL:[self qiyeUrl:info.userface] withPlaceholdImage:[UIImage imageNamed:@"underPageBackGround@2x.png"]];
        }else
        {
            [_background_imageview loadImageFromURL:[self returnUrl] withPlaceholdImage:[UIImage imageNamed:@"underPageBackGround@2x.png"]];
        }
    }
    
    
    
    
    [_header_imageview loadImageFromURL:info.face_original withPlaceholdImage:[UIImage imageNamed:@"touxiang.png"]];
    
    _username_label.text = info.username;
    
    
    
    if ([info.isbuddy intValue] == 1)
    {//已关注
        attention_flg = YES;
        
    }else if([info.isbuddy intValue] == 0)
    {//未关注
        attention_flg = NO;
    }
    
    [_attention_button setImage:[UIImage imageNamed:attention_flg?@"cancelguanzhu.png":@"guanzhuios7.png"] forState:UIControlStateNormal];
    
    
    
    int count = 0;
    
    NSMutableArray * count_array;
    
    if (is_shangjia)
    {
        if ([info.bbsposts intValue] == 0)
        {
            count = 7;
            _data_array = [NSMutableArray arrayWithObjects:@"详细\n资料",@"资讯",@"微博",@"关注",@"粉丝",@"地图",@"二维码",nil];
            count_array = [NSMutableArray arrayWithObjects:@"",info.service_sernum,info.topic_count,@"",info.follow_count,info.fans_count,@"",nil];
        }else
        {
            count = 8;
            _data_array = [NSMutableArray arrayWithObjects:@"详细\n资料",@"资讯",@"微博",@"论坛",@"关注",@"粉丝",@"地图",@"二维码",nil];
            count_array = [NSMutableArray arrayWithObjects:@"",info.service_sernum,info.topic_count,info.bbsposts,info.follow_count,info.fans_count,@"",nil];
        }
    }else
    {
        count = 7;
        _data_array = [NSMutableArray arrayWithObjects:@"详细\n资料",@"关注",@"粉丝",@"文集",@"画廊",@"圈子",@"二维码",nil];
        
        count_array = [NSMutableArray arrayWithObjects:@"",info.follow_count,info.fans_count,info.blog_count,info.album_count,info.circle_createcount,@"",nil];
    }
    
    
    
    for (int i = 0;i < count;i++)
    {
        if (i < count-1)
        {
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(127/2 + (127/2+0.5)*i,10,0.5,30)];
            
            line_view.backgroundColor = RGBCOLOR(205,205,205);
            
            [_tap_background_view addSubview:line_view];
        }
        
        NSString * title_string = [_data_array objectAtIndex:i];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(3.5/2+63.5*i,0,60,50);
        
        button.tag = 1000+i;
        
        [button setTitleColor:RGBCOLOR(76,76,76) forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitle:title_string forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(18,0,0,0)];
        
        [_tap_background_view addSubview:button];
        
        
        if ([title_string isEqualToString:@"详细\n资料"] || [title_string isEqualToString:@"地图"] || [title_string isEqualToString:@"二维码"])
        {
            button.titleLabel.numberOfLines = 0;
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
        }else
        {
            NSString * num = [count_array objectAtIndex:i];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,60,30)];
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label.font=[UIFont systemFontOfSize:14];
            
            label.text = num.length?num:@"0";
            
            label.textColor = RGBCOLOR(89,106,149);
            
            label.backgroundColor = [UIColor clearColor];
            
            [button addSubview:label];
        }
        
        
        
        if ([title_string isEqualToString:@"微博"] || [title_string isEqualToString:@"文集"] || [title_string isEqualToString:@"画廊"] || [title_string isEqualToString:@"圈子"]) {
            [button setTitleColor:RGBCOLOR(142,142,142) forState:UIControlStateNormal];
        }
        
        
        
    }
    
    _tap_background_view.contentSize = CGSizeMake((127/2)*count + (count-1)/2,0);
}



-(void)doButton:(UIButton *)sender
{
    int index = 0;
    
    NSString * string = [self.data_array objectAtIndex:sender.tag-1000];
    
    if ([string isEqualToString:@"资讯"])
    {
        index = 1;
    }else if ([string isEqualToString:@"微博"])
    {
        index = 2;
    }else if ([string isEqualToString:@"论坛"])
    {
        index = 3;
    }else if ([string isEqualToString:@"地图"])
    {
        index = 4;
    }else if ([string isEqualToString:@"关注"])
    {
        index = 5;
    }else if ([string isEqualToString:@"粉丝"])
    {
        index = 6;
    }else if ([string isEqualToString:@"文集"])
    {
        index = 7;
    }else if ([string isEqualToString:@"画廊"])
    {
        index = 8;
    }else if ([string isEqualToString:@"圈子"])
    {
        index = 9;
    }else if ([string isEqualToString:@"二维码"])
    {
        index = 10;
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickButtonWithIndex:)])
    {
        [_delegate clickButtonWithIndex:index];
    }
}

-(void)sendMessage:(UIButton *)sender
{
    //写私信
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessageClick)])
    {
        [_delegate sendMessageClick];
    }
    
}


-(void)sendAttention:(UIButton *)sender
{
    //加关注 取消关注
    
    attention_flg = !attention_flg;
    
    [_attention_button setImage:[UIImage imageNamed:attention_flg?@"cancelguanzhu.png":@"guanzhuios7.png"] forState:UIControlStateNormal];
    
    if (_delegate && [_delegate respondsToSelector:@selector(attentionClick)])
    {
        [_delegate attentionClick];
    }
}


-(NSString *)qiyeUrl:(NSString *)theUrl
{
    return [NSString stringWithFormat:@"http://fb.cn/%@",theUrl];
}

-(NSString *)returnUrl
{
    NSString * uid = self.info.uid;
    
    if (uid.length !=0 && uid.length < 6)
    {
        for (int i = 0;i < uid.length -6;i++)
        {
            uid = [NSString stringWithFormat:@"%d%@",0,uid];
        }
    }
    
    NSString * string;
    if (uid.length ==0)
    {
        string = @"";
    }else
    {
        string =  [NSString stringWithFormat:@"http://fb.fblife.com/./images/userface/000/%@/%@/face_%@_0.jpg",[[uid substringToIndex:2] substringFromIndex:0],[[uid substringToIndex:4] substringFromIndex:2],[[uid substringToIndex:6] substringFromIndex:4]];
    }
    
    return string;
}


#pragma mark-AsyncImageViewDelegate

-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image
{
    
}


-(void)seccesDownLoad:(UIImage *)image
{
    if (image)
    {
        if (![self.info.is_shangjia intValue])
        {
            _background_imageview.frame = CGRectMake(0,0,_background_imageview.image.size.width*97.5/_background_imageview.image.size.height,195/2);
            
        }else
        {
            _background_imageview.frame = CGRectMake(0,0,320,195/2);
        }
        
        _background_imageview.center = CGPointMake(160,97.5/2);
    }else
    {
        _background_imageview.image = [UIImage imageNamed:@"new_banner.jpg"];
    }
}

-(void)failedDownLoad
{
    NSLog(@"下载图片失败");
}



-(void)handleImageLayout:(AsyncImageView *)tag
{
    
}


@end










