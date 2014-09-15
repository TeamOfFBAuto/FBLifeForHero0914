//
//  DraftBoxView.h
//  FbLife
//
//  Created by 史忠坤 on 13-6-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DraftBoxView;
@protocol DraftBoxViewDelegate <NSObject>

-(void)dele:(UIButton*)sender type:(NSString *)sendtype;
-(void)resendrow:(int)numberofrow type:(NSString *)sendtype;
@end
@interface DraftBoxView : UIView
{
    BOOL isdele;
    UIButton *button_dele;
    int rowofl;
    
}
@property(nonatomic,strong)NSString *string_content;
@property(nonatomic,strong)NSString *string_date;
@property(nonatomic,strong)NSString *string_type;

- (id)initWithFrame:(CGRect)frame contentstring:(NSString *)_contentstring datestring:(NSString *)_datestring type:(NSString *)_type tag:(NSInteger)_buttontag;
@property(assign,nonatomic)id<DraftBoxViewDelegate>delegate;
@end
