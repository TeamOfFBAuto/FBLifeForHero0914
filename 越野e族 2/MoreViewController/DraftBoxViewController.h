//
//  DraftBoxViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-6-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraftBoxView.h"
#import "downloadtool.h"



@interface DraftBoxViewController : MyViewController<downloaddelegate,UITableViewDataSource,UITableViewDelegate,DraftBoxViewDelegate,AlertRePlaceViewDelegate>{
    downloadtool *_tool;
    UITableView *tab_;
    NSMutableArray *array_info;
    int indexpathofrow;//判断当前是发送的是哪个
    
    BOOL isWeiBo;
    
    NSString * theUserName;
    UIButton *button_comment;
    
    UILabel * wormingLabel;
    
    
}

-(void)titleView;

@end
