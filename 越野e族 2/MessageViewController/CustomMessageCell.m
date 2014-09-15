//
//  CustomMessageCell.m
//  FbLife
//
//  Created by soulnear on 13-8-2.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CustomMessageCell.h"

@implementation CustomMessageCell
@synthesize headImageView = _headImageView;
@synthesize NameLabel = _NameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize contentLabel = _contentLabel;
@synthesize contentLabel1 = _contentLabel1;
@synthesize tixing_label = _tixing_label;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

-(void)setAllViewWithType:(int)type
{
    
    if (!_headImageView)
    {
        _headImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(11.5,13,50,50)];
        
        _headImageView.layer.masksToBounds = YES;
        
//        _headImageView.layer.cornerRadius = 2;
        
        [self.contentView addSubview:_headImageView];
        
    }else
    {
        _headImageView.image = nil;
    }
    
    
    if (type == 0)
    {
        if (!_NameLabel)
        {
            _NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(73,15,170,20)];
            
            _NameLabel.font = [UIFont systemFontOfSize:15];
            
            _NameLabel.backgroundColor = [UIColor clearColor];
            
            _NameLabel.textColor = RGBCOLOR(49,49,49);
            
            _NameLabel.textAlignment = NSTextAlignmentLeft;
            
            [self.contentView addSubview:_NameLabel];
        }else
        {
            _NameLabel.text = @"";
        }
        
        
        if (!_timeLabel)
        {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220,15,90,20)];
            
            _timeLabel.textAlignment = NSTextAlignmentRight;
            
            _timeLabel.backgroundColor = [UIColor clearColor];
            
            _timeLabel.font = [UIFont systemFontOfSize:11];
            
            _timeLabel.textColor = RGBCOLOR(181,181,181);
            
            [self.contentView addSubview:_timeLabel];
        }else
        {
            _timeLabel.text = @"";
        }
        
        
        if (!_contentLabel1)
        {
            _contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(73,40,240,20)];
            
            _contentLabel1.textColor = RGBCOLOR(120,120,120);
            
            _contentLabel1.backgroundColor = [UIColor clearColor];
            
            _contentLabel1.font = [UIFont systemFontOfSize:14];
            
            _contentLabel1.textAlignment = NSTextAlignmentLeft;
            
            [self.contentView addSubview:_contentLabel1];
        }else
        {
            _contentLabel1.text = @"";
        }
        
        if (!_tixing_label)
        {
            _tixing_label = [[UIImageView alloc] initWithFrame:CGRectMake(230,8,13,13)];
            
            _tixing_label.hidden = YES;
            
            _tixing_label.backgroundColor = [UIColor clearColor];
            
            _tixing_label.image = [personal getImageWithName:@"newlabel@2x"];
            
            _tixing_label.center = CGPointMake(61.5,13);
            
            [self.contentView addSubview:_tixing_label];
        }
    }else
    {
        if (!_contentLabel)
        {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(73,30,260,30)];
            
            _contentLabel.textColor = RGBCOLOR(120,120,120);
            
            _contentLabel.backgroundColor = [UIColor clearColor];
            
            _contentLabel.font = [UIFont systemFontOfSize:15];
            
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            
            [self.contentView addSubview:_contentLabel];
        }else
        {
            _contentLabel.text = @"";
        }
    }
}

-(float )boolLabelLength:(NSString *)strString
{
    CGSize labsize = [strString sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(170, 9999) lineBreakMode:NSLineBreakByCharWrapping];
    return labsize.width;
}

-(void)setInfoWithType:(int)type withMessageInfo:(MessageInfo *)info
{
    if (type == 0)
    {
        if ([info.from_uid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]])
        {
            [_headImageView loadImageFromURL:[zsnApi returnUrl:info.to_uid] withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
            
            _NameLabel.text = info.to_username;
            
        }else
        {
            [_headImageView loadImageFromURL:[zsnApi returnUrl:info.from_uid] withPlaceholdImage:[personal getImageWithName:@"touxiang"]];
            
            _NameLabel.text = info.from_username;
        }
        
        
        _timeLabel.text = [zsnApi timechange:info.date_now];
        
        _contentLabel1.text = [self eidtMessageContent:info.from_message];
        
        
        NSString * user = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
        
        NSString * userName;
        
        if ([user isEqualToString:info.from_uid])
        {
            userName = info.to_username;
        }else
        {
            userName = info.from_username;
        }
        
        
        if ([info.selfunread intValue] !=0)
        {
            _tixing_label.hidden = NO;
        }else
        {
            _tixing_label.hidden = YES;
        }
    }
}


-(NSString *)eidtMessageContent:(NSString *)message
{
    if ([message rangeOfString:@"[img]"].length && [message rangeOfString:@"[/img]"].length)
    {
        return @"[图片]";
    }
    
    if ([message rangeOfString:@"[url]"].length && [message rangeOfString:@"[/url]"].length)
    {
        return @"[链接]";
    }
    
    
    while ([message rangeOfString:@"&amp;"].length)
    {
        message = [message stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    }
    
    while ([message rangeOfString:@"nbsp;"].length)
    {
        message = [message stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    }
    
    while ([message rangeOfString:@" "].length)
    {
        message = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return message;
}


- (void) willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState:state];
    
    
    if (MY_MACRO_NAME)
    {
        return;
    }
    
    //UITableViewCellStateShowingDeleteConfirmationMask
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask)//删除状态
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            //            self.timeLabel.frame = CGRectMake(160,5,90,20);
            self.timeLabel.hidden = YES;
            self.contentLabel1.frame = CGRectMake(50,30,180,20);
        } completion:^(BOOL finished)
         {
             
         }];
        
        for (UIView *subview in self.subviews)
        {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"])
            {
                //this is delete button
            }
            
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellContentView"])
            {
                //this is contentView
                for (UIView *sub in subview.subviews) {
                    if ([NSStringFromClass([sub class]) isEqualToString:@"UILabel"])
                    {
                        UILabel *subLabel = (UILabel *)sub;
                        if (subLabel.tag == 8) {
                            subLabel.hidden = YES;
                        }
                    }
                    if ([NSStringFromClass([sub class]) isEqualToString:@"UIImageView"])
                    {
                        UILabel *subImageView = (UILabel *)sub;
                        if (subImageView.tag == 11)
                        {
                            subImageView.hidden = YES;
                        }
                    }
                }
            }
        }
    }
    //UITableViewCellStateDefaultMask
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateDefaultMask)//普通状态
    {
        [UIView animateWithDuration:0.3 animations:^{
            //            self.timeLabel.frame = CGRectMake(220,5,90,20);
            self.timeLabel.hidden = NO;
            self.contentLabel1.frame = CGRectMake(50,30,240,20);
        } completion:^(BOOL finished)
         {
             
         }];
        
        for (UIView *subview in self.subviews)
        {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"])
            {
                //this is delete button
            }
            
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellContentView"])
            {
                //this is contentView
                for (UIView *sub in subview.subviews)
                {
                    if ([NSStringFromClass([sub class]) isEqualToString:@"UILabel"])
                    {
                        UILabel *subLabel = (UILabel *)sub;
                        if (subLabel.tag == 8)
                        {
                            subLabel.hidden = NO;
                        }
                    }
                    if ([NSStringFromClass([sub class]) isEqualToString:@"UIImageView"])
                    {
                        UILabel *subImageView = (UILabel *)sub;
                        if (subImageView.tag == 11)
                        {
                            subImageView.hidden = NO;
                        }
                    }
                }
            }
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
