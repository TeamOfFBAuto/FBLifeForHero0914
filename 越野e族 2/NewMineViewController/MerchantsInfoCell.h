//
//  MerchantsInfoCell.h
//  越野e族
//
//  Created by soulnear on 13-12-23.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

@class MerchantsInfoCell;
@protocol MerchantsInfoCellDelegate <NSObject>

-(void)clickImageWithIndex:(int)index Cell:(MerchantsInfoCell *)cell;

@end


#import <UIKit/UIKit.h>

@interface MerchantsInfoCell : UITableViewCell
{
    
}

@property(nonatomic,assign)id<MerchantsInfoCellDelegate>delegate;

@property(nonatomic,strong)AsyncImageView * imageView1;

@property(nonatomic,strong)AsyncImageView * imageView2;

@property(nonatomic,strong)UILabel * titleLabel1;

@property(nonatomic,strong)UILabel * titleLabel2;

-(void)setAllView;

@end
