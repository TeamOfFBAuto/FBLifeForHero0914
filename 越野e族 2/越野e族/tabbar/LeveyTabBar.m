//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBar.h"

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;
@synthesize tixing_imageView = _tixing_imageView;


- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
        
        NSArray *array_title=[NSArray arrayWithObjects:@"资讯",@"论坛",@"自留地",@"车库",@"个人", nil];
        
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
            
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
            [btn setTitle:[array_title objectAtIndex:i] forState:UIControlStateNormal];
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
            
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"ios7_tabbarchose.png"] forState:UIControlStateSelected];
            
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.titleLabel.font = btn.selected?[UIFont boldSystemFontOfSize:11]:[UIFont systemFontOfSize:10];
            
            if (i==2||i==3) {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-18,-26,0)];//上左下右
                
            }else if(i==4){
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-15,-26,0)];//上左下右
                
            }else{
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-16,-26,0)];//上左下右
                
            }
            
            
            [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateSelected];
            
            [btn setTitleColor:[UIColor colorWithRed:49/255.f green:49/255.f blue:49/255.f alpha:1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:49/255.f green:49/255.f blue:49/255.f alpha:1] forState:UIControlStateHighlighted];
            
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0,12,-22)];
            
            if (i==2) {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0,12,-33)];

            }
            if (i==1) {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-18,-26,0)];//上左下右

            }
            
            [btn setShowsTouchWhenHighlighted:false];
            
            //            btn.imageView.frame = CGRectMake(0,0,20,20);
            //
            //            btn.imageView.center = CGPointMake(32,12);
            
            
            _tixing_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(42,10,13/2,13/2)];
            
            _tixing_imageView.image = [UIImage imageNamed:@"ios7_unread13_13.png"];
            
            _tixing_imageView.backgroundColor = [UIColor clearColor];
            
            _tixing_imageView.hidden = YES;
            
            if (i == 4)
            {
                [btn addSubview:_tixing_imageView];
            }
            
            
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
    
    
    
    
    NSLog(@"Select index: %d",btn.tag);
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
    
    // Re-index the buttons
    CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons)
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons)
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [super dealloc];
}

@end
