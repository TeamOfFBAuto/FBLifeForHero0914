//
//  downloadtool.h
//  delegatestudy
//
//  Created by 史忠坤 on 13-2-18.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"AlertRePlaceView.h"
#import"Reachability.h"
@class downloadtool;
@protocol downloaddelegate <NSObject>

@required
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data;
-(void)downloadtoolError;
@end


@interface downloadtool : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,AlertRePlaceViewDelegate>{
    NSMutableData *_mutabledata;
    AlertRePlaceView *_replaceAlertView;
    
}
@property (nonatomic,strong)NSString * url_string;
@property (nonatomic,assign)int tag;
@property (nonatomic,strong)NSURLConnection *connectin;
@property (nonatomic,assign)id<downloaddelegate>delegate;
-(void)start;
-(void)stop;
@end
