//
//  ImagesCell.m
//  FbLife
//
//  Created by soulnear on 13-3-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "ImagesCell.h"

@implementation ImagesCell
@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize imageView4 = _imageView4;
@synthesize delegate = _delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)setAllView
{
    if (!_imageView1)
    {
        _imageView1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(3.2,3.2,76,76)];
        _imageView1.userInteractionEnabled = YES;
        _imageView1.tag = 1;
        _imageView1.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [_imageView1 addGestureRecognizer:tap];
    }else
    {
        _imageView1.image = nil;
    }
    
    if (!_imageView2)
    {
        _imageView2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(3.2+76+3.2,3.2,76,76)];
        _imageView2.userInteractionEnabled = YES;
        _imageView2.tag = 2;
        _imageView2.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [_imageView2 addGestureRecognizer:tap];
    }else
    {
        _imageView2.image = nil;
    }
    
    if (!_imageView3)
    {
        _imageView3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(3.2+(76+3.2)*2,3.2,76,76)];
        _imageView3.userInteractionEnabled = YES;
        _imageView3.tag = 3;
        _imageView3.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [_imageView3 addGestureRecognizer:tap];
    }else
    {
        _imageView3.image = nil;
    }
    
    if (!_imageView4)
    {
        _imageView4 = [[AsyncImageView alloc] initWithFrame:CGRectMake(3.2+(76+3.2)*3,4,76,76)];
        _imageView4.userInteractionEnabled = YES;
        _imageView4.tag = 4;
        _imageView4.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [_imageView4 addGestureRecognizer:tap];
    }else
    {
        _imageView4.image = nil;
    }
    
    [self.contentView addSubview:_imageView1];
    [self.contentView addSubview:_imageView2];
    [self.contentView addSubview:_imageView3];
    [self.contentView addSubview:_imageView4];
}


-(void)doTap:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDetailImage: imageTag:)])
    {
        [self.delegate showDetailImage:self imageTag:sender.view.tag];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
}

@end















