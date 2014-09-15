//
//  MyTextViewForForward.m
//  越野e族
//
//  Created by soulnear on 14-2-14.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MyTextViewForForward.h"

@implementation MyTextViewForForward
@synthesize delegate1 = _delegate1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [self becomeFirstResponder];
    return YES;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"touchesBegan");
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    NSLog(@"touches moved");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"touches ended");
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_delegate1 && [_delegate1 respondsToSelector:@selector(clickMyTextView)])
    {
        [_delegate1 clickMyTextView];
    }
    
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"touches cancellled");
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
