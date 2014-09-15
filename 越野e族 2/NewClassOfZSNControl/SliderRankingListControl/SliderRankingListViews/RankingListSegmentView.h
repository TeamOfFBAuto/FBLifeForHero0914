//
//  RankingListSegmentView.h
//  越野e族
//
//  Created by soulnear on 14-7-9.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RankingListSegmentViewBlock)(int index);

@interface RankingListSegmentView : UIView
{
    RankingListSegmentViewBlock rankingListBlock;
    
    int historyPage;//记录上次点击的位置
}

- (id)initWithFrame:(CGRect)frame WithBlock:(RankingListSegmentViewBlock)theBlock;


@end
