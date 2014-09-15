//
//  MyChatViewController.h
//  FbLife
//
//  Created by soulnear on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessageInputView.h"
#import "JSMessageSoundEffect.h"
#import "UIButton+JSMessagesView.h"
#import "MessageInfo.h"
#import "MyChatViewCell.h"
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "NewMineViewController.h"
#import "AlertRePlaceView.h"

@interface MyChatViewController : MyViewController<UITableViewDelegate,UITableViewDataSource,JSDismissiveTextViewDelegate,UITextViewDelegate,UITextViewDelegate,MyChatViewCellDelegate,MWPhotoBrowserDelegate,AlertRePlaceViewDelegate>
{
    NSTimer * timer;
    //    botomviewofchat *bottom_view;
    
    UITapGestureRecognizer *backkeyboard;
    
    
    MyChatViewCell * test_cell;
    
}



@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JSMessageInputView *inputToolBarView;
@property(assign,nonatomic)CGFloat previousTextViewContentHeight;

@property(nonatomic,strong)NSMutableArray * messageArray;
@property(nonatomic,strong)NSMutableArray * timesArray;
@property(nonatomic,strong)NSMutableArray * data_array;

@property(nonatomic,strong)ASIHTTPRequest * requset_data;
@property(nonatomic,strong)ASIHTTPRequest * request_send;
@property(nonatomic,strong)MessageInfo * info;
@property(nonatomic,strong)NSMutableArray * photo_array;

@property(nonatomic,strong)UIView * theTouchView;


#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification;
- (void)handleWillHideKeyboard:(NSNotification *)notification;
- (void)keyboardWillShowHide:(NSNotification *)notification;


@end






