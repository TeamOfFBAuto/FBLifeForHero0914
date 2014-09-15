//
//  SummaryModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SummaryModel;
@protocol SummaryModelDelegate <NSObject>

-(void)finishloaddatawitharray:(NSArray*)_suminfoarray;

@end
@interface SummaryModel : NSObject{ASIHTTPRequest * request;
}
-(void)startloaddatawithwords:(NSString *)_words;
-(void)stop;
@property(nonatomic,assign)id<SummaryModelDelegate>delegate;
@end
