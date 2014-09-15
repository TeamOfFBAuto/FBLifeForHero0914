//
//  PictureModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PictureModel;
@protocol PictureModelDelegate <NSObject>
-(void)finishloadWithsmallarray:(NSMutableArray *)__smallimagearray bigimagearray:(NSMutableArray *)__bigimagearray;

@end
@interface PictureModel : NSObject{
    ASIHTTPRequest * request;
}
-(void)stop;
@property(nonatomic,assign)id<PictureModelDelegate>delegate;
-(void)startloadimageWithtype:(int)____type  words:(NSString *)str_words;
@end
