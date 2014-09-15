//
//  FbNewsFeed.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-20.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FbNewsFeed : NSObject<NSCopying>{
    NSString* _title;
    NSString* _content;
    NSString* _bbsid;
    NSString* _uid;
    NSString* _username;
    NSString* _photo;
    BOOL _photoFlg;
    
}
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* bbsid;
@property(nonatomic,copy) NSString* uid;
@property(nonatomic,copy) NSString* username;
@property(nonatomic,copy) NSString* photo;
@property(nonatomic)BOOL photoFlg;

-(id)initWithJson:( NSDictionary *)conentJson;
@end