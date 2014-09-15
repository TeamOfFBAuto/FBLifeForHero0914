//
//  recommend.m
//  FbLife
//
//  Created by 史忠坤 on 13-2-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "recommend.h"
#import "JSONKit.h"
@implementation recommend
@synthesize category=_category,imarray=_imarray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     }
    return self;
}
//-(void)setCategory:(NSString *)category{
//    _category=category;
//    _downloadtool=[[downloadtool alloc]init];
//    _downloadtool.delegate=self;
//    NSString *  fullurl = [NSString stringWithFormat:URL_NES,category, @"1",1,@"5"];
//    
//    _downloadtool.url_string=[NSString stringWithFormat:@"%@",fullurl];
//    NSLog(@"fullurl==%@",fullurl);
//    [_downloadtool start];
//}
//-(void)setImarray:(NSArray *)imarray{
//    scro=[[newsimage_scro alloc]initWithFrame:CGRectMake(0, 0, 320, 163)];
//    [scro setImage_array:imarray];
//    [self addSubview:scro];
//}
//-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
//    NSLog(@"haha");
//    dic=[[NSDictionary alloc]init];
//    array_=[[NSArray alloc]init];
//    NSMutableArray *image_mutar=[[NSMutableArray alloc]init];
//    dic = [data objectFromJSONData];
//   // NSLog(@"dic==%@",dic);
//    
//    array_=[dic objectForKey:@"news"];
//    for (int i=0; i<[array_ count]; i++) {
//        NSDictionary *dic_photo=[array_ objectAtIndex:i];
//        NSString *stringphoto=[dic_photo objectForKey:@"photo"];
//        [image_mutar addObject:stringphoto];
//        
//        
//    }
//    NSLog(@"haha=====%@",image_mutar);
// 

//     
//}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    
    return 163;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
