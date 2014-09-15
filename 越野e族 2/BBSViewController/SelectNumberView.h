//
//  SelectNumberView.h
//  FbLife
//
//  Created by 史忠坤 on 13-4-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectNumberView;
@protocol SelectNumberViewDelegate <NSObject>

-(void)ReceiveNumber:(NSInteger)number;
-(void)NoticeFrameHigh;
-(void)NoticeFrameLow;


@end
@interface SelectNumberView : UIView<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    UIPickerView *_Pick;
    UIToolbar *_ToolBar;
    NSArray *array;
    int rowofPickerview;
    UITextField *text_label;
}
@property(assign,nonatomic)id <SelectNumberViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame receiveArray:(NSArray *)_array;
-(void)ShowPick;
-(void)Dismiss;
@end
