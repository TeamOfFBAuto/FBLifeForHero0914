//
//  ResponseData.h
//  mytubo_iphone
//
//  Created by user on 11-6-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

@interface MyHttpResponse : NSObject 

@property(nonatomic,readonly,strong) NSError* networkError;
@property(nonatomic,readonly) NSInteger responseError;
@property(nonatomic,readonly,strong) NSString *errMessage;
@property(nonatomic,readonly,strong) id data; 

+(MyHttpResponse*)responseWithRequest:(ASIHTTPRequest*)request;
-(BOOL)success;

@end
