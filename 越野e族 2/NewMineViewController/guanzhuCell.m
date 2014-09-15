//
//  guanzhuCell.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-1.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "guanzhuCell.h"

@implementation guanzhuCell
@synthesize label_location,label_username,imagetouxiang,array_all;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        
    }
    return self;
}

//[self.touxiangImageView setFrame:CGRectMake( 10, 10,50 , 50)];
//
//self.userNameLabel.frame = CGRectMake(70, 15,200, 20);
//
//self.fromLabel.frame = CGRectMake(70, 40,200, 20);

-(void)layoutSubviews{
    self.imagetouxiang=[[AsyncImageView alloc]initWithFrame:CGRectMake( 10, 10,50 , 50)];
   // self.imagetouxiang.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.imagetouxiang];
    self.label_username=[[UILabel alloc]initWithFrame:CGRectMake(70, 15,200, 20)];
    [self.contentView addSubview:self.label_username];
    self.label_location=[[UILabel alloc]initWithFrame:CGRectMake(70, 40, 200, 20)];
    [self.contentView addSubview:self.label_location];
}
-(void)setArray_all:(NSMutableArray *)_array_all{
     self.array_all=_array_all;
    [self.imagetouxiang loadImageFromURL:[self.array_all objectAtIndex:0] withPlaceholdImage:nil];
    self.label_username.text=[NSString stringWithFormat:@"%@",[self.array_all objectAtIndex:1]];
    self.label_location.text=[NSString stringWithFormat:@"%@",[self.array_all objectAtIndex:2]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
