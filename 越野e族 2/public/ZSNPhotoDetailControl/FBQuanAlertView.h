//
//  FBQuanAlertView.h
//  FBCircle
//
//  Created by 史忠坤 on 14-6-7.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    //以下是枚举成员 TestA = 0,
    FBQuanAlertViewTypeNoJuhua=0,
    FBQuanAlertViewTypeHaveJuhua=1,
    
}FBQuanAlertViewType;//枚举名称


@interface FBQuanAlertView : UIView


@property(nonatomic,strong)UILabel *TextLabel;

@property(nonatomic,strong)UIActivityIndicatorView *juhuazhuan;


-(void)setType:(FBQuanAlertViewType)thetype thetext:(NSString *)alerttext;



@end
