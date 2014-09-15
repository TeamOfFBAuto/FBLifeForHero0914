//
//  WeiBoNormalView.m
//  FbLife
//
//  Created by soulnear on 13-12-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "WeiBoNormalView.h"


#define LABEL_FONT [UIFont systemFontOfSize:15]


@implementation WeiBoNormalView
@synthesize weibo_content = _weibo_content;
@synthesize pictureViews = _pictureViews;
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



-(float)setAllViewWithFBFeed:(FbFeed *)info isReply:(BOOL)isReply
{
    isReplys = isReply;
    
    NSString * image_url = isReply?info.rimage_small_url_m:info.image_small_url_m;
    
    NSString * content = isReply?info.rcontent:info.content;
    
    float content_height = 0;
    
    float image_height = 0;
    
    CGRect rect1 = CGRectMake(0,0,self.frame.size.width,81);
    
    if (!_weibo_content)
    {
        _weibo_content = [[RTLabel alloc] init];
        
        _weibo_content.font = LABEL_FONT;
        
        _weibo_content.lineSpacing = 3;
        
        _weibo_content.textColor=[UIColor blackColor];
        
        _weibo_content.lineBreakMode = NSLineBreakByCharWrapping;
        
        _weibo_content.backgroundColor = [UIColor redColor];
        
        _weibo_content.delegate = self;
        
        [self addSubview:_weibo_content];
    }else
    {
        _weibo_content.text = nil;
    }
    
    _weibo_content.frame = rect1;
    
    _weibo_content.text = content;
    
    CGSize optimumSize = [_weibo_content optimumSize];
    
    rect1.size.height = optimumSize.height + 10;
    
    content_height = optimumSize.height;
    
    _weibo_content.frame = rect1;
    
    
    if (isReply?info.rimageFlg:info.imageFlg)
    {
        NSArray * array = [image_url componentsSeparatedByString:@"|"];
        
        int i = array.count/3;
        
        int j = array.count%3?1:0;
        
        float height = 75*(i+j)+2.5*(j + i - 1);
        
        if (!_pictureViews)
        {
            _pictureViews = [[PictureViews alloc] init];
            
            _pictureViews.delegate = self;
            
            [self addSubview:_pictureViews];
        }else
        {
            _pictureViews.frame = CGRectMake(0,0,0,0);
        }
        
        _pictureViews.frame = CGRectMake(0,content_height+10,265,height);
        
        image_height = height + 10;
        
        [_pictureViews setImageUrls:image_url withSize:75 isjuzhong:NO];
    }else
    {
        _pictureViews.frame = CGRectMake(0,0,0,0);
    }
    
    return content_height + image_height;
}


-(void)Reset
{
    _weibo_content.frame = CGRectMake(0,0,0,0);
    
    _weibo_content.text = nil;
    
    _pictureViews.frame = CGRectMake(0,0,0,0);
    
    for (UIView * view in _pictureViews.subviews)
    {
        [view removeFromSuperview];
    }
}


-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    if (_delegate && [_delegate respondsToSelector:@selector(NormalClickUrl:withIsRe:)])
    {
        [_delegate NormalClickUrl:[url absoluteString] withIsRe:isReplys];
    }
}


-(void)clickPicture:(int)index WithIsReply:(BOOL)isRe
{
    if (_delegate && [_delegate respondsToSelector:@selector(NormalClickPictures:WithIsRe:)])
    {
        [_delegate NormalClickPictures:index WithIsRe:isReplys];
    }
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
