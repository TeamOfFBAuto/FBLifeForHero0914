//
//  CompreTableViewCell.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-1.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>






typedef void(^CompreTableViewCellBloc)(NSString *thebuttontype,NSDictionary *dic,NSString * theWhateverid);


typedef enum {
    //以下是枚举成员 TestA = 0,
    CompreTableViewCellStyleHuandeng=0,//幻灯
    CompreTableViewCellStylePictures=1,//图集
    CompreTableViewCellStyleText=2,//其余

    
}CompreTableViewCellStyle;






@interface CompreTableViewCell : UITableViewCell{

    NSMutableArray *com_id_array;//幻灯的id
    NSMutableArray *com_type_array;//幻灯的type
    NSMutableArray *com_link_array;//幻灯的外链
    NSMutableArray *com_title_array;//幻灯的标题
    
//    NewHuandengView *bannerView ;//幻灯的view;

}



@property(assign,nonatomic)CompreTableViewCellStyle mystyle;

@property(copy,nonatomic)CompreTableViewCellBloc mybloc;


//@property(assign,nonatomic)CompreTableViewCellBloc normalBloc;



@property(nonatomic,strong)NSMutableArray * commentarray;//幻灯的array


//图集这样显示

@property(nonatomic,strong)UILabel *bigLabel;//图集的大标题

@property(nonatomic,strong)AsyncImageView *leftImageV;//左边的图片

@property(nonatomic,strong)AsyncImageView *centerImageV;//中间的图片

@property(nonatomic,strong)AsyncImageView *rightImageV;//右边的图片

@property(nonatomic,strong)UIImageView *zanImageV;//赞的图标

@property(nonatomic,strong)UILabel *zanlabel;//赞的数量

@property(nonatomic,strong)UIButton  *bigLeixing;//新闻、论坛或者是图集

@property(nonatomic,strong)UIButton  *littleLeixing;//频道神马的

@property(nonatomic,strong)UIView *picView;//图集都放到这个上面

//普通的这样展示


@property(nonatomic,strong)UILabel *textBigLabel;//普通的大标题

@property(nonatomic,strong)AsyncImageView *textleftImageV;//左边的图片


@property(nonatomic,strong)AsyncImageView *ttzanImageV;//赞的图标

@property(nonatomic,strong)UILabel *ttzanlabel;//赞的数量

@property(nonatomic,strong)UIButton  *ttbigLeixing;//新闻、论坛或者是图集

@property(nonatomic,strong)UIButton  *ttlittleLeixing;//频道神马的

@property(nonatomic,strong)UIView *textView;//普通的都放到这个上面

@property(nonatomic,strong)UIView *normalLine;//分割线

@property(nonatomic,strong)UIImageView *littleAndBigLine;



@property(nonatomic,strong)UIView *testV;

@property(nonatomic,strong)UILabel *fenGeLine;

//数据处理

@property(nonatomic,strong)NSDictionary *myDic;





- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CompreTableViewCellStyle)sstyle;




-(void)setDic:(NSDictionary *)theDic cellStyle:(CompreTableViewCellStyle)theStyle thecellbloc:(CompreTableViewCellBloc)thebloc;

-(void)normalsetDic:(NSDictionary *)theDic cellStyle:(CompreTableViewCellStyle)theStyle thecellbloc:(CompreTableViewCellBloc)thebloc;

//-(UIView *)getHeaderViewWithDic:(NSDictionary*)headerDic headerbloc:(CompreTableViewCellBloc)hhbloc;



+(CGFloat)getHeightwithtype:(CompreTableViewCellStyle)theResourceStyle;

@end
