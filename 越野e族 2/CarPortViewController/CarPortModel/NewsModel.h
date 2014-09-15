//
//  NewsModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsModel;
@protocol NewsModelDelegate <NSObject>

-(void)finishloadwithimagearray:(NSMutableArray *)imgarray datearray:(NSMutableArray *)_datearray discriptionarray:(NSMutableArray*)_discriptionarray titlearray:(NSMutableArray *)_titlearray newsidarray:(NSMutableArray *)_newsidarray;

@end
@interface NewsModel : NSObject{
    ASIHTTPRequest * request;
}
-(void)stop;
-(void)startloaddatawithpage:(int)page words:(NSString *)thewords;
@property(nonatomic,assign)id<NewsModelDelegate>delegate;
@end
