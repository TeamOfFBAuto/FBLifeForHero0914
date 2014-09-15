//
//  newscellview.h
//  FbLife
//
//  Created by 史忠坤 on 13-2-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//
#import "AsyncImageView.h"
#import <UIKit/UIKit.h>

@interface newscellview : UIView{
}
@property (nonatomic,strong)AsyncImageView *imagev;
@property(nonatomic,strong)NSString *imv_string;
@property (nonatomic,strong)UILabel *title_label;
@property (nonatomic,strong)UILabel *date_label;
@property(nonatomic,strong)NSString *title_string;
@property(nonatomic,strong)NSString *date_string;
@property(nonatomic,strong)NSString *discribe_string;
@property(nonatomic,assign)int grayorblack;



@end
