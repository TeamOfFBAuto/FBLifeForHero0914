//
//  AsyncImageView.h
//  AirMedia
//
//  Created by Xingzhi Cheng on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@class AsyncImageView;
@protocol AsyncImageDelegate <NSObject>

@required

-(void)handleImageLayout:(AsyncImageView*)tag;


@optional

-(void)seccesDownLoad:(UIImage *)image;
-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image;

@end


@interface AsyncImageView : UIImageView <ASIHTTPRequestDelegate>
{
    NSMutableData * data;
    
    UIProgressView * myProgress;
    UIActivityIndicatorView * activity;
    
}
@property(nonatomic, retain) ASIHTTPRequest * request;
@property (nonatomic, strong) id <AsyncImageDelegate> delegate;

- (void) loadImageFromURL1:(NSString*)imageURL withPlaceholdImage:(UIImage *)placeholdImage;
- (void) loadImageFromURL:(NSString*)imageURL;
- (void) loadImageFromURL:(NSString*)imageURL withPlaceholdImage:(UIImage*)image;
- (void) cancelDownload;

#pragma mark - 每次都请求图片，如果请求失败再调取缓存图片，如果没有缓存图片加载默认图片
-(void)loadUserHeaderImageFromUrl:(NSString *)imageUrl withPlaceholdImage:(UIImage *)placeholdImage;

@end














