//
//  WeiBoSpecialView.m
//  FbLife
//
//  Created by soulnear on 13-12-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "WeiBoSpecialView.h"
#import "RTLabel.h"
@class RTLabelComponent;
@class RTLabelExtractedComponent;

@implementation WeiBoSpecialView
@synthesize content_label = _content_label;
@synthesize title_label = _title_label;
@synthesize delegate = _delegate;
@synthesize pictureViews = _pictureViews;
@synthesize video_button = _video_button;
@synthesize original_pinglun_button = _original_pinglun_button;
@synthesize original_zhuanfa_button = _original_zhuanfa_button;
@synthesize original_line_view = _original_line_view;
@synthesize content_font = _content_font;
@synthesize line_space = _line_space;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)Reset
{
    _title_label.text = nil;
    _content_label.text = nil;
    _title_label.frame = CGRectMake(0,0,0,0);
    _content_label.frame = CGRectMake(0,0,0,0);
    _pictureViews.frame = CGRectMake(0,0,0,0);
    _original_line_view.frame = CGRectMake(0,0,0,0);
    _original_pinglun_button.frame = CGRectMake(0,0,0,0);
    _original_zhuanfa_button.frame = CGRectMake(0,0,0,0);
    
    for (UIView * view in _pictureViews.subviews)
    {
        [view removeFromSuperview];
    }
}



-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    if (_delegate && [_delegate respondsToSelector:@selector(SpecialClickUrl:WithIsRe:)])
    {
        [_delegate SpecialClickUrl:[url absoluteString] WithIsRe:isReplyssss];
    }
}


-(void)clickPicture:(int)index WithIsReply:(BOOL)isRe
{
    if (_delegate && [_delegate respondsToSelector:@selector(SpecialClickPictures:WithIsRe:)])
    {
        [_delegate SpecialClickPictures:index WithIsRe:isReplyssss];
    }
}



////////////////////////////////////////////



-(float)setAllViewWithFeed:(FbFeed *)info isReply:(BOOL)isReply
{
    isReplyssss = isReply;
    
    NSString * title_content = @"";
    
    NSString * content = @"";
    
    NSString * image_string = @"";
    
    NSString * sort = isReply?info.rsort:info.sort;
    
    NSString * oLink_string = @"";
    
    if ([sort intValue] == 0 || [sort intValue] == 3)
    {
        if (isReply)
        {
            content = info.rcontent;
            
            image_string = info.rimageFlg?info.rimage_small_url_m:@"";
            
            oLink_string = info.rolink;
        }else
        {
            content = info.content;
            
            image_string = info.imageFlg?info.image_small_url_m:@"";
            
            oLink_string = info.olink;
        }
        
    }else
    {
        if (isReply)
        {
            title_content = info.rtitle_content;
            
            content = info.rcontent;
            
            if (info.rimageFlg)
            {
                image_string = [[info.rimage_small_url_m componentsSeparatedByString:@"|"] objectAtIndex:0];
            }
            
            oLink_string = info.rolink;
            
        }else
        {
            title_content = info.title_content;
            
            content = info.content;
            
            if (info.imageFlg)
            {
                image_string = [[info.image_small_url_m componentsSeparatedByString:@"|"] objectAtIndex:0];
            }
            oLink_string = info.olink;
        }
    }
    
    
    float image_y = 0;
    
    float image_height = 0;
    
    CGRect rect1 = CGRectMake(0,0,self.frame.size.width,10);
    
    if (!_title_label)
    {
        _title_label = [[RTLabel alloc] init];
        
        _title_label.delegate = self;
        
        _title_label.lineSpacing = _line_space;
        
        _title_label.font = [UIFont systemFontOfSize:_content_font];
        
        _title_label.lineBreakMode = NSLineBreakByCharWrapping;
        
        _title_label.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_title_label];
    }else
    {
        _title_label.text = nil;
    }
    
    
    CGSize optimumSize1;
    
    if (title_content.length == 0)
    {
        
    }else
    {
        _title_label.frame = rect1;
        
        _title_label.text = [title_content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
        
        optimumSize1 = [_title_label optimumSize];
        
        rect1.size.height = optimumSize1.height + 10;
        
        image_y = optimumSize1.height;
        
        _title_label.frame = rect1;
        
        rect1.origin.y = optimumSize1.height + 5;
    }
    
    
    
    if (!_content_label)
    {
        _content_label = [[RTLabel alloc] init];
        
        _content_label.lineSpacing = _line_space;
        
        _content_label.delegate = self;
        
        _content_label.font = [UIFont systemFontOfSize:_content_font];
        
        _content_label.lineBreakMode = NSLineBreakByCharWrapping;
        
        [self addSubview:_content_label];
    }
    
    
    
    if (!_video_button)
    {
        _video_button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _video_button.frame = CGRectMake(0,0,54,39/2);
        
        _video_button.hidden = YES;
        
        [_video_button setImage:[UIImage imageNamed:@"filmios7.png"] forState:UIControlStateNormal];
        
        [_video_button addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_video_button];
    }else
    {
        _video_button.hidden = YES;
    }
    
    
    
    NSString *content_text = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    if (content.length == 0)
    {
        rect1.origin.y = 0;
    }else
    {
        _content_label.frame = rect1;
        
        _content_label.text = content_text;
        
        optimumSize1 = [_content_label optimumSize];
        
        rect1.size.height = optimumSize1.height + 10;
        
        image_y = image_y + optimumSize1.height;
        
        _content_label.frame = rect1;
        
        if ([oLink_string isEqual:[NSNull null]] || [oLink_string isEqualToString:@"(null)"] || oLink_string.length == 0 || [oLink_string isEqualToString:@"<null>"])
        {
            _video_button.hidden = YES;
        }else
        {
            _video_button.hidden = NO;
            CGRect video_frame = [_video_button frame];
            
            if (optimumSize1.width > self.frame.size.width-60)
            {
                NSString * _text = [_content_label.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
                RTLabelExtractedComponent *component = [RTLabel extractTextStyleFromText:_text paragraphReplacement:@"\n"];
                
                NSString * contentString = component.plainText;
                
                UILabel * testLabel = [[UILabel alloc] initWithFrame:_content_label.frame];
                
                CGPoint point = [zsnApi LinesWidth:contentString Label:testLabel font:[UIFont systemFontOfSize:14] linebreak:NSLineBreakByCharWrapping];
                
                
                if (self.frame.size.width - point.x > 60) {
                    
                    video_frame.origin.x = point.x+10;
                    
                    video_frame.origin.y = optimumSize1.height + _content_label.frame.origin.y-15.5;
                    
                }else{
                    
                    video_frame.origin.x = 0;
                    
                    video_frame.origin.y = _content_label.frame.origin.y + optimumSize1.height + 3;
                    
                    rect1.size.height += 39/2+3;
                }
                
                _video_button.frame = video_frame;
                
            }else
            {
                video_frame.origin.x = optimumSize1.width+2;
                video_frame.origin.y = _content_label.frame.origin.y + optimumSize1.height - 18;
                _video_button.frame = video_frame;
            }
            
        }
    }
    
    
    if (image_string.length > 0)
    {
        NSArray * array = [image_string componentsSeparatedByString:@"|"];
        
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
        
        _pictureViews.frame = CGRectMake(0,image_y+10,265,height);
        
        image_height = height + 10;
        
        [_pictureViews setImageUrls:image_string withSize:75 isjuzhong:NO];
    }
    
    
    float replys_height = 0;
    
    if (![info.rcontent isEqualToString:@"原微博已经删除"] && ![info.rsort isEqualToString:@"(null)"] && isReply && ([info.rsort intValue] == 0 || [info.rsort intValue] == 3 || [info.rsort intValue] == 2))
    {
        replys_height = 20;
        
        
//        if (!_original_zhuanfa_button)
//        {
            _original_zhuanfa_button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _original_zhuanfa_button.frame = CGRectMake(0,image_y+image_height+10,50,14);
            
            _original_zhuanfa_button.backgroundColor = [UIColor clearColor];
            
            [_original_zhuanfa_button setTitleColor:RGBCOLOR(89,106,150) forState:UIControlStateNormal];
            
            _original_zhuanfa_button.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [_original_zhuanfa_button setTitle:[NSString stringWithFormat:@"转发 %@",info.rforwards] forState:UIControlStateNormal];
            
            [_original_zhuanfa_button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,15)];
            
            [_original_zhuanfa_button addTarget:self action:@selector(ShowOriginalWeiBoContent:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_original_zhuanfa_button];
//        }
        
//        if (!_original_pinglun_button)
//        {
            _original_pinglun_button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _original_pinglun_button.frame = CGRectMake(62,image_y+image_height+10,50,14);
            
            _original_pinglun_button.backgroundColor = [UIColor clearColor];
            
            [_original_pinglun_button setTitleColor:RGBCOLOR(89,106,150) forState:UIControlStateNormal];
            
            _original_pinglun_button.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [_original_pinglun_button setTitle:[NSString stringWithFormat:@"评论 %@",info.rreplys] forState:UIControlStateNormal];
            
            [_original_pinglun_button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,15)];
            
            [_original_pinglun_button addTarget:self action:@selector(ShowOriginalWeiBoContent:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_original_pinglun_button];
//        }
        
        
        
//        if (!_original_line_view)
//        {
            _original_line_view = [[UIView alloc] initWithFrame:CGRectMake(50,image_y+image_height+12.5,0.5,19/2)];
            
            _original_line_view.backgroundColor = RGBCOLOR(189,189,189);
            
            [self addSubview:_original_line_view];
//        }
    }
    
    
    return rect1.size.height + rect1.origin.y - 10 + image_height+replys_height;
}

-(void)ShowOriginalWeiBoContent:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(SpecialClickOriginalContent)])
    {
        [_delegate SpecialClickOriginalContent];
    }
}


-(void)playVideo:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(SpecialPlayVideoWithReply:)])
    {
        [_delegate SpecialPlayVideoWithReply:isReplyssss];
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
