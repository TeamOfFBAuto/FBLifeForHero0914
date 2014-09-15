//
//  MyChatViewCell.h
//  FbLife
//
//  Created by soulnear on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol MyChatViewCellDelegate <NSObject>

-(void)showImageDetail:(UIImage *)image;

-(void)showClickUrlDetail:(NSString *)theUrl;

@end



#import <UIKit/UIKit.h>
#import "ChatInfo.h"
#import "MWPhotoBrowser.h"
#import "RTLabel.h"


extern CGFloat const kJSAvatarSize;

typedef enum {
    JSBubbleMessageTypeIncoming = 0,
    JSBubbleMessageTypeOutgoing
} MyChatViewCellType;



@interface MyChatViewCell : UITableViewCell<AsyncImageDelegate>
{
    
}

@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) AsyncImageView *avatarImageView;
@property(nonatomic,strong)UIImageView * background_imageView;

@property(nonatomic,strong)id<MyChatViewCellDelegate>delegate;



-(void)loadAllViewWithUrl:(ChatInfo *)info Style:(MyChatViewCellType)type;
-(CGPoint)returnHeightWithArray:(NSArray *)array WithType:(MyChatViewCellType)theType;

@end
