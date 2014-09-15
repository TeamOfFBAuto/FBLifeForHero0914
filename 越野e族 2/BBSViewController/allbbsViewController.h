//
//  allbbsViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-5.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "subsectionview.h"

@interface allbbsViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,butoonindexdelegate,AlertRePlaceViewDelegate>{
    NSMutableArray *array_name;//group的name,比如e族大队，国内大队等
    NSMutableArray *array_gid;
    UITableView *tab_;
    
    NSMutableArray *array_section;//这个是公益，e族大队等，section的信息
    NSMutableArray *array_row;//2维数组，存放每一个section里面的row的内容，比如山东、北京等
    NSMutableArray *array_detail;
    
    NSMutableArray *array_IDrow;
    NSMutableArray *array_IDdetail;
    
    int mark[1000];
    int isexpand;
    int isexpanded[1000][1000];
    ATMHud *hud;
    
    
    //未选择的主题
    NSMutableArray *unselected_array;
    //选择的主题图片
    NSMutableArray *selected_array;
    //主题
    NSArray *zhutiarray;
    
    //缓存bbs的数据
    
    int isloadsuccess[5];
    
 
    

    
}
@property(nonatomic,strong)NSString *string_zhuti;
@property(nonatomic,assign)int zhutitag;
@end
