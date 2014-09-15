//
//  RankingListCustomCell.m
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "RankingListCustomCell.h"

@implementation RankingListCustomCell
@synthesize ranking_label = _ranking_label;
@synthesize title_label = _title_label;
@synthesize follow_num_label = _follow_num_label;
@synthesize line_view = _line_view;
@synthesize collection_button = _collection_button;
@synthesize delegate = _delegate;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_ranking_label) {
            
            _ranking_label = [[UILabel alloc] initWithFrame:CGRectMake(12,37/2,37/2,35/2)];
            
            _ranking_label.backgroundColor = RGBCOLOR(239,239,239);
            
            _ranking_label.textAlignment = NSTextAlignmentCenter;
            
            _ranking_label.font = [UIFont systemFontOfSize:14];
            
            [self.contentView addSubview:_ranking_label];
        }
        
        
        if (!_title_label) {
            _title_label = [[UILabel alloc] initWithFrame:CGRectMake(41,7,140,40)];
            
            _title_label.backgroundColor = [UIColor clearColor];
            
            _title_label.textAlignment = NSTextAlignmentLeft;
            
            _title_label.textColor = RGBCOLOR(49,49,49);
            
            _title_label.font = [UIFont systemFontOfSize:13];
            
            _title_label.numberOfLines = 0;
            
            [self.contentView addSubview:_title_label];
        }
        
        
        if (!_follow_num_label) {
            _follow_num_label = [[UILabel alloc] initWithFrame:CGRectMake(190,0,60,54)];
            
            _follow_num_label.backgroundColor = [UIColor clearColor];
            
            _follow_num_label.textAlignment = NSTextAlignmentCenter;
            
            _follow_num_label.textColor = RGBCOLOR(130,130,130);
            
            _follow_num_label.font = [UIFont systemFontOfSize:14];
            
            [self.contentView addSubview:_follow_num_label];
        }
        
        
        if (!_line_view) {
            _line_view = [[UIView alloc] initWithFrame:CGRectMake(259,12,0.5,30)];
            
            _line_view.backgroundColor = RGBCOLOR(223,223,223);
            
            [self.contentView addSubview:_line_view];
        }
        
        
        
        if (!_collection_button)
        {
            _collection_button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _collection_button.frame = CGRectMake(260,0,60,54);
            
            [_collection_button setImage:[UIImage imageNamed:@"bbs_rankinglist_guanzhu"] forState:UIControlStateNormal];
            
            [_collection_button setImage:[UIImage imageNamed:@"bbs_rankinglist_guanzhu1"] forState:UIControlStateSelected];
            
            [_collection_button addTarget:self action:@selector(collectAndCancelSectionTap:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:_collection_button];
        }
    }
    return self;
}


-(void)setInfoWith:(int)ranking WithModel:(RankingListModel *)model WithType:(int)theType
{
    _ranking_label.text = @"";
    
    _title_label.text = @"";
    
    _follow_num_label.text = @"";
    
    
    if (theType == 1)
    {
        _title_label.font = [UIFont systemFontOfSize:13];
    }else
    {
        _title_label.font = [UIFont systemFontOfSize:15];
    }
    
    
    if (ranking <= 3)
    {
        _ranking_label.textColor = RGBCOLOR(235,79,83);
    }else
    {
        _ranking_label.textColor = RGBCOLOR(122,122,122);
    }
    
    _ranking_label.text = [NSString stringWithFormat:@"%d",ranking];
    
    _title_label.text = model.ranking_title;
    
    CGRect rect = _title_label.frame;
    
    if (model.ranking_num.length != 0)
    {
        _follow_num_label.text = [NSString stringWithFormat:@"%@帖",model.ranking_num];
        
        rect.size.width = 140;
    }else
    {
        rect.size.width = 200;
    }
    _title_label.frame = rect;
}



#pragma mark - 收藏或取消收藏

-(void)collectAndCancelSectionTap:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cancelOrCollectSectionsWith:)])
    {
        [_delegate cancelOrCollectSectionsWith:self];
    }
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
