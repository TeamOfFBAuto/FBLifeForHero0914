//
//  QBShowImagesScrollView.m
//  FBCircle
//
//  Created by soulnear on 14-5-13.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "QBShowImagesScrollView.h"



#define kMaxZoom 3.0



@implementation QBShowImagesScrollView
@synthesize locationImageView = _locationImageView;
@synthesize asyImageView = _asyImageView;
@synthesize aDelegate = _aDelegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(QBShowImagesScrollView *)initWithFrame:(CGRect)frame WithLocation:(UIImage *)theImage
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.delegate = self;
        self.contentMode = UIViewContentModeCenter;
        self.maximumZoomScale = 3.0;
        self.minimumZoomScale = 1.0;
        self.decelerationRate = .85;
        self.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.showsVerticalScrollIndicator = NO;
        
        // create outline
        //        [self.layer setBorderWidth:1.0];
        //        [self.layer setBorderColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.25] CGColor]];
        
        
        
        // create the image view
        _locationImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        _locationImageView.image = theImage;
        _locationImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_locationImageView];
        
    }
    
    return self;
}


- (void)setFrame:(CGRect)theFrame
{
	// store position of the image view if we're scaled or panned so we can stay at that point
	CGPoint imagePoint = _locationImageView.frame.origin;
	
	[super setFrame:theFrame];
	
	// update content size
	self.contentSize = CGSizeMake(theFrame.size.width * self.zoomScale, theFrame.size.height * self.zoomScale );
	
	// resize image view and keep it proportional to the current zoom scale
	_locationImageView.frame = CGRectMake( imagePoint.x, imagePoint.y, theFrame.size.width * self.zoomScale, theFrame.size.height * self.zoomScale);
}



-(QBShowImagesScrollView *)initWithFrame:(CGRect)frame WithUrl:(NSString *)theUrl
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.delegate = self;
        self.contentMode = UIViewContentModeCenter;
        self.maximumZoomScale = 3.0;
        self.minimumZoomScale = 1.0;
        self.decelerationRate = .85;
        self.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.showsVerticalScrollIndicator = NO;
        
        
        is_load = NO;
        
        
        _locationImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        _locationImageView.contentMode = UIViewContentModeScaleAspectFit;
        _locationImageView.delegate = self;
        //张少南 默认图
        [_locationImageView loadImageFromURL:theUrl withPlaceholdImage:nil];
        
        [self addSubview:_locationImageView];
        
        
        loading_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,160,100)];
        
        loading_view.center = CGPointMake(160,(iPhone5?568:480)/2-20);
        
        loading_view.userInteractionEnabled = NO;
        
        loading_view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:loading_view];
        
        
        activity_view = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,30,30)];
        
        activity_view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        
        activity_view.center = CGPointMake(80,40);
        
        [loading_view addSubview:activity_view];
        
        [activity_view startAnimating];
        
        
        load_again = [[UILabel alloc] initWithFrame:CGRectMake(0,20,160,30)];
        
        load_again.text = @"点击加载";
        
        load_again.hidden = YES;
        
        load_again.textAlignment = NSTextAlignmentCenter;
        
        load_again.textColor = RGBCOLOR(78,78,78);
        
        load_again.font = [UIFont systemFontOfSize:15];
        
        [loading_view addSubview:load_again];
        
        
        UIImageView * place_imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"atlas_logo"]];
        
        place_imageview.center = CGPointMake(80,80);
        
        [loading_view addSubview:place_imageview];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loaddataAgain:)];
        
        [loading_view addGestureRecognizer:tap];
        
        
        
                
//        if (theUrl.length > 0) {
//            placeHolderButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            
//            placeHolderButton.userInteractionEnabled = NO;
//            
//            placeHolderButton.backgroundColor = RGBCOLOR(229,229,229);
//            
//            placeHolderButton.frame =  [UIScreen mainScreen].bounds;
//            
//            placeHolderButton.center = CGPointMake(160,(iPhone5?568:480)/2);
//            
//            [placeHolderButton setImage:[UIImage imageNamed:@"bigImagesPlaceHolder.png"] forState:UIControlStateNormal];
//            
//            [self addSubview:placeHolderButton];
//        }
        
    }
    
    return self;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
	return _locationImageView;
}

-(void)handleImageLayout:(AsyncImageView *)tag
{
    
}

-(void)seccesDownLoad:(UIImage *)image
{
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!is_load)
    {
        return;
    }
    
	UITouch *touch = [[event allTouches] anyObject];
	
	if (touch.tapCount == 2) {
		[self stopTapTimer];
		
		if( _isZoomed )
		{
			_isZoomed = NO;
			[self setZoomScale:self.minimumZoomScale animated:YES];
		}
		else {
			
			_isZoomed = YES;
			
			// define a rect to zoom to.
			CGPoint touchCenter = [touch locationInView:self];
			CGSize zoomRectSize = CGSizeMake(self.frame.size.width / self.maximumZoomScale, self.frame.size.height / self.maximumZoomScale );
			CGRect zoomRect = CGRectMake( touchCenter.x - zoomRectSize.width * .5, touchCenter.y - zoomRectSize.height * .5, zoomRectSize.width, zoomRectSize.height );
			
			// correct too far left
			if( zoomRect.origin.x < 0 )
				zoomRect = CGRectMake(0, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height );
			
			// correct too far up
			if( zoomRect.origin.y < 0 )
				zoomRect = CGRectMake(zoomRect.origin.x, 0, zoomRect.size.width, zoomRect.size.height );
			
			// correct too far right
			if( zoomRect.origin.x + zoomRect.size.width > self.frame.size.width )
				zoomRect = CGRectMake(self.frame.size.width - zoomRect.size.width, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height );
			
			// correct too far down
			if( zoomRect.origin.y + zoomRect.size.height > self.frame.size.height )
				zoomRect = CGRectMake( zoomRect.origin.x, self.frame.size.height - zoomRect.size.height, zoomRect.size.width, zoomRect.size.height );
			
			// zoom to it.
			[self zoomToRect:zoomRect animated:YES];
		}
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!is_load) {
        return;
    }
    
	if([[event allTouches] count] == 1 ) {
		UITouch *touch = [[event allTouches] anyObject];
		if( touch.tapCount == 1 ) {
			if(_tapTimer ) [self stopTapTimer];
			[self startTapTimer];
		}
	}
}

- (void)startTapTimer
{
	_tapTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:.5] interval:.5 target:self selector:@selector(handleTap) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:_tapTimer forMode:NSDefaultRunLoopMode];
	
}
- (void)stopTapTimer
{
	if([_tapTimer isValid])
		[_tapTimer invalidate];
	
	_tapTimer = nil;
}

- (void)handleTap
{
    
    if (_aDelegate && [_aDelegate respondsToSelector:@selector(singleClicked)]) {
        [_aDelegate singleClicked];
    }
    
	// tell the controller
    //	if([photoDelegate respondsToSelector:@selector(didTapPhotoView:)])
    //		[photoDelegate didTapPhotoView:self];
}



-(void)resetImageView:(UIImage *)theImage;
{
    self.locationImageView.image = theImage;
}


-(void)dealloc
{
    _locationImageView.delegate = nil;
    
    _locationImageView.image = nil;
    
    _locationImageView = nil;
    
}


#pragma mark-AsyncImageDelegte


-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image
{
    if (image)
    {
        placeHolderButton.hidden = YES;
        
        loading_view.hidden = YES;
        
        is_load = YES;
    }
}

#pragma mark - 加载失败

-(void)loadDataFailed
{
    [activity_view stopAnimating];
    
    loading_view.userInteractionEnabled = YES;
    
    load_again.hidden = NO;
    
    
    if (!load_failed_view) {
        
        load_failed_view = [[UIView alloc] initWithFrame:CGRectMake(0,0,175,100)];
        
        load_failed_view.center = CGPointMake(160,(iPhone5?568:480)/2-20);
        
        load_failed_view.hidden = YES;
        
        load_failed_view.backgroundColor = RGBCOLOR(30,30,30);
        
        
        load_failed_view.layer.masksToBounds = NO;
        
        load_failed_view.layer.borderColor = RGBCOLOR(25,25,25).CGColor;
        
        load_failed_view.layer.borderWidth = 0.5;
        
        load_failed_view.layer.cornerRadius = 5;
        
        
        [self addSubview:load_failed_view];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,175,30)];
        
        label.center = CGPointMake(175/2,50);
        
        label.text = @"加载图片失败";
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor whiteColor];
        
        label.backgroundColor = [UIColor clearColor];
        
        [load_failed_view addSubview:label];
        
    }
    
    load_failed_view.hidden = NO;
    
    [self performSelector:@selector(hiddenLoadFailedView) withObject:nil afterDelay:1.0];
    
}

-(void)hiddenLoadFailedView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        load_failed_view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        load_failed_view.hidden = YES;
        
        load_failed_view.alpha = 1;
    }];
}


#pragma mark - 点击重新加载数据


-(void)loaddataAgain:(UITapGestureRecognizer *)sender
{
    [self reLoadPictureData];
}


#pragma mark - 重新加载数据

-(void)reLoadPictureData
{
    placeHolderButton.hidden = NO;
    
    loading_view.hidden = NO;
    
    is_load = NO;
    
    loading_view.userInteractionEnabled = NO;
    
    load_again.hidden = YES;
    
    activity_view.hidden = NO;
    
    [activity_view startAnimating];
    
    if (_aDelegate && [_aDelegate respondsToSelector:@selector(reloadAtlasData)])
    {
        [_aDelegate reloadAtlasData];
    }
}



@end
















