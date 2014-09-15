//
//  ResponseData.m
//  mytubo_iphone
//
//  Created by user on 11-6-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyHttpResponse.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "HintView.h"
#import "JSONKit.h"
@interface MyHttpResponse()

@property(nonatomic,readwrite,strong) NSError* networkError;
@property(nonatomic,readwrite) NSInteger responseError;
@property(nonatomic,readwrite,strong) NSString *errMessage;
@property(nonatomic,readwrite,strong) id data; 

@end

@implementation MyHttpResponse

@synthesize networkError;
@synthesize responseError;
@synthesize errMessage;
@synthesize data; 

+(MyHttpResponse*)responseWithRequest:(ASIHTTPRequest*)request
{
	MyHttpResponse *response = [[MyHttpResponse alloc] init] ;
	response.networkError = [request error];
	NSData *data = [request responseData];
	if (response.networkError == nil && data != nil) 
	{
		NSString *feedsJsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",feedsJsonStr);
		NSDictionary *results = [feedsJsonStr objectFromJSONString];

        response.data = results;		
		if (results && ![results objectForKey:@"error"]) {
			response.responseError = 0;
		} else {
			response.responseError = 1;
            NSLog(@"%@",feedsJsonStr);
		}
	}
    
	if (response.networkError) {
		if(response.networkError.domain==NetworkRequestErrorDomain&&response.networkError.code==ASIConnectionFailureErrorType)
		{
			HintView *hint = [HintView HintViewWithText:@"网络错误"];
			[hint showAutoDestory];
		} else if(response.networkError.domain==NetworkRequestErrorDomain&&response.networkError.code==ASIRequestTimedOutErrorType){
			HintView *hint = [HintView HintViewWithText:@"连接超时"];
			[hint showAutoDestory];
		}
	}
    
	return response;
}

-(BOOL)success
{
	if (self.networkError != nil||self.responseError != 0) {
		return NO;
	} else {
		return YES;
	}
}

- (NSString *)description
{
    NSMutableString *string = [NSMutableString stringWithCapacity:256];
	[string appendFormat:@"%@\n",self.networkError];
	[string appendFormat:@"errnum %d\n",self.responseError];
	[string appendFormat:@"errmsg %@\n",self.errMessage];
	[string appendFormat:@"%@\n",self.data];
	return string;
}

@end
