//
//  UMUFPTableViewCell.m
//  UFP
//
//  Created by liu yu on 2/13/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMTableViewCell.h"
#import "UMUFPImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UMTableViewCell

@synthesize mImageView = _mImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font = [UIFont systemFontOfSize:15.0];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.textColor = [UIColor colorWithRed:88.0/255 green:88.0/255 blue:88.0/255 alpha:1.0];
        self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor;
        
        _mImageView = [[UMUFPImageView alloc] initWithPlaceholderImage:nil];
        _mImageView.shouldRedrawImageToAdaptImageViewSize = NO;
		self.mImageView.frame = CGRectMake(20.0f, 6.0f, 48.0f, 48.0f);
        self.mImageView.layer.borderWidth = 0.8;
        self.mImageView.layer.borderColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5].CGColor;
        self.mImageView.layer.cornerRadius = 9.0;
        self.mImageView.layer.masksToBounds = YES;
		[self.contentView addSubview:self.mImageView];
        
        UIView *bgimageSel = [[UIView alloc] initWithFrame:self.bounds];
        bgimageSel.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
        self.selectedBackgroundView = bgimageSel;
        [bgimageSel release];
    }
    return self;
}

- (void)setImageURL:(NSString*)urlStr {    
    
	self.mImageView.imageURL = [NSURL URLWithString:urlStr];
}

- (void)dealloc {
    [_mImageView release];
    _mImageView = nil;
    
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float topMargin = (self.bounds.size.height - 48) / 2;
    
    self.mImageView.frame = CGRectMake(15, topMargin, 48, 48);
    CGRect imageViewFrame = self.mImageView.frame;
    self.mImageView.layer.cornerRadius = 9.0;
    self.mImageView.layer.masksToBounds = YES;
    
    CGFloat leftMargin = imageViewFrame.origin.x + imageViewFrame.size.width + 15;
    
    self.textLabel.frame = CGRectMake(leftMargin, 
                                      topMargin, 
                                      self.bounds.size.width - 110, 17);
    
    CGRect textLableFrame = self.textLabel.frame;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    CGFloat width = self.bounds.size.width - 90;
    self.detailTextLabel.frame = CGRectMake(leftMargin, 
                                            textLableFrame.origin.y + textLableFrame.size.height + 4, 
                                            width, 28);
}

@end