//
//  UMTableViewLoadingCell.m
//  UMAppNetworkDemo
//
//  Created by liuyu on 9/16/13.
//  Copyright (c) 2013 Realcent. All rights reserved.
//

#import "UMTableViewLoadingCell.h"

@implementation UMTableViewLoadingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 120, 30)];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        _loadingLabel.font = [UIFont systemFontOfSize:14];
        _loadingLabel.text = @"加载中...";
        [self addSubview:_loadingLabel];
        [_loadingLabel release];
        
        _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingIndicator.backgroundColor = [UIColor clearColor];
        _loadingIndicator.frame = CGRectMake(115, 20, 30, 30);
        [self addSubview:_loadingIndicator];
        [_loadingIndicator release];
    }
    
    return self;
}

@end
