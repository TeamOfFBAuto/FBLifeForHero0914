//
//  QrcodeViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-12-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QrcodeViewController : MyViewController<AsyncImageDelegate>{
    AsyncImageView *qrimageview;
    NSString *stringurl;
}
@property(nonatomic,strong)UIImage *headImage;
@property(nonatomic,strong)NSString *nameString;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * imageString;

@end
