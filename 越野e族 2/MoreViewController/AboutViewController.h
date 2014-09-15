//
//  AboutViewController.h
//  FbLife
//
//  Created by szk on 13-2-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadtool.h"
@interface AboutViewController : MyViewController<downloaddelegate,MobClickDelegate>{
    downloadtool *newstool;
    UIImageView * imageView;
    int currentpage;
    int flagofpage;
    UIImageView *img_TEST;
}
@end
