//
//  loadingimview.h
//  FbLife
//
//  Created by 史忠坤 on 13-7-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface loadingimview : UIImageView
//
//@end




@class loadingimview;
@protocol loadDelegate <NSObject>

-(void)loadinghide;

@end
@interface loadingimview : UIImageView
- (id)initWithFrame:(CGRect)frame labelString:(NSString *)_string;
-(void)hide;
@property(assign,nonatomic)id<loadDelegate>delegate;
@end
