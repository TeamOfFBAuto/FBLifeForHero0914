//
//  SliderBBSJingXuanCell.h
//  越野e族
//
//  Created by soulnear on 14-7-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "SliderBBSJingXuanModel.h"

@interface SliderBBSJingXuanCell : UITableViewCell
{
    
}



@property(nonatomic,strong)AsyncImageView * img_view;

@property(nonatomic,strong)UILabel * title_label;

@property(nonatomic,strong)RTLabel * content_label;

@property(nonatomic,strong)UILabel * date_label;




-(void)setInfoWith:(SliderBBSJingXuanModel *)model;



@end
