//
//  TheActivityNewsCell.h
//  越野e族
//
//  Created by soulnear on 14-9-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheActivityNewsCell : UITableViewCell


@property (strong, nonatomic) AsyncImageView *my_imageView;

@property (strong, nonatomic) UILabel *title_label;

@property (strong, nonatomic) UILabel *content_label;


-(void)setInfoWithDic:(NSDictionary *)dic;


@end
