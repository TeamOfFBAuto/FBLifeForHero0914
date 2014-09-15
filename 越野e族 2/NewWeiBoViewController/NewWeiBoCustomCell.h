//
//  NewWeiBoCustomCell.h
//  FbLife
//
//  Created by soulnear on 13-11-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@class NewWeiBoCustomCell;
@class FbFeed;

@protocol NewWeiBoCustomCellDelegate <NSObject>

@required


@optional

-(void)clickHeadImage:(NSString *)uid;

-(void)clickUrlToShowWeiBoDetailWithInfo:(FbFeed *)info WithUrl:(NSString *)theUrl isRe:(BOOL)isRe;

-(void)showClickUrl:(NSString *)theUrl WithFBFeed:(FbFeed *)info;

-(void)showAtSomeBody:(NSString *)theUrl WithFBFeed:(FbFeed *)info;

-(void)showImage:(FbFeed *)info isReply:(BOOL)isRe WithIndex:(int)index;

-(void)showVideoWithUrl:(NSString *)theUrl;

-(void)presentToCommentControllerWithInfo:(FbFeed *)info WithCell:(NewWeiBoCustomCell *)theCell;

-(void)presentToFarwardingControllerWithInfo:(FbFeed *)info WithCell:(NewWeiBoCustomCell *)theCell;

-(void)deleteSomeWeiBoContent:(NewWeiBoCustomCell *)cell;

-(void)showOriginalWeiBoContent:(NSString *)theTid;


@end




#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "FbFeed.h"
#import "PictureViews.h"
#import "WeiBoSpecialView.h"



@interface NewWeiBoCustomCell : UITableViewCell<PictureViewsDelegate,RTLabelDelegate,WeiBoSpecialViewDelegate>
{
    FbFeed * _weiboInfo;
    
    //计算
    
    WeiBoSpecialView * content_v2;
    
    WeiBoSpecialView * view_special;
    
}

@property(nonatomic,assign)id<NewWeiBoCustomCellDelegate>delegate;

@property(nonatomic,strong)AsyncImageView * Head_ImageView;

@property(nonatomic,strong)UILabel * UserName_Label;

@property(nonatomic,strong)UILabel * DateLine_Label;

@property(nonatomic,strong)UILabel * from_label;

@property(nonatomic,strong)UIImageView * reply_background_view;

@property(nonatomic,strong)WeiBoSpecialView * content_view_special;

@property(nonatomic,strong)WeiBoSpecialView * content_reply_special;


@property(nonatomic,strong)UIButton * pinglun_button;

@property(nonatomic,strong)UIButton * zhuanfa_button;

@property(nonatomic,strong)UIButton * delete_button;



-(void)setAllViewWithType:(int)theType;

-(float)setInfo:(FbFeed *)info withReplysHeight:(float)theheight WithType:(int)theType;

-(float)returnCellHeightWith:(FbFeed *)info WithType:(int)theType;

-(void)setReplys:(NSString *)theReplys ForWards:(NSString *)theForWards;



@end
