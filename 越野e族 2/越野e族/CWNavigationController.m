//
//  CWNavigationController.m
//  CWProject
//
//  Created by Lichaowei on 14-4-4.
//  Copyright (c) 2014年 Chaowei LI. All rights reserved.
//

#import "CWNavigationController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define BACKHEIGHT [UIScreen mainScreen].bounds.size.height
#define BACKWIDTH [UIScreen mainScreen].bounds.size.width

#define BACKSTARTX -100 //背景frame x

@interface CWNavigationController ()
{
    CGPoint startTouch;//手势起始点
    UIImageView *lastScreenShotView;//上一个屏幕截图
    UIView *blackMask;//遮罩层
}
@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsArray;//屏幕截图
@property (nonatomic,assign) BOOL isMoving;

@end

@implementation CWNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.screenShotsArray = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftImage"]];
    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    [self.view addSubview:shadowImageView];
    
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [_panGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:_panGesture];
}

#pragma - mark Need Override Method
// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsArray addObject:[self captureScreen]];
    
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsArray removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}

#pragma mark - CaptureScreen

// get the current view screen shot
- (UIImage *)captureScreen
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * aImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aImage;
}

#pragma mark - Gesture Recognizer

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
//        if (!self.backgroundView)
//        {
            CGRect frame = self.view.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            _backgroundView.backgroundColor = [UIColor whiteColor];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
//        }
        
        self.backgroundView.hidden = NO;//lcw
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsArray lastObject];
        
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self moveOrZoomViewWithX:DEVICE_WIDTH];
                
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self moveOrZoomViewWithX:0];
                
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveOrZoomViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        
        [self moveOrZoomViewWithX:touchPoint.x - startTouch.x];
    }
}

#pragma - mark Move Or Zoom ShotView

// set lastScreenShotView 's position \zoom scale \ alpha when paning

- (void)moveOrZoomViewWithX:(float)x
{
    
    x = x > DEVICE_WIDTH ? DEVICE_WIDTH : x;
    x = x < 0 ? 0 : x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float alpha = 0.4 - (x/800);//透明度
    float scale = (x / 6400) + 0.95;//缩放比例
    
    if (self.animationStyle == AnimationMove) {
        //滑动效果
        CGFloat radio = abs(BACKSTARTX) / BACKWIDTH;//取正整数
        CGFloat move = x * radio;
        
        CGFloat lastScreenShotViewHeight = BACKHEIGHT;
        
        //TODO: FIX self.edgesForExtendedLayout = UIRectEdgeNone  SHOW BUG
        /**
         *  if u use self.edgesForExtendedLayout = UIRectEdgeNone; pls add
         
         if (!iOS7) {
         lastScreenShotViewHeight = lastScreenShotViewHeight - 20;
         }
         *
         */
        [lastScreenShotView setFrame:CGRectMake(BACKSTARTX + move,
                                                0,
                                                BACKWIDTH,
                                                lastScreenShotViewHeight)];
    }else
    {
        //缩放效果
        lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    blackMask.alpha = alpha;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    self.screenShotsArray = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}
@end
