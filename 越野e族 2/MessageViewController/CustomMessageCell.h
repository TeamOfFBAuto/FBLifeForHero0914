//
//  CustomMessageCell.h
//  FbLife
//
//  Created by soulnear on 13-8-2.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageInfo.h"

@interface CustomMessageCell : UITableViewCell
{
    
}

@property(nonatomic,strong)AsyncImageView * headImageView;

@property(nonatomic,strong)UILabel * NameLabel;

@property(nonatomic,strong)UILabel * timeLabel;

@property(nonatomic,strong)UILabel * contentLabel;

@property(nonatomic,strong)UILabel * contentLabel1;

@property(nonatomic,strong)UIImageView * tixing_label;


-(void)setAllViewWithType:(int)type;


-(void)setInfoWithType:(int)type withMessageInfo:(MessageInfo *)info;



@end
