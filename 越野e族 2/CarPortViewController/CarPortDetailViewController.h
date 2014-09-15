//
//  CarPortDetailViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarPortSeg.h"
#import "PictureModel.h"
#import "MWPhotoBrowser.h"
#import "NewsModel.h"
#import "newscellview.h"
#import "LoadingIndicatorView.h"
#import "SummaryModel.h"
#import "CarType.h"
#import "SaleModel.h"

@interface CarPortDetailViewController : MyViewController<CarPortSegDelegate,UITableViewDataSource,UITableViewDelegate,PictureModelDelegate,MWPhotoBrowserDelegate,NewsModelDelegate,UIScrollViewDelegate,SummaryModelDelegate,SaleModelDelegate>{
    CarPortSeg *segview;
    CarPortSeg *threeseg;
    UITableView *imagetableview;//图片的tableview
    NSMutableArray *smallimagearray;
    NSMutableArray *bigimagearray;
    PictureModel *_picmodel;
    NSMutableArray *_photos;
    //新闻的
    UITableView *newstab;
    NewsModel *_newsmodel;
    newscellview *orcell;
    BOOL isnewsloadsuccess;
    int pagesofnews;
    NSMutableArray *newsofidarray;
    NSMutableArray *newsofimgarray;
    NSMutableArray *newsoftitlearray;
    NSMutableArray *newsofdatearray;
    NSMutableArray *newsofdiscriptionarray;
    LoadingIndicatorView *loadview;
    //综合的
    UITableView *summarytabview;
    SummaryModel *_summarymodel;
    NSArray *summarayarrayinfo;
    SaleModel *_salemodel;
    

    


    
}
@property(nonatomic,strong)NSString *string_title;
@property(nonatomic,strong)CarType * the_type;


@end
