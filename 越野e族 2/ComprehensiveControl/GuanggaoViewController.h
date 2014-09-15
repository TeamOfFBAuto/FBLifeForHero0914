//
//  GuanggaoViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AsyncImageView.h"

@interface GuanggaoViewController : UIViewController<AsyncImageDelegate>{

    UIImageView *iMagelogo;
    UIImageView *bigimageview;
    AsyncImageView *guanggao_image;

    UIImageView *img_TEST;
    int flagofpage;
    
    NSString *string_url;

}

@end
