//
//  NewMessageViewController.m
//  FbLife
//
//  Created by soulnear on 13-8-5.
//  Copyright (c) 2013年 szk. All rights reserved.
//



#define HEIGHT 40

#import "NewMessageViewController.h"
#import "NSString+JSMessagesView.h"


#define INPUT_HEIGHT 40.0f

@interface NewMessageViewController ()
{
    int temp_count;
    UITextView * temp_textView;
}

@end

@implementation NewMessageViewController
@synthesize inputToolBarView = _inputToolBarView;
@synthesize previousTextViewContentHeight = _previousTextViewContentHeight;
@synthesize name_textField = _name_textField;

@synthesize toUid = _toUid;

@synthesize delegate = _delegate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)backto
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 88)
    {
        [self.name_textField becomeFirstResponder];
    }else
    {
        [self.inputToolBarView.textView becomeFirstResponder];
    }
}

-(void)sendPressed:(UIButton *)button
{
    
    NSString * name_text = [self.name_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    if (name_text.length == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入用户名" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        alert.tag = 88;
        
        [alert show];
        
        return;
    }
    
    NSString * content_text = [self.inputToolBarView.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    if (content_text.length == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入私信内容" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        alert.tag = 89;
        
        [alert show];
        
        return;
    }
    
    
    
    
    NSString * fullUrl = [NSString stringWithFormat:@"http://msg.fblife.com/api.php?c=send&toname=%@&&content=%@&authcode=%@",[self.name_textField.text stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[self.inputToolBarView.textView.text stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    
    
    NSLog(@"上传的url -- %s %@",__FUNCTION__,fullUrl);
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    request.delegate = self;
    
    __block ASIHTTPRequest * request_ = request;
    
    [request_ setCompletionBlock:^{
        
        @try {
            NSDictionary * dictionary = [request.responseData objectFromJSONData];
            
            
            
            NSString * errcode = [dictionary objectForKey:@"errcode"];
            
            NSString * bbsinfo = [dictionary objectForKey:@"bbsinfo"];
            
            NSLog(@"dic ---  %@   errcode --- %@  bbsinfo --  %@",dictionary,errcode,bbsinfo);
            
            
            if ([errcode intValue] == 0)
            {
                if (_delegate && [_delegate respondsToSelector:@selector(sucessToSendWithName:Uid:)])
                {
                    [_delegate sucessToSendWithName:self.name_textField.text Uid:bbsinfo];
                }
                
                
                [self dismissModalViewControllerAnimated:NO];
                
            }else
            {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有该用户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
        
        
        //        NSString *string_test=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"bbsinfo"]];
        //
        //        if ([string_test isEqualToString:@"没有该用户"])
        //        {
        //            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有该用户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alertview show];
        //        }else
        //        {
        //            [self dismissModalViewControllerAnimated:NO];
        //        }
        
        
        
    }];
    
    [request_ setFailedBlock:^{
        
    }];
    
    
    [request startAsynchronous];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"NewMessageViewController"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"NewMessageViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    temp_count = 1;
    
    float ios7_height = IOS_VERSION>=7.0?20:0;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view_daohang=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,44+ios7_height)];
    
    view_daohang.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING]];
    
    [self.view addSubview:view_daohang];
    
    UILabel *labelbiaoti=[[UILabel alloc]initWithFrame:CGRectMake(140,ios7_height,100,44)];
    labelbiaoti.text=@"写私信";
    labelbiaoti.backgroundColor=[UIColor clearColor];
    labelbiaoti.textColor=[UIColor blackColor];
    labelbiaoti.font = TITLEFONT;
    [view_daohang addSubview:labelbiaoti];
    
    
    UIBarButtonItem * space_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_button.width = MY_MACRO_NAME?0:5;
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,ios7_height,30,44)];
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    [button_back setImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];
    
    //    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    //    self.navigationItem.leftBarButtonItems=@[space_button,back_item];
    
    [view_daohang addSubview:button_back];
    
    
    UIView * backGround_view = [[UIView alloc] initWithFrame:CGRectMake(0,44+ios7_height,320,HEIGHT)];
    
    backGround_view.backgroundColor = RGBCOLOR(248,248,248);
    
    [self.view addSubview:backGround_view];
    
    
    UILabel * name_label = [[UILabel alloc] initWithFrame:CGRectMake(10,0,60,HEIGHT)];
    
    name_label.backgroundColor = [UIColor clearColor];
    
    name_label.text = @"收件人:";
    
    name_label.textColor = RGBCOLOR(108,108,108);
    
    name_label.textAlignment = NSTextAlignmentLeft;
    
    [backGround_view addSubview:name_label];
    
    
    
    self.name_textField = [[UITextField alloc] initWithFrame:CGRectMake(75,0,210,HEIGHT)];
    
    [self.name_textField becomeFirstResponder];
    
    self.name_textField.keyboardType = UIKeyboardTypeTwitter;
    
    self.name_textField.delegate = self;
    
    self.name_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.name_textField.backgroundColor = [UIColor clearColor];
    
    [backGround_view addSubview:self.name_textField];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    button.frame = CGRectMake(285,5,30,30);
    
    
    [button addTarget:self action:@selector(friendList:) forControlEvents:UIControlEventTouchUpInside];
    
    [backGround_view addSubview:button];
    
    
    
    
    
    // TODO: refactor
    
    CGSize size = self.view.frame.size;
    
    CGRect inputFrame = CGRectMake(0.0f, size.height - INPUT_HEIGHT, size.width, INPUT_HEIGHT);
    
    self.inputToolBarView = [[JSMessageInputView alloc] initWithFrame:inputFrame delegate:self];
    
    self.inputToolBarView.textView.keyboardDelegate = self;
    
    UIButton *sendButton = [self sendButton];
    sendButton.frame = CGRectMake(self.inputToolBarView.frame.size.width - 55.0f,6.0f,113/2, 30.0f);
    [sendButton addTarget:self
                   action:@selector(sendPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.inputToolBarView setSendButton:sendButton];
    
    [self.view addSubview:self.inputToolBarView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillShowKeyboard:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillHideKeyboard:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (UIButton *)sendButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor clearColor];
    
    [button setTitle:@"发送" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return button;
    
    return [UIButton defaultSendButton];
}



#pragma mark - Dismissive text view delegate
- (void)keyboardDidScrollToPoint:(CGPoint)pt
{
    CGRect inputViewFrame = self.inputToolBarView.frame;
    CGPoint keyboardOrigin = [self.view convertPoint:pt fromView:nil];
    inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
    self.inputToolBarView.frame = inputViewFrame;
}

- (void)keyboardWillBeDismissed
{
    CGRect inputViewFrame = self.inputToolBarView.frame;
    inputViewFrame.origin.y = self.view.bounds.size.height - inputViewFrame.size.height;
    self.inputToolBarView.frame = inputViewFrame;
}

- (void)keyboardWillSnapBackToPoint:(CGPoint)pt
{
    CGRect inputViewFrame = self.inputToolBarView.frame;
    CGPoint keyboardOrigin = [self.view convertPoint:pt fromView:nil];
    inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
    self.inputToolBarView.frame = inputViewFrame;
}



#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}


- (void)keyboardWillShowHide:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
                         
                         CGRect inputViewFrame = self.inputToolBarView.frame;
                         CGFloat inputViewFrameY = keyboardY - inputViewFrame.size.height;
                         
                         // for ipad modal form presentations
                         CGFloat messageViewFrameBottom = self.view.frame.size.height - INPUT_HEIGHT;
                         if(inputViewFrameY > messageViewFrameBottom)
                             inputViewFrameY = messageViewFrameBottom;
                         
                         self.inputToolBarView.frame = CGRectMake(inputViewFrame.origin.x,
                                                                  inputViewFrameY,
                                                                  inputViewFrame.size.width,
                                                                  inputViewFrame.size.height);
                         
                     }
                     completion:^(BOOL finished) {
                     }];
}


#pragma UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}



- (void)textViewDidChange:(UITextView *)textView
{
    if (!temp_textView)
    {
        temp_textView = [[UITextView alloc] initWithFrame:CGRectMake(0,0,textView.frame.size.width,textView.frame.size.height)];
        
        temp_textView.font = [UIFont systemFontOfSize:15];
    }
    
    temp_textView.text = textView.text;
    
    CGFloat height = [temp_textView sizeThatFits:CGSizeMake(textView.frame.size.width,CGFLOAT_MAX)].height;
    
    CGFloat textViewContentHeight = textView.contentSize.height;
    
    self.previousTextViewContentHeight = height - textViewContentHeight;
    
    int count = 1;
    
    if (height > 34)
    {
        count = ((height-34)/18)+1;
    }
    
    float theheight = (count-temp_count)*18;
    
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         
                         if (count > 6)
                         {
                             [self.inputToolBarView adjustTextViewHeightBy:count WihtHeight:0];
                             
                             return ;
                         }else
                         {
                             if (count == 6 && theheight < 0)
                             {
                                 return;
                             }
                             
                             CGRect inputViewFrame = self.inputToolBarView.frame;
                             
                             self.inputToolBarView.frame = CGRectMake(0.0f,
                                                                      inputViewFrame.origin.y - theheight,
                                                                      inputViewFrame.size.width,
                                                                      inputViewFrame.size.height + theheight);
                             
                             [self.inputToolBarView adjustTextViewHeightBy:count WihtHeight:theheight];
                         }
                     }
                     completion:^(BOOL finished) {
                         
                         
                     }];
    
    
    
    temp_count = count;
    
}


-(void)friendList:(UIButton *)button
{
    FriendListViewController * list = [[FriendListViewController alloc] init];
    
    list.delegate = self;
    
    list.title_name_string = @"联系人";
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:list];
    
    [self presentViewController:nav animated:YES completion:NULL];
}


-(void)returnUserName:(NSString *)username Uid:(NSString *)uid
{
    self.name_textField.text = username;
    self.toUid = uid;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



+ (CGFloat)textViewLineHeight
{
    return 30.0f; // for fontSize 15.0f
}

+ (CGFloat)maxLines
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 4.0f : 8.0f;
}

+ (CGFloat)maxHeight
{
    return ([JSMessageInputView maxLines] + 1.0f) * [JSMessageInputView textViewLineHeight];
}

@end




























