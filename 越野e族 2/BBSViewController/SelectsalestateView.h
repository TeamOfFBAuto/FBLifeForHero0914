//
//  SelectsalestateView.h
//  FbLife
//
//  Created by 史忠坤 on 13-6-6.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectNumberView;
@protocol SelectsalestateViewDelegate <NSObject>

-(void)salenumber:(int)numbersale locationnumber:(int)numberlocation;

@end
@interface SelectsalestateView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIPickerView *_Pick;
    UIToolbar *_ToolBar;
    NSArray *array_salestate;
    NSArray *array_location;
    int salenumber;
    int locationnumber;

}
@property(assign,nonatomic)id <SelectsalestateViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame receiveSalestateArray:(NSArray *)_array locationarray:(NSArray *)_arraylocation;
-(void)ShowPick;
-(void)Dismiss;
@end
