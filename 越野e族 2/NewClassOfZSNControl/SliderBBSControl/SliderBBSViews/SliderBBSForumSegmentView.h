//
//  SliderBBSForumSegmentView.h
//  越野e族
//
//  Created by soulnear on 14-7-4.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SliderBBSForumSegmentViewBlock)(int index);

@interface SliderBBSForumSegmentView : UIView
{
    SliderBBSForumSegmentViewBlock forumViewBlock;
    
    int history_page;//保存上次选择的版块
}



-(void)setAllViewsWithTextArray:(NSArray *)textArray WithImageArray:(NSArray *)imageArray WithBlock:(SliderBBSForumSegmentViewBlock)theBlock;


@end
