//
//  SGFocusImageFrame.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "NewHuandengView.h"
#import "SGFocusImageItem.h"
#import <objc/runtime.h>
#define ITEM_WIDTH 320.0

@interface NewHuandengView () {
    UIScrollView *_scrollView;
    //    GPSimplePageView *_pageControl;
    SMPageControl *_pagecontrol;
    UILabel *greenlabel;
}

- (void)setupViews;
- (void)switchFocusImageItems;
@end

static NSString *SG_FOCUS_ITEM_ASS_KEY = @"loopScrollview";

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 6.0; //switch interval time

@implementation NewHuandengView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<NewHuandengViewDelegate>)delegate focusImageItems:(SGFocusImageItem *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imageItems = [NSMutableArray array];
        SGFocusImageItem *eachItem;
        va_list argumentList;
        if (firstItem)
        {
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);
            while((eachItem = va_arg(argumentList, SGFocusImageItem *)))
            {
                [imageItems addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = YES;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<NewHuandengViewDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = YES;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame delegate:(id<NewHuandengViewDelegate>)delegate imageItems:(NSArray *)items
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES];
}

- (void)dealloc
{
    objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    _scrollView.delegate = nil;
    [_scrollView release];
    [_pagecontrol release];
    [greenlabel release];
    [super dealloc];
}





#pragma mark - private methods
- (void)setupViews
{
    greenlabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 164+13, 320, 18)];
    greenlabel.font=[UIFont boldSystemFontOfSize:16];
    greenlabel.textAlignment=NSTextAlignmentLeft;
    greenlabel.textColor=RGBCOLOR(42, 42, 42);
    greenlabel.backgroundColor=[UIColor clearColor];
    
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 191)];
    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.scrollsToTop = NO;
    //pagecontrol
    _pagecontrol = [[SMPageControl alloc]initWithFrame:CGRectMake(-4, 1,  320-255, 25)];
    
    _pagecontrol.backgroundColor = [UIColor clearColor];
    _pagecontrol.numberOfPages = 5;
    _pagecontrol.indicatorMargin=8.0f;
    [_pagecontrol setPageIndicatorImage:[UIImage imageNamed:@"roundgray.png"]];
    [_pagecontrol setCurrentPageIndicatorImage:[UIImage imageNamed:@"roundblue.png"]];
    _pagecontrol.center=CGPointMake(280, 135+13);
    
    _pagecontrol.currentPage = 0;
    
    //黑色小条
    
    UIView *_duantiaoview=[[UIView alloc]initWithFrame:CGRectMake(0,MY_MACRO_NAME? self.frame.size.height-158/2+5:self.frame.size.height-158/2+5, 320, 150/2)];
    _duantiaoview.userInteractionEnabled = NO;
    _duantiaoview.autoresizesSubviews=YES;
    
    _duantiaoview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios7_halfblack640_158.png"]];
    
    
    
    [self addSubview:_scrollView];
    //[self addSubview:_duantiaoview];
    [self addSubview:_pagecontrol];
    [self addSubview:greenlabel];
    //三角
    _sanJiaoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sanjiao21_8.png"]];
    _sanJiaoImageView.center=CGPointMake(255, 148+13);
    [self addSubview:_sanJiaoImageView];
    
    //line
    
    UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(12, 191-0.5+13, 320-24, 0.5)];
    viewLine.backgroundColor=RGBCOLOR(76, 104, 138);
    [self addSubview:viewLine];
    
    /*
     _scrollView.layer.cornerRadius = 10;
     _scrollView.layer.borderWidth = 1 ;
     _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
     */
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    
    
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * imageItems.count, _scrollView.frame.size.height);
    
    for (int i = 0; i < imageItems.count; i++) {
        
        //        SGFocusImageItem *item = [imageItems objectAtIndex:i];
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(i * 320, 0, 320, 163) ];
        //加载图片
         //imageView.backgroundColor = i%2?[UIColor greenColor]:[UIColor blueColor];
        SGFocusImageItem *item = [imageItems objectAtIndex:i];
        
        [ imageView loadImageFromURL:item.image withPlaceholdImage:[UIImage imageNamed:@"bigimplace.png"]];
        [_scrollView addSubview:imageView];
        [imageView release];
        
    }
    [tapGestureRecognize release];
    if ([imageItems count]>1)
    {
        [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH, 0) animated:NO] ;
        if (_isAutoPlay)
        {
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        }
        
    }
    
    
    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)switchFocusImageItems
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
    [self moveToTargetPosition:targetX];
    
    if ([imageItems count]>1 && _isAutoPlay)
    {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    }
    
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
        SGFocusImageItem *item = [imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(testfoucusImageFrame:didSelectItem:)]) {
            [self.delegate testfoucusImageFrame:self didSelectItem:item];
        }
    }
    
    
}






- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    //    NSLog(@"moveToTargetPosition : %f" , targetX);
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count]>=3)
    {
        if (targetX >= ITEM_WIDTH * ([imageItems count] -1)) {
            targetX = ITEM_WIDTH;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = ITEM_WIDTH *([imageItems count]-2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    int page = (_scrollView.contentOffset.x+ITEM_WIDTH/2.0) / ITEM_WIDTH;
    //    NSLog(@"%f %d",_scrollView.contentOffset.x,page);
    if ([imageItems count] > 1)
    {
        
        
        SGFocusImageItem *item = [imageItems objectAtIndex:page];
        
        greenlabel.text=item.title;
        page --;
        if (page >= _pagecontrol.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = _pagecontrol.numberOfPages -1;
        }
    }
    if (page!= _pagecontrol.currentPage)
    {
        if ([self.delegate respondsToSelector:@selector(testfoucusImageFrame:currentItem:)])
        {
            [self.delegate testfoucusImageFrame:self currentItem:page];
       }
    }
    _sanJiaoImageView.center=CGPointMake(237+14*_scrollView.contentOffset.x/320, 148+13);


    _pagecontrol.currentPage = page;
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        [self moveToTargetPosition:targetX];
        
        
        
        
          }
}


- (void)scrollToIndex:(int)aIndex
{
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count]>1)
    {
        if (aIndex >= ([imageItems count]-2))
        {
            aIndex = [imageItems count]-3;
        }
        [self moveToTargetPosition:ITEM_WIDTH*(aIndex+1)];
    }else
    {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
    
}


-(void)setimageItems:(NSArray *)items{




}



#pragma mark--如何让这个uiscrowview动起来

//-(void)startanimation{
//    NSTimer *timer;
//    timer=[NSTimer scheduledTimerWithTimeInterval:6
//                                           target:self
//                                         selector:@selector(dongqilai)
//                                         userInfo:nil
//                                          repeats:YES];
//}
//
//-(void)dongqilai{
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.5];
//        self.contentOffset=CGPointMake(320*iscount, 0);
//        [UIView commitAnimations];
//
//
//}
//
//







@end