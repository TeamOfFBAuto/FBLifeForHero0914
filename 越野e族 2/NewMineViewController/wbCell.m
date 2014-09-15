//
//  wbCell.m
//  FbLife
//
//  Created by 史忠坤 on 13-2-28.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "wbCell.h"

@implementation wbCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
