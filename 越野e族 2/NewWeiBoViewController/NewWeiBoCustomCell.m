//
//  NewWeiBoCustomCell.m
//  FbLife
//
//  Created by soulnear on 13-11-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "NewWeiBoCustomCell.h"

#define LABEL_FONT [UIFont systemFontOfSize:15]


@implementation NewWeiBoCustomCell

@synthesize delegate = _delegate;
@synthesize Head_ImageView = _Head_ImageView;
@synthesize UserName_Label = _UserName_Label;
@synthesize DateLine_Label = _DateLine_Label;
@synthesize from_label = _from_label;

@synthesize reply_background_view = _reply_background_view;

@synthesize content_view_special = _content_view_special;

@synthesize content_reply_special = _content_reply_special;

@synthesize pinglun_button = _pinglun_button;
@synthesize zhuanfa_button = _zhuanfa_button;
@synthesize delete_button = _delete_button;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //        [self setAllView];
    }
    return self;
}


-(void)setAllViewWithType:(int)theType
{
    if (theType == 0)
    {
        if (!_Head_ImageView)
        {
            _Head_ImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(10,10,CELL_TOUXIANG,CELL_TOUXIANG)];
            _Head_ImageView.layer.shadowColor = [UIColor blackColor].CGColor;
            
            _Head_ImageView.layer.shadowOffset = CGSizeMake(0.3,0.3);
            
            _Head_ImageView.layer.shadowRadius = 1;
            
            _Head_ImageView.layer.shadowOpacity = 0.2;
            _Head_ImageView.layer.masksToBounds = NO;
            _Head_ImageView.userInteractionEnabled = YES;
            [self.contentView addSubview:_Head_ImageView];
            
            UITapGestureRecognizer * head_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
            [_Head_ImageView addGestureRecognizer:head_tap];
        }else
        {
            _Head_ImageView.image = nil;
        }
        
        
        if (!_UserName_Label)
        {
            _UserName_Label = [[UILabel alloc] initWithFrame:CGRectMake(55,7,200,20)];
            _UserName_Label.backgroundColor = [UIColor clearColor];
            _UserName_Label.font = [UIFont boldSystemFontOfSize:15];
            _UserName_Label.textColor = RGBCOLOR(89,106,149);
            _UserName_Label.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_UserName_Label];
        }else
        {
            _UserName_Label.text = nil;
        }
        
        
        if (!_DateLine_Label)
        {
            _DateLine_Label = [[UILabel alloc] initWithFrame:CGRectMake(250,10,60,20)];
            _DateLine_Label.backgroundColor = [UIColor clearColor];
            _DateLine_Label.font = [UIFont systemFontOfSize:12];
            _DateLine_Label.textColor = RGBCOLOR(142,142,142);
            _DateLine_Label.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_DateLine_Label];
            
        }else
        {
            _DateLine_Label.text = nil;
        }
        
        
        if (!_from_label)
        {
            _from_label = [[UILabel alloc] initWithFrame:CGRectMake(55,10,100,20)];
            
            _from_label.textColor = RGBCOLOR(142,142,142);
            
            _from_label.textAlignment = NSTextAlignmentLeft;
            
            _from_label.font = [UIFont systemFontOfSize:12];
            
            _from_label.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_from_label];
        }
        
        
        
        if (!_content_view_special)
        {
            _content_view_special = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(55,35,255,100)];
            _content_view_special.delegate = self;
            _content_view_special.line_space = 3;
            _content_view_special.content_font = 16;
            [self.contentView addSubview:_content_view_special];
        }else
        {
            [_content_view_special Reset];
        }
        
        
        
        if (!_reply_background_view)
        {
            _reply_background_view = [[UIImageView alloc] initWithFrame:CGRectMake(55,0,255,0)];
            
            _reply_background_view.userInteractionEnabled = YES;
            
            [self.contentView addSubview:_reply_background_view];
        }
        
        if (!_content_reply_special)
        {
            _content_reply_special = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(8,10,255-16,0)];
            _content_reply_special.delegate = self;
            _content_reply_special.line_space = 3;
            _content_reply_special.content_font = 16;
            [_reply_background_view addSubview:_content_reply_special];
        }else
        {
            [_content_reply_special Reset];
        }
        
    }else
    {
        if (!_DateLine_Label)
        {
            _DateLine_Label = [[UILabel alloc] initWithFrame:CGRectMake(12,12,100,20)];
            _DateLine_Label.backgroundColor = [UIColor clearColor];
            _DateLine_Label.font = [UIFont systemFontOfSize:12];
            _DateLine_Label.textColor = RGBCOLOR(142,142,142);
            _DateLine_Label.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_DateLine_Label];
            
        }else
        {
            _DateLine_Label.text = nil;
        }
        
        
        if (!_delete_button)
        {
            _delete_button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _delete_button.frame = CGRectMake(270,10,60,20);
            
            [_delete_button setTitle:@"删除" forState:UIControlStateNormal];
            
            [_delete_button setTitleColor:RGBCOLOR(142,142,142) forState:UIControlStateNormal];
            
            _delete_button.hidden = YES;
            
            _delete_button.titleLabel.font = [UIFont systemFontOfSize:12];
            
            _delete_button.backgroundColor = [UIColor clearColor];
            
            [_delete_button addTarget:self action:@selector(deleteMyWeiBo:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:_delete_button];
        }
        
        
        
        if (!_from_label)
        {
            _from_label = [[UILabel alloc] initWithFrame:CGRectMake(10,10,100,20)];
            
            _from_label.textColor = RGBCOLOR(142,142,142);
            
            _from_label.textAlignment = NSTextAlignmentLeft;
            
            _from_label.font = [UIFont systemFontOfSize:12];
            
            _from_label.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_from_label];
        }
        
        
        if (!_content_view_special)
        {
            _content_view_special = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(10,40,300,100)];
            _content_view_special.delegate = self;
            _content_view_special.line_space = 3;
            _content_view_special.content_font = 16;
            [self.contentView addSubview:_content_view_special];
        }else
        {
            [_content_view_special Reset];
        }
        
        
        
        if (!_reply_background_view)
        {
            _reply_background_view = [[UIImageView alloc] initWithFrame:CGRectMake(10,0,300,0)];
            
            _reply_background_view.userInteractionEnabled = YES;
            
            [self.contentView addSubview:_reply_background_view];
        }
        
        if (!_content_reply_special)
        {
            _content_reply_special = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(8,10,300-16,0)];
            _content_reply_special.delegate = self;
            _content_reply_special.line_space = 3;
            _content_reply_special.content_font = 16;
            [_reply_background_view addSubview:_content_reply_special];
        }else
        {
            [_content_reply_special Reset];
        }
    }
    
    
    
    
    if (!_pinglun_button)
    {
        _pinglun_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _pinglun_button.frame = CGRectMake(100,200,40,20);
        _pinglun_button.backgroundColor = [UIColor clearColor];
        [_pinglun_button setImage:[UIImage imageNamed:@"pinglun-xiao.png"] forState:UIControlStateNormal];
        [_pinglun_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _pinglun_button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_pinglun_button setTitle:@"0" forState:UIControlStateNormal];
        [_pinglun_button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
        [_pinglun_button setImageEdgeInsets:UIEdgeInsetsMake(2,0,0,15)];
        [_pinglun_button addTarget:self action:@selector(ToPinglun:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_pinglun_button];
    }
    
    if (!_zhuanfa_button)
    {
        _zhuanfa_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhuanfa_button.frame = CGRectMake(100,200,40,20);
        _zhuanfa_button.backgroundColor = [UIColor clearColor];
        [_zhuanfa_button setImage:[UIImage imageNamed:@"zhuanfa-xiao.png"] forState:UIControlStateNormal];
        [_zhuanfa_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _zhuanfa_button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_zhuanfa_button setTitle:@"0" forState:UIControlStateNormal];
        [_zhuanfa_button setImageEdgeInsets:UIEdgeInsetsMake(0,0,1,15)];
        [_zhuanfa_button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
        [_zhuanfa_button addTarget:self action:@selector(ToZhuanFa:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_zhuanfa_button];
    }
}

-(float)setInfo:(FbFeed *)info withReplysHeight:(float)theheight WithType:(int)theType
{
    float total_height = 0;
    
    _weiboInfo = info;
    
    
    NSString * MyName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    
    if ([MyName isEqualToString:info.userName])
    {
        _delete_button.hidden = NO;
    }
    
    
    if (theType == 0)
    {
        [_Head_ImageView loadUserHeaderImageFromUrl:info.face_original_url withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
        
        _UserName_Label.text = info.userName;
    }
    
    
    _DateLine_Label.text = [personal timestamp:info.dateline];
    
    CGRect reply_frame = [_reply_background_view frame];
    
    reply_frame.size.height = 0;
    
    _reply_background_view.frame = reply_frame;
    
    _reply_background_view.image = nil;
    
    
    //0:微博  2:文集  3:图集  4:论坛帖子转发微博  5:论坛分享 6:新闻评论 8:新闻分享  10:资源分享
    
    
    CGRect rect = [_content_view_special frame];
    
    rect.size.height = [_content_view_special setAllViewWithFeed:_weiboInfo isReply:NO];
    
    _content_view_special.frame = rect;
    
    total_height = rect.size.height;
    
    reply_frame.origin.y = rect.size.height + 40 + 3;
    
    
    if (info.rootFlg)
    {
        CGRect rect1 = [_content_reply_special frame];
        
        rect1.size.height = [_content_reply_special setAllViewWithFeed:_weiboInfo isReply:YES];
        
        _content_reply_special.frame = rect1;
        
        reply_frame.size.height = rect1.size.height + 30;
        
        total_height = total_height + rect1.size.height + 30;
        
        _reply_background_view.frame = reply_frame;
        
        _reply_background_view.image = [[UIImage imageNamed:@"newWeiBoBackGroundImage.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
    }
    
    _pinglun_button.frame = CGRectMake(280,theheight - 30,40,20);
    [_pinglun_button setTitle:info.replys forState:UIControlStateNormal];
    
    _zhuanfa_button.frame = CGRectMake(240,theheight - 30,40,20);
    [_zhuanfa_button setTitle:info.forwards forState:UIControlStateNormal];
    
    
    _from_label.text = info.from;
    
    _from_label.frame = CGRectMake(_from_label.frame.origin.x,theheight-30,100,20);
    
    return total_height + 35;
}


-(void)deleteMyWeiBo:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteSomeWeiBoContent:)])
    {
        [_delegate deleteSomeWeiBoContent:self];
    }
}


-(void)ToPinglun:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(presentToCommentControllerWithInfo: WithCell:)])
    {
        [_delegate presentToCommentControllerWithInfo:_weiboInfo WithCell:self];
    }
}

-(void)ToZhuanFa:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(presentToFarwardingControllerWithInfo: WithCell:)])
    {
        [_delegate presentToFarwardingControllerWithInfo:_weiboInfo WithCell:self];
    }
}

-(void)setReplys:(NSString *)theReplys ForWards:(NSString *)theForWards
{
    [self.pinglun_button setTitle:theReplys forState:UIControlStateNormal];
    
    [self.zhuanfa_button setTitle:theForWards forState:UIControlStateNormal];
}


-(void)headTap:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickHeadImage:)])
    {
        [self.delegate clickHeadImage:_weiboInfo.uid];
    }
}


-(void)clickPicture:(int)index WithIsReply:(BOOL)isRe
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showImage:isReply: WithIndex:)])
    {
        [self.delegate showImage:_weiboInfo isReply:isRe WithIndex:index];
    }
}



#pragma mark-normalDelegate


-(void)NormalClickUrl:(NSString *)theUrl withIsRe:(BOOL)isreply
{
    [self clickURL:theUrl isRe:isreply];
}


-(void)NormalClickPictures:(int)index WithIsRe:(BOOL)isRe
{
    [self showImageDtailWithIndex:index isRe:isRe];
}


#pragma mark-specialDelegate

-(void)SpecialClickOriginalContent
{
    if (_delegate && [_delegate respondsToSelector:@selector(showOriginalWeiBoContent:)])
    {
        [_delegate showOriginalWeiBoContent:_weiboInfo.rtid];
    }
}

-(void)SpecialPlayVideoWithReply:(BOOL)isRe
{
    if (_delegate && [_delegate respondsToSelector:@selector(showVideoWithUrl:)])
    {
        [_delegate showVideoWithUrl:isRe?_weiboInfo.rolink:_weiboInfo.olink];
    }
}

-(void)SpecialClickUrl:(NSString *)theUrl WithIsRe:(BOOL)isreply
{
    [self clickURL:theUrl isRe:isreply];
}

-(void)SpecialClickPictures:(int)index WithIsRe:(BOOL)isRe
{
    [self showImageDtailWithIndex:index isRe:isRe];
}


-(void)showImageDtailWithIndex:(int)index isRe:(BOOL)isReply
{
    if (_delegate && [_delegate respondsToSelector:@selector(showImage:isReply:WithIndex:)])
    {
        [_delegate showImage:_weiboInfo isReply:isReply WithIndex:index];
    }
}



-(void)clickURL:(NSString *)theUrl isRe:(BOOL)isReply
{
    if ([theUrl rangeOfString:@"http://"].length || [theUrl rangeOfString:@"https://"].length)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showClickUrl: WithFBFeed:)])
        {
            [self.delegate showClickUrl:theUrl WithFBFeed:_weiboInfo];
        }
    }else
    {
        if (([theUrl rangeOfString:@"atSomeone@"].length || [theUrl rangeOfString:@"fb://PhotoDetail/id="].length) && self.delegate && [self.delegate respondsToSelector:@selector(showAtSomeBody: WithFBFeed:)])
        {NSLog(@"多少啊----%@---%@",_weiboInfo.ruserName,theUrl);
            [self.delegate showAtSomeBody:theUrl WithFBFeed:_weiboInfo];
        }else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(clickUrlToShowWeiBoDetailWithInfo:WithUrl:isRe:)])
            {
                [_delegate clickUrlToShowWeiBoDetailWithInfo:_weiboInfo WithUrl:theUrl isRe:isReply];
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}





-(float)returnCellHeightWith:(FbFeed *)info WithType:(int)theType
{
    float total_height = 0;
    
    //0:微博  2:文集  3:图集  4:论坛帖子转发微博  5:论坛分享 6:新闻评论 8:新闻分享  10:资源分享
    
    CGRect rect = CGRectMake(55,theType?35:40,theType?300:255,100);
    
    if (!view_special)
    {
        view_special = [[WeiBoSpecialView alloc] initWithFrame:rect];
        view_special.line_space = 3;
        view_special.content_font = 16;
    }
    
    total_height = [view_special setAllViewWithFeed:info isReply:NO] + 40;
    
    
    if (info.rootFlg)
    {
        if (!content_v2)
        {
            content_v2 = [[WeiBoSpecialView alloc] initWithFrame:CGRectMake(8,10,(theType?300:255)-16,10)];
            content_v2.line_space = 3;
            content_v2.content_font = 16;
        }
        
        float the_height = [content_v2 setAllViewWithFeed:info isReply:YES];
        
        total_height = total_height + the_height + 10 + 30;
    }
    
    return total_height + 18;
}




//裁图


@end


















