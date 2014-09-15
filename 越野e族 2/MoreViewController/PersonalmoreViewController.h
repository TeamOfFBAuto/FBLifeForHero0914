//
//  PersonalmoreViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-12-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMHud.h"
#import "UMUFPTableView.h"
#import "FriendListViewController.h"
@interface PersonalmoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AsyncImageDelegate,UMUFPTableViewDataLoadDelegate,FriendListViewControllerDelegate>{
    UITableView *_myTableView;
    NSArray *arrayofsection;
    NSArray *arrayofimg;
    AsyncImageView *imgbeijing;
    AsyncImageView *imghead;
    
    ATMHud *hud;
    UILabel * label_title;
    
    NSString *          string_face_original;
    NSString *          beijingstring;
    
    UMUFPTableView *_mTableView;
    NSArray *arrayofjingpinyingyong;
    
    NSString *string_follownumber;
    NSString *string_fansnumber;
    NSString *string_messageorfb;
    
  //  UIImageView * tixing_imageView;
    
}

@end
