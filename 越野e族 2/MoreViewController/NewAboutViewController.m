//
//  NewAboutViewController.m
//  越野e族
//
//  Created by soulnear on 15-2-3.
//  Copyright (c) 2015年 soulnear. All rights reserved.
//

#import "NewAboutViewController.h"

@interface NewAboutViewController ()

@end

@implementation NewAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    
    _logo_imageview.center = CGPointMake(DEVICE_WIDTH/2.0f,_logo_imageview.center.y);
    _mountain_imageview.frame = CGRectMake(0,DEVICE_HEIGHT-64-_mountain_imageview.height,DEVICE_WIDTH,_mountain_imageview.height);
    _copyright_label.center = CGPointMake(DEVICE_WIDTH/2.0f,_mountain_imageview.top - 10 - _copyright_label.height/2.0f);
    
    _version_label.center = CGPointMake(DEVICE_WIDTH/2.0f,_copyright_label.top - 10 - _version_label.height/2.0f);
    
    _version_label.text = [NSString stringWithFormat:@"版本:%@",NOW_VERSION];

    NSString * copyright = @"Copyright©2002-2012FBLIFE.COM\nAll rights reserved";
    _copyright_label.text = [copyright stringByReplacingOccurrencesOfString:@"2012" withString:[self returnCurrentYear]];
    
}
#pragma mark - 获取当前是哪一年
-(NSString *)returnCurrentYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY"];
    NSString *confromTimespStr = [formatter stringFromDate:[NSDate date]];
    
    return confromTimespStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
