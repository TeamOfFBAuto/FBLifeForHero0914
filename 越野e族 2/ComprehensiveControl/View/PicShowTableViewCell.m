//
//  PicShowTableViewCell.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-16.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "PicShowTableViewCell.h"

#import "UIViewController+MMDrawerController.h"


#import "NewMainViewModel.h"

@implementation PicShowTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        
        self.bigLabel=[[UILabel alloc] init];
        
        self.leftImageV=[[AsyncImageView alloc] init];
        
        self.centerImageV=[[AsyncImageView alloc] init];
        
        self.rightImageV=[[AsyncImageView alloc] init];

        self.zanImageV=[[UIImageView alloc]init];
        
        //WithImage:[UIImage imageNamed:@"likes21_19.png"]
      self.zanImageV.image=[UIImage imageNamed:@"talknumberofnew.png"];
        
        self.zanlabel=[[UILabel alloc] init];
        
        self.textBigLabel=[[UILabel alloc]init];
        self.normalLine=[[UIView alloc]init];

        
        
        [self addSubview:self.bigLabel];
        
        [self addSubview:self.leftImageV];
        
        [self addSubview:self.rightImageV];
        
        [self addSubview:self.centerImageV];
        
        [self addSubview:self.zanImageV];
        
        [self addSubview:self.zanlabel];
        
        [self addSubview:_textBigLabel];
        
        [self addSubview:_normalLine];
        
        _zanlabel.font=[UIFont systemFontOfSize:10];
        
        _zanlabel.textColor=RGBCOLOR(160, 160, 160);
        
        
        
        _bigLabel.font=[UIFont systemFontOfSize:16];
        _bigLabel.textAlignment=NSTextAlignmentLeft;
        _textBigLabel.font=[UIFont systemFontOfSize:12];
        _textBigLabel.textAlignment=NSTextAlignmentLeft;
        _textBigLabel.textColor=[UIColor grayColor];

        
    }
    return self;
}


-(void)picCellSetDic:(NSDictionary *)theDic{

    _zanImageV.frame=CGRectMake(0, 0, 22/2, 23/2);
    _zanImageV.center=CGPointMake(286, 117);
    _zanlabel.frame=CGRectMake(286+9,110 , 320-286-10, 11);
    
    NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
    [_newmodel NewMainViewModelSetdic:theDic];
    //标题
    _bigLabel.text=_newmodel.title;

    _bigLabel.frame=CGRectMake(12, 13, 320, 16);

    
    
    _zanlabel.text=_newmodel.comment;
    
    //三个图片
    
    if (_newmodel.photo.count>=3) {
        
        _leftImageV.frame=CGRectMake(12+102*0, 38, 90, 60);
        [_leftImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:0]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
        
        _centerImageV.frame=CGRectMake(12+102*1, 38, 90, 60);
        [_centerImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:1]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
        
        _rightImageV.frame=CGRectMake(12+102*2, 38, 90, 60);
        [_rightImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:2]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
    }
    

    
    _zanlabel.textAlignment=NSTextAlignmentLeft;
    
    _textBigLabel.text=[personal timechange:_newmodel.publishtime ];
    
    _textBigLabel.frame=CGRectMake(12,111 , 120, 12);
    

    
    _normalLine.frame=CGRectMake(12, 133.5+3, 320-24, 0.5);
    _normalLine.backgroundColor=RGBCOLOR(223, 223, 223);
    

    
    

    
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
