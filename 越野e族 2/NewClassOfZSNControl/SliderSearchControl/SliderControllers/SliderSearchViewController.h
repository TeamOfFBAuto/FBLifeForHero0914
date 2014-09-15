//
//  SliderSearchViewController.h
//  越野e族
//
//  Created by soulnear on 14-8-11.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentView.h"
#import "NewWeiBoCustomCell.h"


@interface SliderSearchViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CustomSegmentViewDelegate,NewWeiBoCustomCellDelegate,MWPhotoBrowserDelegate>
{
    
}


///主视图，显示数据
@property(nonatomic,strong)UITableView * myTableView;


///存放所有数据
@property(nonatomic,strong)NSMutableArray * data_array;

@property(nonatomic,strong)NSMutableArray * array_searchresault;

@property(nonatomic,strong)NSMutableArray * photos;


@end
