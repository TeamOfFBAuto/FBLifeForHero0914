//
//  recommend.h
//  FbLife
//
//  Created by 史忠坤 on 13-2-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "downloadtool.h"
#import "newsimage_scro.h"

@interface recommend : UITableViewCell{
    newsimage_scro *scro;

}
@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSArray *imarray;
@end
