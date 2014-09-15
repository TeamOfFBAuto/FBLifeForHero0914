//
//  guanzhuCell.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-1.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface guanzhuCell : UITableViewCell{
    UILabel *label_suozaidi;
}
@property (nonatomic,strong)AsyncImageView *imagetouxiang;
@property(nonatomic,strong)UILabel *label_username;
@property(nonatomic,strong)UILabel *label_location;
@property(nonatomic,strong)NSMutableArray *array_all;

@end
