//
//  WenJiViewController.h
//  FbLife
//
//  Created by soulnear on 13-3-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WenJiFeed.h"
#import "loadingview.h"

@interface WenJiViewController : MyViewController<UIWebViewDelegate>
{
    UIWebView * webView;
    UIScrollView * myScrollView;
    AsyncImageView * headView;
    UILabel * dateLine_Label;
    UILabel * title_Label;
    UILabel * userName_label;
    UIImageView * line_imageView;
    loadingview * Load_view;
}


@property(nonatomic,strong)NSString * bId;

@property(nonatomic,strong)WenJiFeed * info;


@end
