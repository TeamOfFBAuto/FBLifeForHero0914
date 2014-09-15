//
//  LoadImgFromImPicker.h
//  FbLife
//
//  Created by soulnear on 13-7-17.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class LoadImgFromImPicker;
@protocol LoadImgFromImPickerDelegate <NSObject>


-(void)loadsucess:(NSMutableArray *)arrayall;

@end

@interface LoadImgFromImPicker : NSObject
@property(assign,nonatomic)id<LoadImgFromImPickerDelegate>delegate;
-(void)allimagearray:(NSString*)imgurl;
@end
