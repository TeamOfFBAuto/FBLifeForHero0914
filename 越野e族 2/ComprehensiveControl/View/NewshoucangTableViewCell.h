//
//  NewshoucangTableViewCell.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-10.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NewshoucangTableViewCellBloc)(int picID);


typedef enum {
    //以下是枚举成员 TestA = 0,
    NewshoucangTableViewCellStyleNews=0,//新闻
    NewshoucangTableViewCellStyleTiezi=1,//帖子
    NewshoucangTableViewCellStyleBankuai=2,//板块
    NewshoucangTableViewCellStyleTuji=3,//图集
    NewshoucangTableViewCellStylemywrite=4,//我发布的

    NewshoucangTableViewCellStylemycomment=5//我回复的

    
    
}NewshoucangTableViewCellStyle;


@interface NewshoucangTableViewCell : UITableViewCell

/**
 *  新闻
 */
@property(nonatomic,strong)UILabel *bigTitleLabel;

@property(nonatomic,strong)UILabel *pindaoLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UIView *newsView;

@property(nonatomic,strong)UIView *viewline;

@property(nonatomic,strong)UIImageView *commentImagev;

@property(nonatomic,assign)NewshoucangTableViewCellStyle mystyle;

@property(nonatomic,assign)NewshoucangTableViewCellBloc mybloc;


-(void)newshoucangTableViewCellSetDic:(NSDictionary *)dic sNewshoucangTableViewCellStyle:(NewshoucangTableViewCellStyle)theStyle thebloc:(NewshoucangTableViewCellBloc)ahabloc;

+(CGFloat)NewshoucangTableViewCellHeightFromstyle:(NewshoucangTableViewCellStyle)thestyle comstr:(NSString *)thestring;


@end
