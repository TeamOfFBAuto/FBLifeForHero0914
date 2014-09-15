//
//  SearchNewsView.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-3.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SearchNewsView.h"

@implementation SearchNewsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor orangeColor];
    }
    return self;
}
/*
 {
 content = "\U8272\U5f69\U7f24\U7eb7FB STYLE \U8d8a\U91ce\Uff45\U65cf\U65b0\U6b3e\U670d\U88c5\U8bbe\U8ba1\U5927\U7247 1";
 dateline = 1377741875;
 fid = 520;
 fromtype = 2;
 newstype = "\U65b0\U95fb\U8d44\U8baf";
 tid = 58182;
 title = "\U8272\U5f69\U7f24\U7eb7FB STYLE \U8d8a\U91ce\Uff45\U65cf\U65b0\U6b3e\U670d\U88c5\U8bbe\U8ba1\U5927\U7247";
 url = "http://news.fblife.com/html/20130829/58182.html";
 }
 */
-(void)layoutSubviewsWithDicNewsinfo:(NSDictionary*)dicinfo{
    //标题
    UILabel * labeltitle=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 5, 320-25, 20)];
    labeltitle.text=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"title"]];
    labeltitle.font=[UIFont systemFontOfSize:16];
    labeltitle.backgroundColor=[UIColor clearColor];
    labeltitle.textColor=[UIColor blackColor];
    labeltitle.textAlignment=UITextAlignmentLeft;
    [self addSubview:labeltitle];
    //内容
    UILabel * labelcontent=[[UILabel alloc]init];
    labelcontent.text=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"content"]];
    labelcontent.font=[UIFont systemFontOfSize:12];

    CGSize constraintSize = CGSizeMake(310, MAXFLOAT);
    CGSize labelSize = [labelcontent.text sizeWithFont:labelcontent.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    labelcontent.Frame=CGRectMake(12.5, 30, 320-25, labelSize.height);
    
    labelcontent.backgroundColor=[UIColor clearColor];
    labelcontent.textColor=[UIColor grayColor];
    labelcontent.numberOfLines=0;
    labelcontent.lineBreakMode=NSLineBreakByCharWrapping;
    labelcontent.textAlignment=UITextAlignmentLeft;
    [self addSubview:labelcontent];
    //时间
    UILabel * labeltime=[[UILabel alloc]initWithFrame:CGRectMake(195, 30+labelSize.height+5, 110, 20)];
    labeltime.text=[personal timchange:[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"dateline"]]] ;
    labeltime.font=[UIFont systemFontOfSize:12];
    labeltime.backgroundColor=[UIColor clearColor];
    labeltime.textColor=[UIColor grayColor];
    labeltime.textAlignment=UITextAlignmentRight;
    [self addSubview:labeltime];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
