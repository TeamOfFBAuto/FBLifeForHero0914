//
//  ZkingAlert.h
//  越野e族
//
//  Created by 史忠坤 on 14-7-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZkingAlert : UIImageView

@property(nonatomic,strong)UILabel *textLabel;

- (id)initWithFrame:(CGRect)frame labelString:(NSString *)_string;

-(void)zkingalertShowWithString:(NSString *)thestr;


-(void)ZkingAlerthide;
@end
