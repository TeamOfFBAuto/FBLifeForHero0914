//
//  bottombarview.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class bottombarview;
@protocol BottombarviewDelegate <NSObject>

-(void)clickbutton:(UIButton*)sender;

@end

@interface bottombarview : UIView{
    UILabel *label_number;
}
@property(nonatomic,strong) UIButton *button_refresh;
@property(nonatomic,strong) UIButton *button_ahead;
@property(nonatomic,strong) UIButton *button_show;
@property(nonatomic,strong) UIButton *button_behind;
@property(nonatomic,strong) UIButton *button_comment;
@property(nonatomic,assign)id<BottombarviewDelegate>delegate;
-(void)setcommentimage1:(NSString *)commentnumber;
-(void)setcommentimage2;

@end
