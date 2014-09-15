//
//  keyboardtopview.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-19.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class keyboardtopview;
@protocol KeyboardviewDelegate <NSObject>

-(void)clickbutton:(UIButton *)sender;
-(void)removeimage;
@end
@interface keyboardtopview : UIView{
    UIView *Bottom_View;
    UIButton *Delete_Button;
}
@property(nonatomic,strong)UIButton *KeyboardButton;
@property(nonatomic,strong)UIButton *CammeraButton;
@property(nonatomic,strong)UIButton *PhotoButton;
@property(nonatomic,strong)UIImageView *imV;
@property(nonatomic,strong)UIImage *image_;
@property(assign,nonatomic)int changeimage;
@property(assign,nonatomic)id<KeyboardviewDelegate>delegate;
-(void)bottoming;
-(void)uping;
-(void)chinesekeyuping;
-(void)jiugonggechineseuping;
-(void)jiugonggepinyinuping;
-(void)FaceAndKeyBoard:(int)isface;
-(void)WhenfaceviewFram;
@end
