//
//  SliderSegmentView.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-3.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SliderSegmentView;
@protocol SliderSegmentViewDelegate <NSObject>

-(void)searchreaultbythetype:(NSString *)type;

@end
@interface SliderSegmentView : UIView{
    UILabel *label_;
}
@property(assign,nonatomic)int currentpage;
@property(strong,nonatomic)NSString *type;
@property(assign,nonatomic)id<SliderSegmentViewDelegate>delegate;
-(void)NewloadContent:(NSArray *)array_;

-(void)loadContent:(NSArray *)array_;
@end
