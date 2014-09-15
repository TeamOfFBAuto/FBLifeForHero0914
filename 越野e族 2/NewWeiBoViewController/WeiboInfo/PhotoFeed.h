//
//  PhotoFeed.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-19.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoFeed : NSObject<NSCopying>{
    NSString* _aid;
    NSString* _title;
    NSString* _dateline;
    NSArray* _image;
}
@property(nonatomic,copy) NSString* aid;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* dateline;
@property(nonatomic,copy) NSArray* image;
@property(nonatomic,copy) NSString * image_string;

-(id)initWithJson:( NSDictionary *)conentJson;
@end
