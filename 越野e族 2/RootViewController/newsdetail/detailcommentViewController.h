//
//  detailcommentViewController.h
//  FblifeAll
//
//  Created by szk on 13-1-21.
//  Copyright (c) 2013年 fblife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
#import "FaceScrollView.h"
#import "EGORefreshTableHeaderView.h"
@interface detailcommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UITextFieldDelegate,UIActionSheetDelegate>{
    
    UIView *aview;
    FaceScrollView *faceScrollView;
    UITableView *tab_pinglunliebiao;
    
    UILabel *label_bigbiaoti;
    UITextField *text_write;
    UIView *view_pinglun;
    
    
	EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL isjianpan;//判断是facebutton是键盘还是face
    BOOL isloadsuccess;//只有刷新加载过程完成了才能进行下一次加载
    BOOL _reloading;
    
    NSMutableArray *array_name;//评论者
    NSMutableArray *array_time;//评论的时间
    NSMutableArray *array_content;//评论的具体内容
    NSMutableArray *array_weiboinfo;//整体的微博
    NSDictionary *dic_info;//每一条微博都是一个字典
    
    
    
}
@property(nonatomic,assign)int allcount;
@property(nonatomic,strong)NSString *string_ID;
@end
