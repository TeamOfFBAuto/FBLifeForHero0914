//
//  LoadImgFromImPicker.m
//  FbLife
//
//  Created by soulnear on 13-7-17.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "LoadImgFromImPicker.h"
@implementation LoadImgFromImPicker
@synthesize delegate;
-(void)allimagearray:(NSString*)imgurl{
    NSMutableArray *array_all=[[NSMutableArray alloc]init];
    if (imgurl.length != 0)
    {
        NSArray * ImageArray = [imgurl componentsSeparatedByString:@"||"];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        for (int i = 0;i < ImageArray.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
            NSURL *referenceURL = [NSURL URLWithString:imgurl];
            dispatch_queue_t  network_queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
            dispatch_async(network_queue, ^{
                
                
                __block UIImage *returnValue = nil;
                [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
                 {
                     returnValue = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]]; //Retain Added
                     
                     [array_all addObject:returnValue];
                     
                     
                     if (i == ImageArray.count-1)
                     {
                         
                     }
                     
                     
                 } failureBlock:^(NSError *error) {
                     // error handling
                 }];
                //返回主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置标题
                  });  
            });
            
   
        }
        NSLog(@"jimao=======");
    }
    [self.delegate loadsucess:array_all];

}

@end
