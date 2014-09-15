//
//  UIDemoBaseController.m
//  MSC20Demo
//
//  Created by msp on 12-9-12.
//  Copyright 2012 IFLYTEK. All rights reserved.
//

#import "UIDemoBaseController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIDemoBaseController

- (id)init
{
	if (self = [super initWithStyle:UITableViewStyleGrouped])
	{
		self.tableView.allowsSelection = NO;
	}
	return self;
}

- (void)dealloc 
{
    [super dealloc];
}
//  this function will be called when the keyBoard will display
//  当键盘消失的时候会调用这个函数
- (void)onButtonKeyBoard
{
	[_textView resignFirstResponder];

	self.navigationItem.rightBarButtonItem = NULL;
}

//  this function will be called when the keyBoard will show
//  当键盘显示的时候会调用这个函数
- (void)keyboardWillShow
{
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithTitle:@"Done" 
											   style:UIBarButtonItemStyleDone 
											   target:self 
											   action:@selector(onButtonKeyBoard)]
											  autorelease];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.tableView.allowsSelection = NO;
	self.tableView.scrollEnabled = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// this functin will be called when the textView be edited
// 当textview被编辑的时候，会调用这个函数
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[self keyboardWillShow];
}
// 
- (UITextView *)addTextViewWithFrame:(CGRect)frame theText:(NSString *)text 
{
	UITextView *textView = [[[UITextView alloc] initWithFrame:frame] autorelease];

	// set the textview property
    // 设置textview的属性    
	textView.font = [UIFont systemFontOfSize:18];
	textView.text = text;
	textView.backgroundColor = [UIColor whiteColor];
	textView.layer.cornerRadius = 8.0f;
    textView.editable = NO;
	textView.delegate = self;

	return textView;
}

- (UIButton *)addButton:(CGRect)frame theTitle:(NSString *)title 
		 theNomarlImage:(UIImage *)nomarlImage 
		thePressedImage:(UIImage *)pressedImgae
		theDisableImage:(UIImage *)disableImage
				 target:(SEL)action
{		
	UIButton *button = [[[UIButton alloc] initWithFrame:frame] autorelease];

    // set the button property
    // 设置button的属性   
	[button setTitle:title forState:UIControlStateNormal];
	[button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:nomarlImage forState:UIControlStateNormal];
	[button setBackgroundImage:pressedImgae forState:UIControlStateHighlighted];
	[button setBackgroundImage:disableImage forState:UIControlStateDisabled];

	//button.backgroundColor = [UIColor redColor];
	button.exclusiveTouch = YES;
	return button;
}

/*
#ifdef __IPHONE_3_0
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
#else
	- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {    
		UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
#endif
		
		if (interfaceOrientation == UIInterfaceOrientationPortrait 
			|| interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		{// 竖屏幕设置视图坐标

		}
		else 
		{// 横屏幕设置视图坐标

		}
	}
	
	// Override to allow orientations other than the default portrait orientation.
	- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
	{	
		// Return YES for supported orientations
		return YES;
		
	}*/
	
@end
