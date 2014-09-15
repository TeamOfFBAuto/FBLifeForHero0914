//
//  newsimage_scro.m
//  FbLife
//
//  Created by 史忠坤 on 13-2-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "newsimage_scro.h"
@implementation newsimage_scro
@synthesize imagev_=_imagev_,image_array=_image_array;
@synthesize iscount;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces=YES;
       self.iscount=1;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
    }
    return self;
}
-(void)setImage_array:(NSArray *)image_array{
    _image_array=image_array;
    for (int i=0; i<image_array.count; i++) {
        
        _imagev_=[[AsyncImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 163)];
        
        [_imagev_ loadImageFromURL:[image_array objectAtIndex:i] withPlaceholdImage:[UIImage imageNamed:@"bigimplace.png"]];
        
        _imagev_.backgroundColor=[UIColor clearColor];
        [self addSubview:_imagev_];
        
    }
    self.contentSize=CGSizeMake(320*[image_array count], 0);
    self.pagingEnabled=YES;
}
-(void)startanimation{
    
    timer=[NSTimer scheduledTimerWithTimeInterval:6
                                           target:self
                                         selector:@selector(dongqilai)
                                         userInfo:nil
                                          repeats:YES];
}

-(void)dongqilai{
    if (iscount<_image_array.count) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.contentOffset=CGPointMake(320*iscount, 0);
        [UIView commitAnimations];

    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.contentOffset=CGPointMake(0, 0);
        [UIView commitAnimations];

    }

}
//-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.x<=0) {
//        scrollView.contentOffset = CGPointMake(320*_image_array.count, 0);
//    }
//    if (scrollView.contentOffset.x>=320*_image_array.count) {
//        scrollView.contentOffset = CGPointMake(320, 0);
//    }
//}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self performSelector:@selector(startanimation) withObject:nil afterDelay:4];
//
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//}
@end
