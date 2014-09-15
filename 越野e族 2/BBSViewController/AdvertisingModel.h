//
//  AdvertisingModel.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "downloadtool.h"
#import "AsyncImageView.h"
@class AdvertisingModel;
@protocol AdvertisingModelDelegate <NSObject>

-(void)finishload;
-(void)failedload;

@end
@interface AdvertisingModel : NSObject<downloaddelegate,AsyncImageDelegate>{
    downloadtool *tool_bbshomepage;
    downloadtool *tool_bbsfendui;
    downloadtool *tool_bbsdetail;
    downloadtool *tool_newsdetail;
    downloadtool *tool_wbhomepage;

    NSMutableArray *array_guanggaourl;
    NSMutableArray *array_img;
    NSMutableDictionary *dic_mutableimgandurl;

    NSString *string_linkofimg;
    
    int m[10];
}

@property(nonatomic,strong)NSString *string_url;
//这些都是图片链接
@property(nonatomic,strong)NSString *str_bbshomepage;
@property(nonatomic,strong)NSString *str_bbsfendui;
@property(nonatomic,strong)NSString *str_bbsdetail;
@property(nonatomic,strong)NSString *str_newsdetail;
@property(nonatomic,strong)NSString *str_wbhomepage;
//这些都是图片url
@property(nonatomic,strong)NSString *str_urlbbshomepage;
@property(nonatomic,strong)NSString *str_urlbbsfendui;
@property(nonatomic,strong)NSString *str_urlbbsdetail;
@property(nonatomic,strong)NSString *str_urlnewsdetail;
@property(nonatomic,strong)NSString *str_urlwbhomepage;




@property(nonatomic,assign)id<AdvertisingModelDelegate>delegate;
-(void)startload;
@end
