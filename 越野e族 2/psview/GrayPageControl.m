//
//  GrayPageControl.m
//  FbLife
//
//  Created by 史忠坤 on 13-5-3.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl
{
    float _kSpacing;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _kSpacing = 5.0f;
        // Initialization code
        activeImage = [UIImage imageNamed:@"20130502_selected.png"] ;
        inactiveImage = [UIImage imageNamed:@"20130502_notselect.png"] ;
    }
    return self;
}
-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        if ([[self.subviews objectAtIndex:i] isKindOfClass:[UIImageView class]])
        {
            UIImageView* dot = [self.subviews objectAtIndex:i];
            if (i == self.currentPage) dot.image = activeImage;
            else dot.image = inactiveImage;
        }
    }
}
-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    
    if (!MY_MACRO_NAME)
    {
        [self updateDots];
    }else
    {
        for (UIView *su in self.subviews)
        {
            [su removeFromSuperview];
        }
        self.contentMode=UIViewContentModeRedraw;
        
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (MY_MACRO_NAME)
    {
        int i;
        CGRect iRect;
        
        UIImage *image;
        iRect = self.bounds;
        
        if ( self.opaque )
        {
            [self.backgroundColor set];
            UIRectFill( iRect );
        }
        
        if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
        
        rect.size.height = activeImage.size.height;
        rect.size.width = self.numberOfPages * activeImage.size.width + (self.numberOfPages - 1 ) * _kSpacing;
        rect.origin.x = floorf((iRect.size.width - rect.size.width) / 2.0 );
        rect.origin.y = floorf((iRect.size.height - rect.size.height) / 2.0 );
        rect.size.width = activeImage.size.width;
        
        for ( i = 0; i < self.numberOfPages; ++i )
        {
            image = i == self.currentPage?activeImage:inactiveImage;
            
            [image drawInRect: rect];
            
            rect.origin.x += activeImage.size.width + _kSpacing;
        }
    }
}



@end
