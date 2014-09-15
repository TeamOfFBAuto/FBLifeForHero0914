//
//  SGFocusImageFrame.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//NewHuandengView

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
@class SGFocusImageItem;
@class NewHuandengView;

#pragma mark - SGFocusImageFrameDelegate
@protocol NewHuandengViewDelegate <NSObject>
@optional
- (void)testfoucusImageFrame:(NewHuandengView *)imageFrame didSelectItem:(SGFocusImageItem *)item;
- (void)testfoucusImageFrame:(NewHuandengView *)imageFrame currentItem:(int)index;

@end


@interface NewHuandengView : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    BOOL _isAutoPlay;
}
- (id)initWithFrame:(CGRect)frame delegate:(id<NewHuandengViewDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;

- (id)initWithFrame:(CGRect)frame delegate:(id<NewHuandengViewDelegate>)delegate focusImageItems:(SGFocusImageItem *)items, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithFrame:(CGRect)frame delegate:(id<NewHuandengViewDelegate>)delegate imageItems:(NSArray *)items;
- (void)scrollToIndex:(int)aIndex;


-(void)setimageItems:(NSArray *)items;

@property(nonatomic,strong)UIImageView *sanJiaoImageView;

@property (nonatomic, assign) id<NewHuandengViewDelegate> delegate;

@end
