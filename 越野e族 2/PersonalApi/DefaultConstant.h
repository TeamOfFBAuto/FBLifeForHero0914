//
//  DefaultConstant.h
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-9.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import <UIKit/UIKit.h>
/*对应全view旋转
 #import <Three20/Three20.h>
 #define ALL_FRAME TTScreenBounds()
 */



//

//app当前版本

#define NOW_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


//@某人添加

#define REPLY_FRONT @"<a href=\"fb://replys/reply\">"
#define REPLY_BACK @"</a>"



#define AUTHKEY [[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]


// 是否是iphone5
#define IPHONE5_HEIGHT 568
#define IPHONE4_HEIGHT 480
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


//颜色

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define iphone5fram 568-20-40-40-49
#define iphone4fram 480-20-40-40-49

//监听键盘的宏定义
#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

#define kSCNavBarImageTag 10
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//整屏幕的Frame
#define ALL_FRAME [UIScreen mainScreen].applicationFrame
//title的高度
#define TITLE_HEIGHT 44
//底部菜单的高度
#define MENU_HEIGHT 49
#define NEWS_HEIGHT 37
///////////////////////////////////我是分界线///////////////////////////////////////////////////
//cell的各种高度
#define CELL_TOUXIANG 35 //头像的大小
#define CELL_TOP 5//头像距离上面的距离
#define CELL_LEFT 8//头像距离左边的距离
#define CELL_CONTENT_LEFT 10//正文距离头像的距离
#define CELL_NAME_TOP 8//名字距离顶部的距离
#define CELL_CONTENT_TOP 33//正文距离顶部的距离
#define CELL_IMRFSIZE 12//评论和转发的图片大小
#define CELL_CONTENTIMAGE_SIZE 78//内容图片大小
#define CELL_CONTENTIMAGE_TOP 10 //图片距离上面内容的距离
#define CELL_RCONTENTIMAGE_LEFT 10//转发中的图片距离左边的距离

//微博详细页的各种高度和距离
#define DETAIL_LEFT 10 //头像距离左边的距离
#define DETAIL_TOUXIANG 50 //头像的大小
#define DETAIL_TOP 10 //头像距离上面的距离
#define DETAIL_NAME_LEFT 17 //名字距离头像的距离
#define DETAIL_NAME_TOP 30 //名字距离头部的距离
#define DETAIL_TOPLINE_TOP 10//名字下面的线距离上面头像的距离
#define DETAIL_CONTENT_TOP 13 //内容距离上面线的距离
#define DETAIL_CONTENT_LEFT 13 //内容距离左边的距离
#define DETAIL_FROM_LEFT 15//来自那里距离左侧时间的距离
#define DETAIL_REVIEW_BOTTOM 10//评论距离底部线的距离
#define DETAIL_FORWARD_LEFT 20 //转发距离左侧评论的距离
#define DETAIL_FROM_BOTTOM 21 //来自那里距离下面评论的距离
#define DETAIL_FROM_TOP 10 //来自那里距离上面内容的距离
#define DETAIL_IMAGE_WIDTH 240 //内容中图片的宽度
#define DETAIL_IMAGE_HEIGHT 182//内容中图片的高度
#define DETAIL_IMAGE_TOP 15//图片距离上面内容的距离
#define DETAIL_IMAGE_BOTIOM 5 //图片距离下面的距离
#define DETAIL_RFORWARD_RIGHT 19 //原文转发数量距离右面的距离
#define DETAIL_RFORWARD_TOP 12 //原文转发距离上面的距离
#define DETAIL_FORWARD_TOP 5//转发距离上面内容的距离d
#define DETAIL_RCONTENTIMAGE_TOP 15 //转发图片距离上面的距离
#define REPLYS_IMAGE_ZIZE 17 //微博详细中的评论回复图片的大小
//个人信息view的各种距离
#define USER_TOUXIANG_TOP 12 //头像距离上面的距离
#define USER_TOUXIANG_LEFT 10 //头像距离左边的距离
#define USER_TOUXIANG_SIZE 79 //头像的大小
#define USER_NAME_TOP 24 //名字距离上面的距离
#define USER_NAME_LEFT 12 //名字距离左边头像的距离
#define USER_BACKVIEW_WIDTH 320 //背景的宽度
#define USER_BACKVIEW_HEIGHT 172 //北京的高度
#define USER_GENDER_LEFT 10 //男女距离左边名字的距离
#define USER_GENDER_SIZE 16 //男女图片的大小
#define USER_BTN_WIDTH 66//btn的宽度
#define USER_BTN_HEIGHR 55//btn的高度
#define USER_BTN_BOTOM 8//btn距离下面的距离
#define USER_BTN_IN 10//两个btn之间的距离
#define USER_GUANZHU_TOP 59 //关注按钮距离上面的距离
#define USER_GUANZHU_WIDTH 100//关注按钮的宽度
#define USER_GUANZHU_HEIGHT 30//关注按钮的高度
#define USER_WEIBO_HEIGHT 33//底部微博条数的高度
#define USER_BOTOM 10 //整体距离下面的距离
///////////////////////////////////我是分界线///////////////////////////////////////////////////
//保存用户信息的常量key
#define USER_FACE @"userface"
#define USER_NAME @"username"
#define USER_PW @"userPw"
#define USER_UID @"useruid"
#define USER_IN @"user_in" //0是未登陆  1是已登陆
#define USER_AUTHOD @"user_authod"
#define USER_CHECKUSER @"checkfbuser"
#define TUPIANZHILIANG @"tupianzhiliang"
#define NOTIFICATION_QUXIAOGUANZHU @"quxiaoguanzhu"
#define NOTIFICATION_TIANJIAGUANZHU @"tianjiaguanzhu"
#define NOTIFICATION_REPLY @"reply"
#define DEVICETOKEN @"pushdevicetoken"

///////////////////////////////////我是分界线///////////////////////////////////////////////////
//提示用信息  start
#define NS_LOGINING @"登录中..."
#define NS_ACTIVEING @"激活中..."
#define NS_WEIBO_DEL @"原微博已经删除"
#define NS_TISHI @"温馨提示"
#define NS_TISHI_KONG @"请输入微博内容！"
#define NS_KNOWED @"知道了"
#define NS_UPLOADING @"发布中..."
#define NS_PAIZHAO @"拍照"
#define NS_XIANGCE @"用户相册"
#define NS_CANCAL @"取消"
#define NS_DELWENZI @"清除文字"
#define NS_CODEING @"敬请期待..."
#define NS_REPLY_OLD @"评论给原文作者"
#define NS_FORWARD_SELF @"转发到我的自留地"
#define NS_REPLYS_NULL @"请输入评论内容!"
#define NS_FOREARD_NULL @"请输入转发内容!"
#define NS_EXIT_SUC @"成功退出!"
#define NS_CASH_SUC @"清除缓存成功!"
#define NS_DOING @"处理中..."
#define NS_JIAZAIING @"加载中..."
///////////////////////////////////我是分界线///////////////////////////////////////////////////
#define KEntityName            @"___Entity_Name___"
#define kEntityType            @"___Entity_Type___"
#define kEntityValue        @"___Entity_Value___"
#define BBSINFO @"bbsinfo"
#define USERINFO @"userinfo"
#define ERRCODE @"errcode"
//解析xml数据用到的常量
#define BBS_UID @"uid"
#define BBS_USERNAME @"discuz_user"
#define BBS_NICKNAME @"bbsnickname"
#define BBS_LOCATION @"bbslocation"
#define BBS_GENDER @"bbsgender"
#define BBS_BDAY @"bbsbday"
#define BBS_EMAIL @"bbsemail"
#define BBS_BIO @"bbsbio"
#define BBS_

//解析json数据用到的常量
#define ERRCODE @"errcode"
#define TOTAL @"total"
#define DATA @"data"

#define BLOG_ID @"blogid"
#define BLOG_TITLE @"title"
#define BLOG_CONTENT @"content"
#define BLOG_DATELINE @"dateline"
#define BLOG_PHOTO @"photo"

#define PHOTO_AID @"aid"
#define PHOTO_TITLE @"title"
#define PHOTO_CONTENT @"content"
#define PHOTO_DATELINE @"dateline"

#define FB_TID @"tid"
#define FB_UID @"uid"
#define FB_USERNAME @"username"
#define FB_CONTENT @"content"
#define FB_EXTENSION @"extension"
#define FB_IMAGEID @"imageid"
#define FB_REPLYS @"replys"
#define FB_FORWARDS @"forwards"
#define FB_ROOTTID @"roottid"
#define FB_TOTID @"totid"
#define FB_TOUID @"touid"
#define FB_TOUSERNAME @"tousername"
#define FB_DATELINE @"dateline"
#define FB_FROM @"from"
#define FB_TYPE @"type"
#define FB_SORT @"sort"
#define FB_SORTID @"sortid"
#define FB_IMAGE_ORIGINAL @"image_original"
#define FB_IMAGE_SMALL @"image_small"
#define FB_JING_LNG @"jing_lng"
#define FB_WEI_LAT @"wei_lat"
#define FB_LOCALITY @"locality"
#define FB_FACE_SMALL @"face_small"
#define FB_FACE_ORIGINAL @"face_original"

#define FB_EX_TITLE @"title"
#define FB_EX_FORUM_CONTENT @"forum_content"
#define FB_EX_AUTHOR @"author"
#define FB_EX_AUTHORID @"authorid"
#define FB_EX_PHOTO @"photo"
#define FB_EX_TIME @"time"

#define FB_BBS_BBSID @"bbsid"
#define FB_BBS_TITLE @"title"
#define FB_BBS_CONTENT @"content"
#define FB_BBS_UID @"uid"
#define FB_BBS_USERNAME @"username"
#define FB_BBS_PHOTO @"photo"

#define NEWS_ID @"id"
#define NEWS_TITLE @"title"
#define NEWS_CONTENT @"content"
#define NEWS_PUBLISHTIME @"publishtime"
#define NEWS_SUMMARY @"summary"
#define NEWS_PHOTO @"photo"

///////////////////////////////////我是分界线///////////////////////////////////////////////////
//登陆url
#define LOGIN_URL @"http://bbs.fblife.com/bbsapinew/login.php?username=%@&password=%@&formattype=json&token=%@"
//验证用户是否开通FB
#define CHECK_FBUSER_URL @"http://fb.fblife.com/openapi/index.php?mod=account&code=checkfbuser&authkey=%@&fbtype=json"
//激活Fb账号
#define ACTIVE_FBUSER_URL @"http://fb.fblife.com/openapi/index.php?mod=account&code=activeuser&authkey=%@&fbtype=json"

//全部的url  1
#define FB_WEIBOMYSELF_URL @"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=myfeed&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"
//@到我的url  2
#define FB_WEIBOMYAT_URL @"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=myat&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"
//我评论的url 3
#define FB_WEIBOTOCOMMENT_URL @"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=tocomment&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"
//评论我的url  4
#define FB_WEIBOMYCOMMENT_URL @"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=mycomment&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"
//我的微博    5
#define FB_WEIBOMYLIST_URL @"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=mylist&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json&uid=%@"
//不登陆查看微博广场url 6
#define FB_WEIBOALL_URL @"http://fb.fblife.com/openapi/index.php?mod=dotopic&code=weiboSquare&fromtype=b5eeec0b&page=%i&fbtype=json"


#define FB_DELETEWEIBO_URL @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=delcontent&tid=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"



//文集接口

#define URLWENJI @"http://fb.fblife.com/openapi/index.php?mod=getblog&code=blogview&bid=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"



//上传接口---start
#define URLIMAGE @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=addpicmuliti&fromtype=b5eeec0b&authkey=%@fbtype=json"
#define URL_UPLOAD @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=add&content=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"
#define URLIMAGEID @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=add&content=%@&imgid=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"
#define URLJWD @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=add&content=%@&imgid=%@&fromtype=b5eeec0b&authkey=%@&jing_lng=%f&wei_lat=%f&locality=%@&map=google&fbtype=json"

//上传接口---end
//根据用户名搜索
#define URL_SERCH_USER @"http://fb.fblife.com/openapi/index.php?mod=search&code=user&username=%@&fromtype=b5eeec0b&page=%d&fbtype=json"
//搜索用户url
#define  URL_SERCH_PER @"http://fb.fblife.com/openapi/index.php?mod=getuser&code=atuser&atuser=%@&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"
//获取微博详细包括评论信息
#define  URL_WEIBO_DETAIL @"http://fb.fblife.com/openapi/index.php?mod=getweibo&code=weibocomment&tid=%@&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"
//发表评论信息
#define  URL_REPLY @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=addcomment&content=%@&tid=%@&type=%@&fromtype=b5eeec0b&authkey=%@&isyw=%@&fbtype=json"
//转发
#define URL_FORWARD @"http://fb.fblife.com/openapi/index.php?mod=doweibo&code=addforward&content=%@&tid=%@&forwardtid=%@&type=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"
//获取用户信息
#define URL_USERMESSAGE @"http://fb.fblife.com/openapi/index.php?mod=getuser&code=base&uid=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"

//获取画廊详细和画廊中的图片
#define URL_HUALANG @"http://fb.fblife.com/openapi/index.php?mod=getphoto&code=albumshow&fromtype=b5eeec0b&authkey=%@&page=1&numpage=200&aid=%@&fbtype=json"
//取消关注url
#define URL_QUXIAOGUANZHU @"http://fb.fblife.com/openapi/index.php?mod=douser&code=cancelfollow&touid=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"
//关注url
#define URL_GUANZHU @"http://fb.fblife.com/openapi/index.php?mod=douser&code=addfollow&touid=%@&fromtype=b5eeec0b&authkey=%@&fbtype=json"
//获取关注的用户列表
#define URL_GUANZHULIST @"http://fb.fblife.com/openapi/index.php?mod=getuser&code=follow&uid=%@&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"

//获取关注的所有用户列表

#define URL_ALL_GUANZHULIST @"http://fb.fblife.com/openapi/index.php?mod=getuser&code=allfollow&fromtype=b5eeec0b&authkey=%@&fbtype=json"

//获取粉丝的用户列表
#define URL_FANSLIST @"http://fb.fblife.com/openapi/index.php?mod=getuser&code=fans&uid=%@&fromtype=b5eeec0b&authkey=%@&page=%i&fbtype=json"

//论坛获取个人信息
#define URL_BBS_USERMESSAGE @"http://bbs.fblife.com/bbsapi/getuser.php?&uid=%@&authcode=%@"
//论坛获取所有版面信息url
#define URL_BBS_ALL @"http://bbs.fblife.com/bbsapi/getforums_all.php"
//获取版块下面的帖子 按照主题发布时间排序
#define URL_BBS_GETTIEZI_TIME @"http://bbs.fblife.com/bbsapi/getforumthread.php?fid=%@&page=%i&orderby=1"
//获取版块下面的帖子 按照回复排序
#define URL_BBS_GETTIEZI_HUIFU @"http://bbs.fblife.com/bbsapi/getforumthread.php?fid=%@&page=%i"
//获取版块下面的精华帖子
#define URL_BBS_GETTIEZI_JINGHUA @"http://bbs.fblife.com/bbsapi/getforumdigest.php?fid=%@&page=%i"
//发表帖子接口
#define URL_BBS_FT @"http://bbs.fblife.com/bbsapi/postthread.php?fid=%@&subject=%@&message=%@&authcode=%@"
//回复帖子接口
#define URL_BBS_HF @"http://bbs.fblife.com/bbsapi/postreply.php?fid=%@&tid=%@&subject=%@&message=%@&authcode=%@"
//获取帖子详细内容 查看全部
#define URL_BBS_TIEZIDETAIL @"http://bbs.fblife.com/bbsapi/getthreads.php?tid=%@&page=%i"
//获取帖子详细内容 只看楼主
#define URL_BBS_TIEZIDETAIL_LOUZHU @"http://bbs.fblife.com/bbsapi/getthreadauthor.php?tid=%@&page=%i"
//获取咨询列表
#define URL_NES @"http://xcms.fblife.com/ajax.php?c=news&a=newslist&classname=%@&iscommend=%@&page=%i&pagesize=%@&type=json"
#define URL_NESTEST @"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=newslist&classname=%@&iscommend=%@&page=%i&pagesize=%@&type=json"


#define Search_weiBo @"http://fb.fblife.com/openapi/index.php?mod=search&code=content&topic=%@&fromtype=b5eeec0b&page=%d&fbtype=json"



#define Search_user @"http://bbs.fblife.com/bbsapinew/getuserinfo.php?username=%@&formattype=json"




//车库接口


//按分类搜索车型
#define Search_car_type @"http://carport.fblife.com/carapi/getsortsearchlist.php?type=%@&datatype=json"

//查找品牌下所有车系


#define Search_cars @"http://carport.fblife.com/carapi/getserieslist.php?words=%@&datatype=json"

//按条件筛选车系

#define Screening_cars @"http://carport.fblife.com/carapi/getsortserieslist.php?datatype=json&type=%d&size=%d&country=%d&price=%d&page=%d&pagesize=20"


//查找所有品牌

#define Search_all_brand @"http://carport.fblife.com/carapi/getcaralllist.php?datatype=json&groupid=0"





//注册


#define SENDPHONENUMBER @"http://bbs.fblife.com/bbsapinew/register.php?type=phone&step=1&telphone=%@&keycode=e2e3420683&datatype=json"

#define SENDERVerification @"http://bbs.fblife.com/bbsapinew/register.php?type=phone&step=2&telphone=%@&telcode=%@&datatype=json"

#define SENDUSERINFO @"http://bbs.fblife.com/bbsapinew/register.php?type=phone&step=3&telphone=%@&telcode=%@&username=%@&password=%@&email=%@&datatype=json"



//排行榜接口

#define RANKING_LIST @"http://bbs.fblife.com/bbsapinew/cmsappgetranking.php?type=%d&formattype=json"



#pragma mark - 查看某个图集接口


#define GET_PICTURES_URL @"http://cmsweb.fblife.com/ajax.php?c=photo&a=getphotolist&id=%@&type=json"

#pragma mark - 查看图集的收藏接口

#define GET_ATLAS_COLLECTION_URL @"http://cmsweb.fblife.com/ajax.php?c=photo&a=favoriteslist&type=json&took=%@"


#pragma MARK - 图集评论接口

#define ATLAS_COMMENT_URL @"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentadd&sort=15&sortid=%@&content=%@&title=%@&fromtype=b5eeec0b&authkey=%@"

#define ATLAS_COMMENT_URL2 @"http://fb.fblife.com/openapi/index.php?mod=comment&code=commentadd&sort=15&sortid=%@&content=%@&title=%@&intro=%@&photo=%@&fromtype=b5eeec0b&authkey=%@"


#pragma mark - 赞图集的接口

#define ATLAS_PRAISE_URL @"http://cmsweb.fblife.com/ajax.php?c=photo&a=addlikes&type=json&id=%@"


#pragma mark - 收藏图集的接口

#define ATLAS_COLLECTION_URL @"http://cmsweb.fblife.com/ajax.php?c=photo&a=addfavorites&type=json&took=%@&id=%@"


#pragma mark - 取消图集收藏的接口


#define ATLAS_CANCEL_COLLECTION_URL @"http://cmsweb.fblife.com/ajax.php?c=photo&a=delfavorites&type=json&took=%@&id=%@"


#pragma mark - 获取图集web地址接口

#define GET_ATLAS_WEB_URL @"http://special.fblife.com/listphoto/%@.html"


#pragma mark - 获取所有收藏的板块接口

#define GET_ALL_COLLECTION_SECTION @"http://bbs.fblife.com/bbsapinew/favoritesforums.php?authcode=%@&action=query&formattype=json&pagesize=%d"

#pragma mark - 收藏论坛版块接口-新接口

#define COLLECTION_FORUM_SECTION_URL @"http://bbs.fblife.com/bbsapinew/addfavoritesthread.php?authcode=%@&tid=%@&formattype=json"

#pragma mark - 收藏论坛版块接口-旧接口

#define COLLECTION_FORUM_SECTION_URL_OLD @"http://bbs.fblife.com/bbsapinew/favoritesforums.php?fid=%@&action=add&formattype=json&authcode=%@"

#pragma mark - 获取论坛精选数据

#define BBS_JINGXUAN_URL @"http://cmsweb.fblife.com/ajax.php?c=newstwo&a=getappindex&page=%d&type=json&pagesize=20&datatype=3&type=json"


#pragma mark - 取消收藏论坛版块接口-新接口

#define COLLECTION_CANCEL_FORUM_SECTION_URL @"http://bbs.fblife.com/bbsapinew/delfavoritesthread.php?delid=%@&formattype=json&authcode=%@"

#pragma mark - 取消收藏论坛版块接口-旧接口

#define COLLECTION_CANCEL_FORUM_SECTION_URL_OLD @"http://bbs.fblife.com/bbsapinew/delfavorites.php?delid=%@&formattype=json&authcode=%@"


#pragma mark - 收藏帖子接口

#define COLLECTION_BBS_POST_URL @"http://bbs.fblife.com/bbsapinew/addfavoritesthread.php?authcode=%@&tid=%@&formattype=json"

#pragma mark - 查看收藏的帖子

#define GET_COLLECTION_BBS_POST_URL @"http://bbs.fblife.com/bbsapinew/favoritesthread.php?authcode=%@&formattype=json&page=1&pagesize=2000"

#pragma mark - 删除收藏的帖子

#define DELETE_COLLECTION_BBS_POST_URL @"http://bbs.fblife.com/bbsapinew/delfavoritesthread.php?delid=%@&formattype=json&authcode=%@"
















