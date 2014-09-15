//
//  HintView.m
//  mytubo_iphone
//
//  Created by user on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "HintView.h"

@interface HintView()
-(void)destroy;
@end


@implementation HintView

+(id)HintViewWithText:(NSString *)text
{
	HintView *hint = [[HintView alloc] init];
    
	hint.text = text;
    hint.font = [UIFont fontWithName:@"Helvetica" size:15];
	hint.textAlignment = UITextAlignmentCenter;
	hint.backgroundColor = [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.7f];
    

	hint.textColor = [UIColor whiteColor];
	hint.numberOfLines = 2;
    
	CGSize  textSize = [text sizeWithFont:hint.font
							  constrainedToSize:CGSizeMake(200, 1000)
								  lineBreakMode:UILineBreakModeWordWrap];
	textSize.width = textSize.width+30;
	textSize.height = textSize.height+30;

	hint.frame = CGRectMake((320-textSize.width)/2, (480-textSize.height)/2, textSize.width, textSize.height);	
	
	return hint;
}


-(void)show
{
    CALayer *layer = self.layer;
    layer.cornerRadius = 8;
    //layer.borderColor = [UIColor lightGrayColor].CGColor;
    //layer.borderWidth = 1.0;
    
	AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
	[appDelegate.window addSubview:self];
	[appDelegate.window bringSubviewToFront:self];
	
	self.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView animateWithDuration:0.15 
					 animations:^(void) {
                         self.transform = CGAffineTransformIdentity;
					 }
	 ];
}


-(void)showAutoDestory
{
    [self show];
	[self performSelector:@selector(destroy) withObject:nil afterDelay:1];
}



//- (void)drawRect:(CGRect)rect
//{
//    float radius =  5;
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();    
//    
//    CGContextBeginPath(context);    
//    
//    CGFloat minX = CGRectGetMinX(rect);
//    CGFloat midX = CGRectGetMidX(rect);
//    CGFloat maxX = CGRectGetMaxX(rect);
//    CGFloat minY = CGRectGetMinY(rect) + 5;
//    CGFloat midY = CGRectGetMidY(rect);
//    CGFloat maxY = CGRectGetMaxY(rect) - 5;
//    CGContextMoveToPoint(context, minX, midY);
//    CGContextAddArcToPoint(context, minX, minY, midX, minY, radius);
//    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, radius);
//    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
//    CGContextAddArcToPoint(context, minX, maxY, minX, midY, radius);
//     
//    
//    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
//    CGContextFillPath(context);
//    [self.text drawInRect: rect withFont: self.font lineBreakMode: UILineBreakModeClip 
//        alignment: UITextAlignmentCenter];
//    
//    //////////////////
//    
////    CGContextBeginPath(context);
////    CGContextSetLineWidth(context, 1);
////    
////    for (int i = 1; i < itemCount; i++) {
////        CGContextMoveToPoint(context, minX + i * (LABEL_PADDING + LABEL_WIDTH) + LABEL_PADDING * 0.5, minY + 5);
////        CGContextAddLineToPoint(context, minX + i * (LABEL_PADDING + LABEL_WIDTH) + LABEL_PADDING * 0.5, maxY - 5);
////    }
////    CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
////    CGContextStrokePath(context);
//    
//}

-(void)destroy
{
//    [UIView animateWithDuration:0.3 
//						  delay:0
//						options:UIViewAnimationOptionCurveEaseInOut
//					 animations:^(void) {
//						self.transform = CGAffineTransformMakeScale(1,0.1);
//					 }
//					 completion:^(BOOL finshed) {
//		
//					 }
//	 ];
	[self removeFromSuperview];
}

@end
