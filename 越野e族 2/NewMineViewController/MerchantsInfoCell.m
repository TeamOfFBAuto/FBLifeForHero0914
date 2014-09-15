//
//  MerchantsInfoCell.m
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import "MerchantsInfoCell.h"

@implementation MerchantsInfoCell
@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize titleLabel1 = _titleLabel1;
@synthesize titleLabel2 = _titleLabel2;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}


-(void)setAllView
{
    if (!_imageView1)
    {
        _imageView1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(9.66,5,145.5,96.5)];
        
        _imageView1.userInteractionEnabled = YES;
        
        _imageView1.tag = 100000;
        
        [self.contentView addSubview:_imageView1];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
        [_imageView1 addGestureRecognizer:tap];
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,_imageView1.frame.size.height - 43/2,_imageView1.frame.size.width,43/2)];
        
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        [_imageView1 addSubview:view];
        
        
        _titleLabel1 = [[UILabel alloc] initWithFrame:view.bounds];
        
        _titleLabel1.tag = 10;
        
        _titleLabel1.backgroundColor = [UIColor clearColor];
        
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel1.textColor = [UIColor whiteColor];
        
        _titleLabel1.font = [UIFont systemFontOfSize:13];
        
        [view addSubview:_titleLabel1];
    }
    
    if (!_imageView2)
    {
        _imageView2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(164.82,5,145.5,96.5)];
        
        _imageView2.userInteractionEnabled = YES;
        
        _imageView2.tag = 100001;
        
        [self.contentView addSubview:_imageView2];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
        [_imageView2 addGestureRecognizer:tap];
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,_imageView2.frame.size.height - 43/2,_imageView2.frame.size.width,43/2)];
        
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        [_imageView2 addSubview:view];
        
        
        _titleLabel2 = [[UILabel alloc] initWithFrame:view.bounds];
        
        _titleLabel2.tag = 10;
        
        _titleLabel2.backgroundColor = [UIColor clearColor];
        
        _titleLabel2.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel2.textColor = [UIColor whiteColor];
        
        _titleLabel2.font = [UIFont systemFontOfSize:13];
        
        [view addSubview:_titleLabel2];
    }
}


-(void)clickTap:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickImageWithIndex:Cell:)])
    {
        [_delegate clickImageWithIndex:sender.view.tag-100000 Cell:self];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
}

@end
