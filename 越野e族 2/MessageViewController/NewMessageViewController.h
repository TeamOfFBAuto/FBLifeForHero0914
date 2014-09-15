//
//  NewMessageViewController.h
//  FbLife
//
//  Created by soulnear on 13-8-5.
//  Copyright (c) 2013年 szk. All rights reserved.
//



@protocol NewMessageViewControllerDelegate <NSObject>

-(void)sucessToSendWithName:(NSString *)userName Uid:(NSString *)theUid;

@end


#import <UIKit/UIKit.h>
#import "FriendListViewController.h"
#import "JSMessageInputView.h"
#import "UIButton+JSMessagesView.h"
#import "JSDismissiveTextView.h"

@interface NewMessageViewController : UIViewController<FriendListViewControllerDelegate,UITextViewDelegate,JSDismissiveTextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    
}

@property(nonatomic,assign)id<NewMessageViewControllerDelegate>delegate;

@property (assign, nonatomic) CGFloat previousTextViewContentHeight;

@property (strong, nonatomic) JSMessageInputView *inputToolBarView;

@property(nonatomic,strong)UITextField * name_textField;

@property(nonatomic,strong)NSString * toUid;

@end













