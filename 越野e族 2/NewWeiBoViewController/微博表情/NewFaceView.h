//
//  NewFaceView.h
//  越野e族
//
//  Created by soulnear on 13-12-27.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//


@class NewFaceView;
@protocol expressionDelegate <NSObject>

-(void)expressionClickWith:(NewFaceView *)faceView faceName:(NSString *)name;


@end

#import <UIKit/UIKit.h>

@interface NewFaceView : UIView
{
    
}

@property (nonatomic, assign) id<expressionDelegate> deletage;
/**
 方法用于创建表情
 page：参数用于表示的页数
 */
-(void)createExpressionWithPage:(int)page;

@end


