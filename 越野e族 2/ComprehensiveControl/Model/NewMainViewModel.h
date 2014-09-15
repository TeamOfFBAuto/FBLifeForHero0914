//
//  NewMainViewModel.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-8.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewMainViewModel : NSObject

/**
 *  {
 id: "45",
 tid: "362",
 photo: [
 "http://cmstest.fblife.com/attachments/20140626/140375713381481.jpg",
 "http://cmstest.fblife.com/attachments/20140626/140375713333470.jpg",
 "http://cmstest.fblife.com/attachments/20140626/140375713448172.jpg"
 ],
 title: "车轮上的FB生活",
 stitle: "",
 storeid: "0",
 business: "",
 classid: "0",
 channelid: "0",
 channel_name: "",
 bbsfid: "0",
 forumname: "",
 photosize: "",
 publishtime: "1404443121",
 type: "1"
 },
 
 
 参数	类型及范围	说明
 errno	int	0 正常；大于0 错误
 pages	int	app数量
 id	int	id
 tid	int	商城,主题,新闻，图集id
 title	string	标题
 stitle	string	小标题
 storeid	int	商家id
 business	string	商家姓名
 classid	int	新闻类别id
 channelid	Int	新闻频道id
 channel_name	string	新闻频道名称
 bbsfid	int	板块id
 forumname	string	板块名称
 photo	string	照片地址(type:1   照片地址为数组)
 photosize	string	照片尺寸
 publishtime	int	新闻发布时间
 type	int	类别（0：新闻，1图集，2论坛，3商城）
 shownum//第几个
 
 */

@property(nonatomic,strong)NSString *theid;//没啥用

@property(nonatomic,strong)NSString *tid;//商城,主题,新闻，图集id

@property(nonatomic,strong)NSArray *photo;//图片是一个数组，有可能多个

@property(nonatomic,strong)NSString *title;//标题

@property(nonatomic,strong)NSString *stitle;//短标题

@property(nonatomic,strong)NSString *storeid;//商店的id

@property(nonatomic,strong)NSString *business;//商店的名

@property(nonatomic,strong)NSString *classid;//新闻类别的id

@property(nonatomic,strong)NSString *channelid;//新闻平道id

@property(nonatomic,strong)NSString *channel_name;//新闻频道的名称

@property(nonatomic,strong)NSString *bbsfid;//板块的id

@property(nonatomic,strong)NSString *forumname;//板块的名称

@property(nonatomic,strong)NSString *type;//类别（0：新闻，1图集，2论坛，3商城）

@property(nonatomic,strong)NSString *publishtime;//发布的时间

@property(nonatomic,strong)NSString *likes;//赞的数量

@property(nonatomic,strong)NSString *shownum;//赞的数量

@property(nonatomic,strong)NSString *comment;//评论的数量





-(void)NewMainViewModelSetdic:(NSDictionary *)thedic;






@end
