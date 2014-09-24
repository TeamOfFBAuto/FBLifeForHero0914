//
//  TheActivityNewsCell.m
//  越野e族
//
//  Created by soulnear on 14-9-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "TheActivityNewsCell.h"

@implementation TheActivityNewsCell
@synthesize my_imageView = _my_imageView;
@synthesize title_label = _title_label;
@synthesize content_label = _content_label;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _my_imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(13,14,90,60)];
        [self.contentView addSubview:_my_imageView];
        
        
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(116,14,184,16)];
        _title_label.textAlignment = NSTextAlignmentLeft;
        _title_label.textColor = RGBCOLOR(49,49,49);
        _title_label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_title_label];
        
        _content_label = [[UILabel alloc] initWithFrame:CGRectMake(116,40,184,30)];
        _content_label.textAlignment = NSTextAlignmentLeft;
        _content_label.textColor = RGBCOLOR(124,124,124);
        _content_label.numberOfLines = 0;
        _content_label.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_content_label];
        
    }
    return self;
}


-(void)setInfoWithDic:(NSDictionary *)dic
{
    [_my_imageView loadImageFromURL:[NSString stringWithFormat:@"%@.180x120.jpg",[dic objectForKey:@"photourl"]] withPlaceholdImage:nil];
    _title_label.text = [dic objectForKey:@"stitle"];
    _content_label.text = [dic objectForKey:@"summary"];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
