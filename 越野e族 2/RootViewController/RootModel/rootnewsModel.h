//
//  newsModel.h
//  越野e族
//
//  Created by 史忠坤 on 13-12-25.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class rootnewsModel;
@protocol rootNewsModelDelegate <NSObject>

-(void)successloadcommentdic:(NSDictionary *)_comdic mormaldic:(NSDictionary *)_nordic tag:(int)_tag;
-(void)doneloadmoremornormal:(NSDictionary*)_morenormaldic tag:(int )_tag;

@end

@interface rootnewsModel : NSObject{
    ASIHTTPRequest * requestcomment;
    ASIHTTPRequest * requestnomal;

    int twosuccess[2];
    
    NSDictionary *dic_comment;
    NSDictionary *dic_normal;
    
    
}

@property(assign,nonatomic)int tag;

@property(strong,nonatomic)NSString *type;
@property(assign,nonatomic)id<rootNewsModelDelegate>delegate;


-(void)startloadcommentsdatawithtag:(int)_tag thetype:(NSString *)_type;
-(void)loadmorewithtag:(int)_tag thetype:(NSString *)_type page:(int)_page;



-(void)stopload;


@end
