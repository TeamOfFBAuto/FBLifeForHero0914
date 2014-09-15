//
//  carinfoViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-10-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInfoModel.h"
@interface carinfoViewController : UIViewController<CarInfoModelDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *tab_;
    NSArray *alldiscribe_array;
    NSArray *allinfo;
    CarInfoModel *_carinfomodel;
    NSMutableArray *header_array;
    NSMutableArray *row_array;
}
@property(nonatomic,strong)NSString *string_cid;
@property(nonatomic,strong)NSString *string_name;

@end
