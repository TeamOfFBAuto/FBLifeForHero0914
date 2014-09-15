//
//  detailbbsview.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//
//author = "\U571f\U8d8a\U91ce";
//dateline = 1362754464;
//digest = 0;
//replies = 9;
//tid = 2567225;
//title = "\U9646\U5de1\U8fea\U62dc\U51b2\U6c99";
//views = 176;
#import <UIKit/UIKit.h>

@interface detailbbsview : UIView{
      UILabel *titleLabel;
      UILabel *authorLabel;
      UILabel *createTimeLabel;
      UILabel *repliesLabel;
    
}

@property(nonatomic,retain)  NSDictionary *dic_object;
-(void)setDic_object:(NSDictionary *)_dic_object;

@end
