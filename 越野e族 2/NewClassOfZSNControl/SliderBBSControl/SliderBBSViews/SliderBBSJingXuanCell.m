//
//  SliderBBSJingXuanCell.m
//  越野e族
//
//  Created by soulnear on 14-7-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SliderBBSJingXuanCell.h"

@implementation SliderBBSJingXuanCell
@synthesize img_view = _img_view;
@synthesize title_label = _title_label;
@synthesize content_label = _content_label;
@synthesize date_label = _date_label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _img_view=[[AsyncImageView alloc]initWithFrame:CGRectMake( 12, 8,90 , 60)];
        
        [self.contentView addSubview:_img_view];
        
        
        _title_label=[[UILabel alloc]initWithFrame:CGRectMake(101+7,8,ALL_FRAME.size.width-85-22-12,16)];
        self.title_label.font=[UIFont systemFontOfSize:16.0];
        self.title_label.backgroundColor=[UIColor clearColor];
        
        [self.contentView addSubview:_title_label];
        
        _content_label = [[RTLabel alloc] initWithFrame:CGRectMake(108,34,ALL_FRAME.size.width-85-22-12,40)];
        
        _content_label.lineSpacing = 4;
        
        _content_label.font = [UIFont fontWithName:@"Helvetica" size:12];
        
        _content_label.textColor = RGBCOLOR(123,123,123);
        
        _content_label.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_content_label];
        
        
        _date_label=[[UILabel alloc]initWithFrame:CGRectMake(ALL_FRAME.size.width-10-60-3,55,61.5-3, 10)];
        _date_label.textAlignment=NSTextAlignmentRight;
        _date_label.font=[UIFont systemFontOfSize:10];
        _date_label.textColor = RGBCOLOR(193,192,192);
        
        [self.contentView addSubview:_date_label];
        
    }
    return self;
}


-(void)setInfoWith:(SliderBBSJingXuanModel *)model
{
    _img_view.image = nil;
    
    _content_label.text = nil;
    
    _title_label.text = nil;
    
    _date_label.text = nil;
    
    
    [_img_view loadImageFromURL:model.jx_photo withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
    
    _title_label.text = model.jx_stitle;
    
    
    
    if (model.jx_summary.length > 25)
    {
        NSString * string = [model.jx_summary substringToIndex:25];
        
        _content_label.text = [NSString stringWithFormat:@"%@...",string];
        
    }else
    {
        _content_label.text = model.jx_summary;
    }
    
    _date_label.text = [personal timchange:model.jx_publishtime];
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
