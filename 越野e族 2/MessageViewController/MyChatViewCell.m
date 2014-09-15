//
//  MyChatViewCell.m
//  FbLife
//
//  Created by soulnear on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "MyChatViewCell.h"
#import "NSString+JSMessagesView.h"
#import "fbWebViewController.h"


#define kMarginTop 8.0f
#define kMarginBottom 4.0f
#define kPaddingTop 4.0f
#define kPaddingBottom 8.0f
#define kBubblePaddingRight 35.0f
#define image_width 81.0f
#define image_height 70.0f

@implementation MyChatViewCell
@synthesize timestampLabel = _timestampLabel;
@synthesize avatarImageView = _avatarImageView;

@synthesize background_imageView = _background_imageView;

@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


#pragma mark - Setup
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.imageView.image = nil;
    self.imageView.hidden = YES;
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.detailTextLabel.text = nil;
    self.detailTextLabel.hidden = YES;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(handleLongPress:)];
    [recognizer setMinimumPressDuration:0.4];
    [self addGestureRecognizer:recognizer];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
    
}


-(void)loadAllViewWithUrl:(ChatInfo *)info Style:(MyChatViewCellType)type
{
    
    CGPoint point = [self returnHeightWithArray:[zsnApi stringExchange:info.msg_message] WithType:type];
    
    UIImage * image = [UIImage imageNamed:type == JSBubbleMessageTypeOutgoing ?@"talk1.png":@"talk2.png"];
    
    
    _background_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(type == JSBubbleMessageTypeOutgoing?(320 - point.x - 65):50,34,point.x+15,point.y)];
    
    _background_imageView.userInteractionEnabled = YES;
    
    /*
     CALayer * layer = [theView layer];
     
     [layer setShadowOffset:theOffset];
     [layer setShadowRadius:theRadius];
     [layer setShadowOpacity:theOpacity];
     [layer setShadowColor:theColor.CGColor];
     
     
     其中:theView(UIView)为目标view
     theOffset(CGSize)为阴影偏移量,默认为(0, -3)
     theRadius(float)为阴影四角圆角半径,默认值为3
     theOpacity(float)为阴影透明度(取值为[0,1])
     theColor(UIColor)为阴影颜色
     
     */
    //    CALayer * layer = [_background_imageView layer];
    //
    //    [layer setShadowOffset:CGSizeMake(1.5, 1.5)];
    //    [layer setShadowRadius:3];
    //    [layer setShadowOpacity:0.7];
    //    [layer setShadowColor:[UIColor grayColor].CGColor];
    
    
    
    //    CGFloat top = 20.f; // 顶端盖高度
    //    CGFloat bottom = 10.f ; // 底端盖高度
    //    CGFloat left = 10.f; // 左端盖宽度
    //    CGFloat right = 10.f; // 右端盖宽度
    //    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    //    // 伸缩后重新赋值
    //  //  image = [image resizableImageWithCapInsets:insets];
    //
    
    _background_imageView.image = [image stretchableImageWithLeftCapWidth:15.f topCapHeight:10.f];
    
    [self.contentView addSubview:_background_imageView];
    
    
    self.timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(105,5,110,16)];
    
    self.timestampLabel.textAlignment = NSTextAlignmentCenter;
    
    self.timestampLabel.backgroundColor = [UIColor clearColor];
    
    self.timestampLabel.layer.cornerRadius = 8;
    
    self.timestampLabel.backgroundColor = [RGBCOLOR(245,245,245) colorWithAlphaComponent:0.8];
    
    self.timestampLabel.textAlignment = NSTextAlignmentCenter;
    
    self.timestampLabel.textColor = RGBCOLOR(125,123,124);
    
    
    NSString *str___=[NSString stringWithFormat:@"%@",info.date_now];
    if (str___.length==0||[str___ isEqualToString:@"(null)"]) {
        self.timestampLabel.text=[personal mycurrenttime];
    }else{
        self.timestampLabel.text = [zsnApi timechange1:info.date_now];
        
    }
    
    
    self.timestampLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:self.timestampLabel];
    
    
    
    [self loadHeadImageViewWithUrl:[zsnApi returnUrl:info.from_uid] Style:type];
    
    [self loadContentViewWithArray:[zsnApi stringExchange:info.msg_message] WithType:type];
    
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    UIImageView * imageView = (UIImageView *)sender.view;
    if (delegate && [delegate respondsToSelector:@selector(showImageDetail:)])
    {
        [delegate showImageDetail:imageView.image];
    }
}



-(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label
{
    float theLastWidth = 0;
    NSArray * array = [string componentsSeparatedByString:@"\n"];
    
    if (array.count > 1)
    {
        for (NSString * str in array)
        {
            CGSize titleSize = [[str stringByAppendingString:@"哈"] sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            theLastWidth = titleSize.width>theLastWidth?titleSize.width:theLastWidth;
        }
    }else
    {
        CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        theLastWidth = titleSize.width>theLastWidth?titleSize.width:theLastWidth;
    }
    
    
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGPoint lastPoint;
    CGSize sz = [string sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT,40)];//原来为40
    CGSize linesSz = [string sizeWithFont:label.font constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if(sz.width <= linesSz.width) //判断是否折行
    {
        lastPoint = CGPointMake(label.frame.origin.x + sz.width,linesSz.height);
    }else
    {
        lastPoint = CGPointMake(label.frame.origin.x + (int)sz.width % (int)linesSz.width,  titleSize.height+((titleSize.height/20)-1)*3);
    }
    lastPoint = CGPointMake(theLastWidth>lastPoint.x?theLastWidth:lastPoint.x,lastPoint.y);
    return lastPoint;
}


-(void)handleImageLayout:(AsyncImageView *)tag
{
    if (!tag.image)
    {
        tag.contentMode = UIViewContentModeScaleAspectFill;
        tag.clipsToBounds = YES;
        tag.image = [personal getImageWithName:@"url_image_failed"];
    }
}

-(void)seccesDownLoad:(UIImage *)image
{
    
}


-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image
{
    if (!image)
    {
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [personal getImageWithName:@"url_image_failed"];
    }else
    {
        //        UIImage * newImage = [personal scaleToSizeWithImage:image size:CGSizeMake(image.size.width > 240?image.size.width/3:image.size.width,image.size.height>210?image.size.height/3:image.size.height)];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.clipsToBounds = YES;
        //        imageView.image = newImage;
    }
}


-(void)loadContentViewWithArray:(NSArray *)array WithType:(MyChatViewCellType)theType
{
    
    float theHeight = 0;
    
    float distance = 10;
    
    for (NSString * string in array)
    {
        NSLog(@"string ------   %@",string);
        if (string.length > 0)
        {
            if ([string rangeOfString:@"[img]"].length && [string rangeOfString:@"[/img]"].length)
            {
                NSString * url = [string stringByReplacingOccurrencesOfString:@"[img]" withString:@""];
                
                url = [url stringByReplacingOccurrencesOfString:@"[/img]" withString:@""];
                
                AsyncImageView * imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(theType ==JSBubbleMessageTypeIncoming?10:5,theHeight?theHeight+distance:5,image_width,image_height)];
                
                imageView.delegate = self;
                
                imageView.backgroundColor = [UIColor clearColor];
                
                [imageView loadImageFromURL:url withPlaceholdImage:[personal getImageWithName:@"url_image_loading"]];
                
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
                
                [_background_imageView addSubview:imageView];
                
                
                imageView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
                
                [imageView addGestureRecognizer:tap];
                
                
                theHeight += image_height;
                
            }else
            {
                NSString * clean_string = string;
                
                while ([clean_string rangeOfString:@"[url]"].length && [clean_string rangeOfString:@"[/url]"].length)
                {
                    NSString * theurl = [[clean_string substringToIndex:[clean_string rangeOfString:@"[/url]"].location] substringFromIndex:[clean_string rangeOfString:@"[url]"].location+5];
                    
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[url]" withString:[NSString stringWithFormat:@"<a href=\"%@\">",theurl]];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[/url]" withString:@"</a>"];
                }
                
                
                
                CGRect content_frame = CGRectMake(theType ==JSBubbleMessageTypeIncoming?10:5,theHeight?theHeight:5,250,50);
                
                RTLabel * content_label = [[RTLabel alloc] initWithFrame:content_frame];
                
                content_label.text = clean_string;
                
                content_label.backgroundColor = [UIColor clearColor];
                
                content_label.font = [UIFont systemFontOfSize:15];
                
                content_label.lineBreakMode = NSLineBreakByCharWrapping;
                
                
                CGSize optimumSize = [content_label optimumSize];
                
                content_frame.size.height = optimumSize.height + 10;
                
                content_label.frame = content_frame;
                
                [_background_imageView addSubview:content_label];
                
                theHeight = theHeight + optimumSize.height;
            }
        }
    }
}


-(void)showClickUrl:(NSString *)url
{
    
    while ([url rangeOfString:@" "].length)
    {
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@"&"];
    }
    
    NSLog(@"点击的链接地址 = %@",url);
    if (delegate && [delegate respondsToSelector:@selector(showClickUrlDetail:)])
    {
        [delegate showClickUrlDetail:url];
    }
    
    
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


-(void)loadHeadImageViewWithUrl:(NSString *)url Style:(MyChatViewCellType)type
{
    CGFloat avatarX = 10; //0.5f +5.5;
    
    if(type == JSBubbleMessageTypeOutgoing)
    {
        avatarX = (self.contentView.frame.size.width - kJSAvatarSize - 10);
    }
    
    self.avatarImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(avatarX,
                                                                            33,
                                                                            kJSAvatarSize,
                                                                            kJSAvatarSize)];
    
    
    self.avatarImageView.layer.cornerRadius = 5;
    
    self.avatarImageView.layer.borderColor = (__bridge  CGColorRef)([UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]);
    
    self.avatarImageView.layer.borderWidth =1.0;
    
    self.avatarImageView.layer.masksToBounds = YES;
    
    
    //    self.avatarImageView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
    //                                             | UIViewAutoresizingFlexibleLeftMargin
    //                                             | UIViewAutoresizingFlexibleRightMargin);
    [self.contentView addSubview:self.avatarImageView];
    
    
    [self.avatarImageView loadImageFromURL:url withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
}


#pragma mark-tool


-(CGPoint)returnHeightWithArray:(NSArray *)array WithType:(MyChatViewCellType)theType
{
    float theWidth = 0;
    
    float theHeight = 0;
    
    for (NSString * string in array)
    {
        if (string.length > 0)
        {
            if ([string rangeOfString:@"[img]"].length && [string rangeOfString:@"[/img]"].length)
            {
                theWidth = theWidth>image_width+5?theWidth:image_width+5;
                
                theHeight = theHeight + image_height+5;
            }else
            {
                NSString * clean_string = string;
                
                while ([clean_string rangeOfString:@"[url]"].length && [clean_string rangeOfString:@"[/url]"].length)
                {
                    NSString * theurl = [[clean_string substringToIndex:[clean_string rangeOfString:@"[/url]"].location] substringFromIndex:[clean_string rangeOfString:@"[url]"].location+5];
                    
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[url]" withString:[NSString stringWithFormat:@"<a href=\"%@\">",theurl]];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[/url]" withString:@"</a>"];
                }
                
                
                
                CGRect content_frame = CGRectMake(theType ==JSBubbleMessageTypeIncoming?10:5,theHeight?theHeight:5,250,50);
                
                RTLabel * content_label = [[RTLabel alloc] initWithFrame:content_frame];
                
                content_label.text = clean_string;
                
                content_label.font = [UIFont systemFontOfSize:15];
                
                content_label.lineBreakMode = NSLineBreakByCharWrapping;
                
                
                CGSize optimumSize = [content_label optimumSize];
                
                content_frame.size.height = optimumSize.height + 10;
                
                content_label.frame = content_frame;
                
                theHeight = theHeight + optimumSize.height + 5;
                
                theWidth = optimumSize.width>theWidth?optimumSize.width:theWidth;

                if (optimumSize.width >= 240 || optimumSize.width == 0)
                {
                    theWidth = 245;
                }
            }
        }
    }
    if (theHeight>50&&theHeight<120)
    {
        theHeight=theHeight;
    }
    return CGPointMake(theWidth,theHeight+5);
}


-(CGSize)textSizeForText:(NSString *)txt
{
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width * 0.75f;
    CGFloat height = MAX([self numberOfLinesForMessage:txt],
                         [txt numberOfLines]) * [self textViewLineHeight];
    
    return [txt sizeWithFont:[self thefont]
           constrainedToSize:CGSizeMake(width - kJSAvatarSize, height + kJSAvatarSize)
               lineBreakMode:NSLineBreakByWordWrapping];
}

-(int)numberOfLinesForMessage:(NSString *)txt
{
    return (txt.length / [self maxCharactersPerLine]) + 1;
}


-(CGFloat)textViewLineHeight
{
    return 30.0f; // for fontSize 15.0f
}


-(UIFont *)thefont
{
    return [UIFont systemFontOfSize:16.0f];
}

-(int)maxCharactersPerLine
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

@end





















