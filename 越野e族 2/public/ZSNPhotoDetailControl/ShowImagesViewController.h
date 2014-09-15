//
//  ShowImagesViewController.h
//  FBCircle
//
//  Created by soulnear on 14-5-22.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "QBShowImagesScrollView.h"

#import "FBQuanAlertView.h"

#import "AtlasContentView.h"

@interface ShowImagesViewController : UIViewController<UIScrollViewDelegate,QBShowImagesScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,LogInViewControllerDelegate>
{
    UIView * navgationBar;
    
    UIView * bottomView;
    
    UIButton * chooseButton;
    
    char identifier[20];
    
    UILabel * title_label;
    
    UIView * navImageView;
    
    UIButton * finish_button;
    
    UILabel * selectedLabel;
    
    FBQuanAlertView * myAlertView;
    
    BOOL isCollected;
    
    BOOL isPraise;
    
    AtlasContentView * content_back_view; //图片标题、简介视图
    
    
    NSMutableArray * my_array;//分享相关
    
    NSString * string_title;
    
    
    
}

@property(nonatomic,strong)NSString * id_atlas;

@property(nonatomic,strong)NSMutableArray * allImagesUrlArray;

@property(nonatomic,strong)UIScrollView * myScrollView;

@property(nonatomic,assign)int currentPage;


@end
