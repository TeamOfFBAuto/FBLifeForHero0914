//
//  detailbbsview.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-12.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "detailbbsview.h"
#import "personal.h"
@implementation detailbbsview

@synthesize dic_object;
- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame ];
    if (self) {
        titleLabel=[[UILabel alloc]init];
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.numberOfLines=2;
        titleLabel.lineBreakMode = UILineBreakModeWordWrap|UILineBreakModeTailTruncation;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];

        authorLabel=[[UILabel alloc]init];
        authorLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        authorLabel.textColor=[UIColor grayColor];
        authorLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:authorLabel];

        createTimeLabel=[[UILabel alloc]init];
        createTimeLabel.font = [UIFont systemFontOfSize:10];
        createTimeLabel.textColor= [UIColor brownColor];
        createTimeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:createTimeLabel];

        repliesLabel=[[UILabel alloc]init];
        repliesLabel.font = [UIFont systemFontOfSize:10];
        repliesLabel.textColor=[UIColor grayColor];
        repliesLabel.backgroundColor = [UIColor clearColor];
        repliesLabel.textAlignment=UITextAlignmentRight;
        [self addSubview:repliesLabel];
        
        [titleLabel setFrame:CGRectMake( 15, 5,ALL_FRAME.size.width-33, 35)];
        CGSize titleconstraintSize= CGSizeMake(titleLabel.frame.size.width,MAXFLOAT);
        CGSize titleexpectedSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:titleconstraintSize lineBreakMode:UILineBreakModeWordWrap];
        if (titleexpectedSize.height>38) {
            titleexpectedSize.height=38;
        }
        titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleexpectedSize.height);
        //
        [authorLabel setFrame:CGRectMake( 15, titleexpectedSize.height+7,95, 30)];
        CGSize authorconstraintSize= CGSizeMake(authorLabel.frame.size.width,MAXFLOAT);
        CGSize authorexpectedSize = [authorLabel.text sizeWithFont:authorLabel.font constrainedToSize:authorconstraintSize lineBreakMode:UILineBreakModeWordWrap];
        authorLabel.frame = CGRectMake(authorLabel.frame.origin.x, authorLabel.frame.origin.y, authorexpectedSize.width, authorexpectedSize.height);
        
        //
        [createTimeLabel setFrame:CGRectMake( authorLabel.frame.origin.x+authorexpectedSize.width+10, titleexpectedSize.height+7,100, 30)];
        CGSize createTimeconstraintSize= CGSizeMake(createTimeLabel.frame.size.width,MAXFLOAT);
        CGSize createTimeexpectedSize = [createTimeLabel.text sizeWithFont:createTimeLabel.font constrainedToSize:createTimeconstraintSize lineBreakMode:UILineBreakModeWordWrap];
        createTimeLabel.frame = CGRectMake(createTimeLabel.frame.origin.x, createTimeLabel.frame.origin.y, createTimeexpectedSize.width, createTimeexpectedSize.height);
        
        //
        [repliesLabel setFrame:CGRectMake( createTimeLabel.frame.origin.x+createTimeexpectedSize.width+5, titleexpectedSize.height+7,ALL_FRAME.size.width-authorLabel.frame.size.width-createTimeLabel.frame.size.width-55, 15)];
        
        

        // Initialization code
    }
    return self;
}
-(void)setDic_object:(NSDictionary *)_dic_object{
    self.dic_object=_dic_object;
    titleLabel.text=[self.dic_object objectForKey:@"title"];
    authorLabel.text=[self.dic_object objectForKey:@"author"];
    NSString *string_time=[personal timchange:[self.dic_object objectForKey:@"dateline"]];
    createTimeLabel.text=string_time;
    repliesLabel=[NSString stringWithFormat:@"%@ / %@",[self.dic_object objectForKey:@"replies" ],[self.dic_object objectForKey:@"views"]];
    
}
//-(void)setDic_object:(NSDictionary *)_dic_object_{
//   _dic_object=[[NSDictionary alloc]init];
//    _dic_object=_dic_object_;
//    
//    titleLabel.text=[_dic_object objectForKey:@"title"];
//    authorLabel.text=[_dic_object objectForKey:@"author"];
//    NSString *string_time=[personal timchange:[_dic_object objectForKey:@"dateline"]];
//    createTimeLabel.text=string_time;
//    repliesLabel=[NSString stringWithFormat:@"%@ / %@",[_dic_object objectForKey:@"replies" ],[_dic_object objectForKey:@"views"]];
//    
//}
//
//+(CGFloat)viewofheight:(NSDictionary*)dictionary_{
//    UIFont *titlecellFont = [UIFont fontWithName:@"Helvetica" size:15.0];
//    CGSize titleconstraintSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width-33, MAXFLOAT);
//    CGSize titlelabelSize = [[dictionary_ objectForKey:@"title"] sizeWithFont:titlecellFont constrainedToSize:titleconstraintSize lineBreakMode:UILineBreakModeWordWrap];
//    //作者的高度
//    UIFont *authorcellFont = [UIFont fontWithName:@"Helvetica" size:10.0];
//    CGSize authorconstraintSize = CGSizeMake(95.0f, MAXFLOAT);
//    CGSize authorlabelSize = [[dictionary_ objectForKey:@"author"] sizeWithFont:authorcellFont constrainedToSize:authorconstraintSize lineBreakMode:UILineBreakModeWordWrap];
//    if (titlelabelSize.height>38) {
//        titlelabelSize.height=38;
//    }
//   return   titlelabelSize.height+authorlabelSize.height+14;
//    
//}

@end
