//
//  GScrollView.m
//  MapHearo
//
//  Created by gaomeng on 14-9-17.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import "GScrollView.h"

#import "GmapViewController.h"



///最大缩放
#define kMaxZoom 10.0

///左上角经度(x)
#define kLeftUpLong 105.377410

///左上角纬度(y)
#define kLeftUpLat 38.812030

///X轴总长
#define kXLong 0.011630

///Y轴总长 因为是算比例 负负得正
#define kYLong  -0.010270

@implementation GScrollView



-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    
    _locationImageView.image = nil;
    
    _locationImageView = nil;
    
}






- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(GScrollView *)initWithFrame:(CGRect)frame WithLocation:(UIImage *)theImage
{
    NSLog(@"%s",__FUNCTION__);
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.delegate = self;
        self.contentMode = UIViewContentModeCenter;
        self.maximumZoomScale = kMaxZoom;//最大放大比例
        self.towPointMaxZoom = 3.0;//双击时放大的比例
        self.minimumZoomScale = 1.0;//最小缩小比例
        self.decelerationRate = .85;
        self.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.showsVerticalScrollIndicator = NO;
        
        
        NSLog(@"图片的  宽 %f  高 %f",theImage.size.width,theImage.size.height);
        
        //创建本地图片
        _locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        _locationImageView.image = theImage;
        _locationImageView.backgroundColor = [UIColor whiteColor];
        _locationImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_locationImageView];
        
        
        
        
        
        
        //计算量代码优化=========
        
        //左上
//        NSDictionary *dicLeftUp = BMKConvertBaiduCoorFrom(CLLocationCoordinate2DMake(38.80504444444445, 105.36678055555555), BMK_COORDTYPE_GPS);
//        _ttLeftUp = BMKCoorDictionaryDecode(dicLeftUp);
//        
//        NSLog(@" _ttleftup long %f    lat %f",_ttLeftUp.longitude,_ttLeftUp.latitude);
        
//        //左下
//        NSDictionary *dicLeftDown = BMKConvertBaiduCoorFrom(CLLocationCoordinate2DMake(38.79479722222222, 105.36744722222222), BMK_COORDTYPE_GPS);
//        _ttLeftDown = BMKCoorDictionaryDecode(dicLeftDown);
//        
//        //右上
//        NSDictionary *dicRightUp = BMKConvertBaiduCoorFrom(CLLocationCoordinate2DMake(38.805502777777775, 105.37833055555555), BMK_COORDTYPE_GPS);
//        _ttRightUp = BMKCoorDictionaryDecode(dicRightUp);
     
//        NSLog(@"左上(x,y) long = %f  lat = %f",_ttLeftUp.longitude,_ttLeftUp.latitude);
//        
//        NSLog(@"右上(x,y) long = %f  lat = %f",_ttRightUp.longitude,_ttRightUp.latitude);
//        
//        NSLog(@"左下(x,y) long = %f  lat = %f",_ttLeftDown.longitude,_ttLeftDown.latitude);
        
//        _xlong = (_ttRightUp.longitude - _ttLeftUp.longitude);
//        _ylong = (_ttLeftDown.latitude - _ttLeftUp.latitude);
//        NSLog(@"x总长 %f",_xlong);
//        NSLog(@"y总长 %f",_ylong);
        
        
        _ttLeftUp = CLLocationCoordinate2DMake(kLeftUpLat, kLeftUpLong);
        
       
        
        
        
        
    }
    
    return self;
}


-(void)dingweiViewWithX:(double)theX Y:(double)theY{
    
    
    //比例
    double framex = (theX - _ttLeftUp.longitude) /kXLong;
    double framey = (theY - _ttLeftUp.latitude) / kYLong;
    
    NSLog(@"比例 : %f %f",framex,framey);
    
    if (framex >0.0 && framex <1.0 && framey >0.0 && framey < 1.0) {
        self.mapVCDelegate.tishilabel.hidden = YES;
    }
    
    //用户位置
    if (!_blueImv) {
        _blueImv = [[UIImageView alloc]init];
        [_blueImv setImage:[UIImage imageNamed:@"center_point.png"]];
        _blueImv.frame = CGRectMake(0, 0, 24, 24);
        [_locationImageView addSubview:_blueImv];
    }
    
    //定位图标比例
    float aaa = _locationImageView.frame.size.width / 320.0;
    NSLog(@"%f",aaa);
    
    _blueImv.frame = CGRectMake(0, 0, 24/aaa, 24/aaa);
    
    
    //定位图标中心点位置
    _blueImv.center = CGPointMake(framex*320, framey *(iPhone5?568-64:480-64));
    
    
    
    
    
}



- (void)setFrame:(CGRect)theFrame
{
    NSLog(@"%s",__FUNCTION__);
    
	// store position of the image view if we're scaled or panned so we can stay at that point
	CGPoint imagePoint = _locationImageView.frame.origin;
	
	[super setFrame:theFrame];
	
	// update content size
	self.contentSize = CGSizeMake(theFrame.size.width * self.zoomScale, theFrame.size.height * self.zoomScale );
	
	// resize image view and keep it proportional to the current zoom scale
	_locationImageView.frame = CGRectMake( imagePoint.x, imagePoint.y, theFrame.size.width * self.zoomScale, theFrame.size.height * self.zoomScale);
    
}






- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    NSLog(@"%s",__FUNCTION__);
    
	return _locationImageView;
}



-(void)seccesDownLoad:(UIImage *)image
{
    NSLog(@"%s",__FUNCTION__);
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%s",__FUNCTION__);
    
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
			CGSize zoomRectSize = CGSizeMake(self.frame.size.width / self.towPointMaxZoom, self.frame.size.height / self.towPointMaxZoom );
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
    
    NSLog(@"%s",__FUNCTION__);
    
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
    NSLog(@"%s",__FUNCTION__);
	_tapTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:.5] interval:.5 target:self selector:@selector(handleTap) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:_tapTimer forMode:NSDefaultRunLoopMode];
	
}
- (void)stopTapTimer
{
    NSLog(@"%s",__FUNCTION__);
    
	if([_tapTimer isValid])
		[_tapTimer invalidate];
	
	_tapTimer = nil;
}


- (void)handleTap
{
    NSLog(@"%s",__FUNCTION__);
    
    if (_aDelegate && [_aDelegate respondsToSelector:@selector(singleClicked)]) {
        [_aDelegate singleClicked];
    }
}



-(void)singleClicked{
    NSLog(@"%s",__FUNCTION__);
    
}


@end
