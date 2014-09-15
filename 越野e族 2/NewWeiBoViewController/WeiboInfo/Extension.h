//
//  Extension.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-20.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Extension : NSObject<NSCopying>{
    NSString* _title;
    NSString* _forum_content;
    NSString* _author;
    NSString* _authorid;
    NSString* _photo;
    NSString* _time;
    BOOL _photoFlg;
}
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* forum_content;
@property(nonatomic,copy) NSString* author;
@property(nonatomic,copy) NSString* authorid;
@property(nonatomic,copy) NSString* photo;
@property(nonatomic,copy) NSString* time;
@property(nonatomic) BOOL photoFlg;

-(id)initWithJson:( NSDictionary *)conentJson;
@end