//
//  BlogFeed.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-17.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogFeed : NSObject<NSCopying>{

    NSString* _blogid;
    NSString* _title;
    NSString* _content;
    NSString* _dateline;
    NSString* _photo;
    BOOL _photoFlg;
}

@property(nonatomic,copy) NSString *blogid;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *dateline;
@property(nonatomic,copy) NSString *photo;//没有图片时这个值为<null>
@property(nonatomic) BOOL photoFlg;


-(id)initWithJson:( NSDictionary *)conentJson;
@end
