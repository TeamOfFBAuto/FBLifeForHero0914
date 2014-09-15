//
//  DetailBottomView.h
//  FbLife
//
//  Created by soulnear on 13-12-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

@protocol DetailBottomViewDelegate <NSObject>

-(void)buttonClickWithIndex:(int)index;

@end

#import <UIKit/UIKit.h>

@interface DetailBottomView : UIView
{
    
}


@property(nonatomic,assign)id<DetailBottomViewDelegate>delegate;

@end
