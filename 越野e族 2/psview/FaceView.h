//
//  FaceView.h
//  FaceDemo
//
//  Created by user on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol expressionDelegate;


@interface FaceView : UIView
{
    id<expressionDelegate> _deletage;
}

@property (nonatomic, assign) id<expressionDelegate> deletage;
/**
 方法用于创建表情
 page：参数用于表示的页数
 */
-(void)createExpressionWithPage:(int)page;

@end

@protocol expressionDelegate <NSObject>

-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name;

@end