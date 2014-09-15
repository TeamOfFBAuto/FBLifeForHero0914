//
//  AtlasContentView.h
//  越野e族
//
//  Created by soulnear on 14-7-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtlasModel.h"

@interface AtlasContentView : UIView<UITextViewDelegate>
{
    
    
    
}


@property(nonatomic,strong)UILabel * title_label; //图片标题

@property(nonatomic,strong)UILabel * current_page; //当前页数及总页数

@property(nonatomic,strong)UITextView * content_textView; //当前图片简介




-(void)reloadInformationWith:(AtlasModel *)model WithCurrentPage:(int)thePage WithTotalPage:(int)totalPage;

@end
