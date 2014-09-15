//
//  AtlasContentView.m
//  越野e族
//
//  Created by soulnear on 14-7-15.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "AtlasContentView.h"

@implementation AtlasContentView
@synthesize title_label = _title_label;
@synthesize current_page = _current_page;
@synthesize content_textView = _content_textView;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(12,17,260,18)];
        
        _title_label.backgroundColor = [UIColor clearColor];
        
        _title_label.contentMode = UIViewContentModeTop;
        
        _title_label.font = [UIFont systemFontOfSize:16];
        
        _title_label.textAlignment = NSTextAlignmentLeft;
        
        _title_label.textColor = [UIColor whiteColor];
        
        [self addSubview:_title_label];
        
     
        
        _current_page = [[UILabel alloc] initWithFrame:CGRectMake(280,0,40,42)];
        
        _current_page.backgroundColor = [UIColor clearColor];
        
        _current_page.textAlignment = NSTextAlignmentLeft;
        
        _current_page.textColor = [UIColor whiteColor];
        
        [self addSubview:_current_page];
        
        
        
        _content_textView = [[UITextView alloc] initWithFrame:CGRectMake(8,45,306,77)];

        _content_textView.backgroundColor = [UIColor clearColor];
        
        _content_textView.textAlignment = NSTextAlignmentLeft;
        
        _content_textView.font = [UIFont systemFontOfSize:12];
        
        _content_textView.delegate = self;
        
        _content_textView.contentInset = UIEdgeInsetsMake(-5,0,0,0);
        
        _content_textView.textColor = RGBCOLOR(181,181,181);
        
        _content_textView.editable = YES;
        
        [self addSubview:_content_textView];
        
        
    }
    return self;
}


-(void)reloadInformationWith:(AtlasModel *)model WithCurrentPage:(int)thePage WithTotalPage:(int)totalPage
{
    _title_label.text = model.atlas_name;
    
    _content_textView.text = model.atlas_content;

    NSString * page = [NSString stringWithFormat:@"%d",thePage];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d/%d",thePage,totalPage]];
    
//        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];

    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,page.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(page.length,str.length-page.length)];
        
    _current_page.attributedText = str;
}



#pragma mark - UITextViewDelegate 禁止复制 粘贴 放大功能

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
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
