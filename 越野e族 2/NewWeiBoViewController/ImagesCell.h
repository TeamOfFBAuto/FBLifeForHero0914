//
//  ImagesCell.h
//  FbLife
//
//  Created by soulnear on 13-3-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//


@protocol ImageCellDelegate <NSObject>

-(void)showDetailImage:(UITableViewCell *)cell imageTag:(int)image;

@end


#import <UIKit/UIKit.h>

@interface ImagesCell : UITableViewCell
{
    
}


@property(nonatomic,assign)id<ImageCellDelegate>delegate;
@property(nonatomic,strong)AsyncImageView * imageView1;
@property(nonatomic,strong)AsyncImageView * imageView2;
@property(nonatomic,strong)AsyncImageView * imageView3;
@property(nonatomic,strong)AsyncImageView * imageView4;

-(void)setAllView;


-(void)setDelegate:(id<ImageCellDelegate>)delegate1;

@end
