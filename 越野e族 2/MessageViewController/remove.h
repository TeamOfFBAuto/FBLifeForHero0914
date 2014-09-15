//
//  MyChatViewController.m
//  FbLife
//
//  Created by soulnear on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//


#define INPUT_HEIGHT 40.0f


#import "MyChatViewController.h"
#import "ChatInfo.h"
#import "NSString+JSMessagesView.h"
#import "UIView+AnimationOptionsForCurve.h"
#import "UIColor+JSMessagesView.h"
#import "MyChatViewCell.h"

@interface MyChatViewController ()

@end

@implementation MyChatViewController
@synthesize tableView = _tableView;
@synthesize inputToolBarView = _inputToolBarView;
@synthesize previousTextViewContentHeight = _previousTextViewContentHeight;

@synthesize messageArray = _messageArray;
@synthesize timesArray = _timesArray;
@synthesize info = _info;
@synthesize data_array = _data_array;
@synthesize requset_data = _requset_data;
@synthesize request_send = _request_send;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)initHttpRequestWithMaxId:(NSString *)maxId
{
    
    if (_requset_data)
    {
        [_requset_data cancel];
        _requset_data.delegate = nil;
        _requset_data = nil;
    }
    
    NSString * theToUid;
    
    if ([self.info.from_uid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]])
    {
        theToUid = self.info.to_uid;
    }else
    {
        theToUid = self.info.from_uid;
    }
    
    
    
    NSString * fullUrl = [NSString stringWithFormat:@"http://msg.fblife.com/api.php?c=talk&touid=%@&maxid=%@&page=%d&authcode=%@",theToUid,maxId,1,[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    
    NSLog(@"对话窗口如来---- %@",fullUrl);
    
    
    _requset_data = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    _requset_data.delegate = self;
    
    __block ASIHTTPRequest * request__ = _requset_data;
    
    if (maxId.length == 0)
    {
        [self.data_array removeAllObjects];
        
        [self.messageArray removeAllObjects];
        
        [self.timesArray removeAllObjects];
    }
    
    
    [request__ setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [_requset_data.responseData objectFromJSONData];
            NSArray * array = [dic objectForKey:@"info"];
            
            if (array.count == 0)
            {
                return ;
            }
            
            
            array = [[array reverseObjectEnumerator] allObjects];
            
            for (NSDictionary * dic1 in array)
            {
                ChatInfo * info = [[ChatInfo alloc] initWithDic:dic1];
                
                
                [zsnApi calculateheight:[zsnApi stringExchange:info.msg_message]];
                
                [self.data_array addObject:info];
                
                [self.messageArray addObject:info.msg_message];
                
                [self.timesArray addObject:[zsnApi timechange1:info.date_now]];
            }
            
            [self finishSend];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    [request__ setFailedBlock:^{
        
    }];
    
    [_requset_data startAsynchronous];
}


-(void)writeMessageRequest:(ChatInfo *)theInfo
{
    
    if (_request_send)
    {
        [_request_send cancel];
        _request_send.delegate = nil;
        _request_send = nil;
    }
    
    
    NSString * theToUserName;
    
    if ([self.info.from_uid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]])
    {
        theToUserName = self.info.to_username;
    }else
    {
        theToUserName = self.info.from_username;
    }
    
    
    NSString * fullUrl = [NSString stringWithFormat:@"http://msg.fblife.com/api.php?c=send&toname=%@&&content=%@&authcode=%@",[theToUserName stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[theInfo.msg_message stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD]];
    
    
    NSLog(@"上传的url --  %@",fullUrl);
    
    _request_send = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    _request_send.delegate = self;
    
    __block ASIHTTPRequest * request_ = _request_send;
    
    [request_ setCompletionBlock:^{
        
        NSDictionary * dictionary = [_request_send.responseData objectFromJSONData];
        
        NSLog(@"上传成功 ----  %@",[dictionary objectForKey:@"bbsinfo"]);
    }];
    
    [request_ setFailedBlock:^{
        
    }];
    
    
    [_request_send startAsynchronous];
}


-(void)loadNewMessage
{
    ChatInfo * info = [self.data_array objectAtIndex:self.data_array.count-1];
    
    [self initHttpRequestWithMaxId:info.msg_id];
}

-(void)back:(UIButton *)button
{
    [timer invalidate];
    
    if (_requset_data)
    {
        [_requset_data cancel];
        _requset_data.delegate = nil;
        _requset_data = nil;
    }
    
    if (_request_send)
    {
        [_request_send cancel];
        _request_send.delegate = nil;
        _request_send = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)finishSend
{
    [self.inputToolBarView.textView setText:nil];
    [self textViewDidChange:self.inputToolBarView.textView];
    //bottom_view.atextv.text=@"";
    
    [self.tableView reloadData];
    [self scrollToBottomAnimated:YES];
}


- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    
    if(rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:animated];
    }
}


#pragma mark - 底部界面
- (void)setup
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pinglun_bg(2).png"] forBarMetrics: UIBarMetricsDefault];
    }
    
    self.navigationItem.title = self.info.from_username;
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 32, 28)];
    [button_back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"bc@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    self.navigationItem.leftBarButtonItem=back_item;
    
    
    self.data_array = [[NSMutableArray alloc] init];
    
    self.messageArray = [[NSMutableArray alloc] init];
    
    self.timesArray = [[NSMutableArray alloc] init];
    
    [self initHttpRequestWithMaxId:@""];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadNewMessage) userInfo:nil repeats:YES];
    
    
    
    if([self.view isKindOfClass:[UIScrollView class]])
    {
        // fix for ipad modal form presentations
        ((UIScrollView *)self.view).scrollEnabled = NO;
    }
    
    CGSize size = self.view.frame.size;
	
    CGRect tableFrame = CGRectMake(0.0f, 0.0f, size.width, size.height - INPUT_HEIGHT);
	self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self.view addSubview:self.tableView];
    
    CGRect inputFrame = CGRectMake(0.0f, size.height - INPUT_HEIGHT, size.width, INPUT_HEIGHT);
    self.inputToolBarView = [[JSMessageInputView alloc] initWithFrame:inputFrame delegate:self];
    
    // TODO: refactor
    self.inputToolBarView.textView.dismissivePanGestureRecognizer = self.tableView.panGestureRecognizer;
    self.inputToolBarView.textView.keyboardDelegate = self;
    
    UIButton *sendButton = [self sendButton];
    sendButton.enabled = NO;
    sendButton.frame = CGRectMake(self.inputToolBarView.frame.size.width - 65.0f, 8.0f, 59.0f, 26.0f);
    [sendButton addTarget:self
                   action:@selector(sendPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.inputToolBarView setSendButton:sendButton];
    [self.view addSubview:self.inputToolBarView];
    
    //    bottom_view=[[botomviewofchat alloc]initWithFrame:CGRectMake(0, 370, 320, 300)];
    //    bottom_view.atextv.delegate=self;
    //    bottom_view.delegate=self;
    //    [self.view addSubview:bottom_view];
}
#pragma mark-底部的view已经上面的输入框的代理
-(void)sendwithtext:(NSString *)mytext{
    NSLog(@"mytext==%@",mytext);
    
    [self.timesArray addObject:[zsnApi timeFromDate:[NSDate date]]];
    
    ChatInfo * info = [[ChatInfo alloc] init];
    
    info.date_now = [zsnApi timeFromDate:[NSDate date]];
    
    info.to_uid = self.info.from_username;
    
    info.to_username = self.info.from_username;
    
    info.from_username = self.info.to_username;
    
    info.from_uid = self.info.from_uid;
    
    info.msg_message = [mytext trimWhitespace];
    
    [self.data_array addObject:info];
    
    [self writeMessageRequest:info];
    [self finishSend];
    //    [bottom_view.atextv resignFirstResponder];
    //    bottom_view.frame=CGRectMake(0, 300, 320, 200);
    //
    
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"let us begain");
}
- (void)textViewDidEndEditing:(UITextView *)textView{
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    
}

-(void)sendPressed:(UIButton *)button
{
    NSLog(@"sending...%@",self.inputToolBarView.textView.text);
    [self.timesArray addObject:[zsnApi timeFromDate:[NSDate date]]];
    
    ChatInfo * info = [[ChatInfo alloc] init];
    
    info.date_now = [zsnApi timeFromDate:[NSDate date]];
    
    info.to_uid = self.info.from_username;
    
    info.to_username = self.info.from_username;
    
    info.from_username = self.info.to_username;
    
    info.from_uid = self.info.from_uid;
    
    info.msg_message = [self.inputToolBarView.textView.text trimWhitespace];
    
    [self.data_array addObject:info];
    
    [self writeMessageRequest:info];
    
    
    
    [self finishSend];
}


- (UIButton *)sendButton
{
    return [UIButton defaultSendButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setup];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillShowKeyboard:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillHideKeyboard:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



#pragma mark UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data_array.count;
}


-(CGPoint)returnHeightWithArray:(NSArray *)array WithType:(MyChatViewCellType)theType
{
    float theWidth;
    float theHeight = 5;
    for (NSString * string in array)
    {
        if (string.length > 0)
        {
            if ([string rangeOfString:@"[img]"].length && [string rangeOfString:@"[/img]"].length)
            {
                theWidth = theWidth>140?theWidth:140;
                theHeight += 120;
            }else
            {
                
                NSString * tempString = string;
                
                while ([tempString rangeOfString:@"&nbsp;"].length )
                {
                    tempString = [tempString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                }
                
                //去除[url] [b] [i] [u]
                
                
                NSString * clean_string = tempString;
                
                
                while ([clean_string rangeOfString:@"[b]"].length || [clean_string rangeOfString:@"[i]"].length || [clean_string rangeOfString:@"[u]"].length || [clean_string rangeOfString:@"[url]"].length)
                {
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                    
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[b]" withString:@""];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[/b]" withString:@""];
                    
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[i]" withString:@""];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[/i]" withString:@""];
                    
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[u]" withString:@""];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[/u]" withString:@""];
                    
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[url]" withString:@""];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[/url]" withString:@""];
                }
                
                
                UILabel * tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(theType ==JSBubbleMessageTypeIncoming?15:5,theHeight,250,50)];
                
                CGPoint thePoint = [self LinesWidth:clean_string Label:tempLabel];
                
                theWidth = thePoint.x>theWidth?thePoint.x:theWidth;
                
                NSLog(@"返回的高度是多少 ----  %f",thePoint.y);
                
                theHeight += thePoint.y;
            }
        }
    }
    
    return CGPointMake(theWidth,theHeight);
}

-(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label
{
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(250, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGPoint lastPoint;
    CGSize sz = [string sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT,40)];
    CGSize linesSz = [string sizeWithFont:label.font constrainedToSize:CGSizeMake(250, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if(sz.width <= linesSz.width) //判断是否折行
    {
        lastPoint = CGPointMake(label.frame.origin.x + sz.width,linesSz.height);
    }else
    {
        lastPoint = CGPointMake(label.frame.origin.x + (int)sz.width % (int)linesSz.width,titleSize.height+((titleSize.height/19)-1)*3);
    }
    
    return lastPoint;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatInfo * info = [self.data_array objectAtIndex:indexPath.row];
    
    CGPoint point = [self returnHeightWithArray:[zsnApi stringExchange:info.msg_message] WithType:JSBubbleMessageTypeIncoming];
    return point.y < 50?50+26:point.y+20 + 26;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell";
    
    MyChatViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[MyChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    ChatInfo * info = [self.data_array objectAtIndex:indexPath.row];
    
    MyChatViewCellType theType;
    
    if ([info.from_username isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]])
    {
        theType = JSBubbleMessageTypeOutgoing;
    }else
    {
        theType = JSBubbleMessageTypeIncoming;
    }
    
    
    
    
    
    [cell loadAllViewWithUrl:info Style:theType];
    
    return cell;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    NSLog(@"height===%f",kbSize.height);
    if (kbSize.height == 252)//中文键盘
    {
        bottom_view.frame=CGRectMake(0,iPhone5?125+88: 125, 320, 300);
    }else//英文键盘
    {
        bottom_view.frame=CGRectMake(0,iPhone5?125+36+88: 125+36, 320, 300);
        
    }
    
    
    [UIView commitAnimations];
    
    
    
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)keyboardWillShowHide:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:[UIView animationOptionsForCurve:curve]
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
                         
                         UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                0.0f,
                                                                self.view.frame.size.height - self.inputToolBarView.frame.origin.y - INPUT_HEIGHT,
                                                                0.0f);
                         
                         self.tableView.contentInset = insets;
                         self.tableView.scrollIndicatorInsets = insets;
                     }
                     completion:^(BOOL finished) {
                     }];
    
    
    
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
//
//#pragma mark - Text view delegate
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    [textView becomeFirstResponder];
//
//    if(!self.previousTextViewContentHeight)
//		self.previousTextViewContentHeight = textView.contentSize.height;
//
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    [textView resignFirstResponder];
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//
//    CGFloat maxHeight = [JSMessageInputView maxHeight];
//
//    CGFloat textViewContentHeight = textView.contentSize.height;
//
//    BOOL isShrinking = textViewContentHeight < self.previousTextViewContentHeight;
//    CGFloat changeInHeight = textViewContentHeight - self.previousTextViewContentHeight;
//
//    if(!isShrinking && self.previousTextViewContentHeight == maxHeight) {
//        changeInHeight = 0;
//    }
//    else {
//        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
//    }
//
//    if(changeInHeight != 0.0f) {
//        if(!isShrinking)
//            [self.inputToolBarView adjustTextViewHeightBy:changeInHeight];
//
//        [UIView animateWithDuration:0.25f
//                         animations:^{
//
//                             CGRect inputViewFrame = self.inputToolBarView.frame;
//                             self.inputToolBarView.frame = CGRectMake(0.0f,
//                                                                      inputViewFrame.origin.y - changeInHeight,
//                                                                      inputViewFrame.size.width,
//                                                                      inputViewFrame.size.height + changeInHeight);
//                         }
//                         completion:^(BOOL finished) {
//                             if(isShrinking)
//                                 [self.inputToolBarView adjustTextViewHeightBy:changeInHeight];
//                         }];
//
//        self.previousTextViewContentHeight = MIN(textViewContentHeight, maxHeight);
//    }
//
//
//    self.inputToolBarView.sendButton.enabled = ([textView.text trimWhitespace].length > 0);
//}
//





#pragma mark-tool

-(CGSize)textSizeForText:(NSString *)txt
{
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width * 0.75f;
    CGFloat height = MAX([self numberOfLinesForMessage:txt],
                         [txt numberOfLines]) * [self textViewLineHeight];
    
    return [txt sizeWithFont:[self thefont]
           constrainedToSize:CGSizeMake(width - kJSAvatarSize, height + kJSAvatarSize)
               lineBreakMode:NSLineBreakByWordWrapping];
}

-(int)numberOfLinesForMessage:(NSString *)txt
{
    return (txt.length / [self maxCharactersPerLine]) + 1;
}


-(CGFloat)textViewLineHeight
{
    return 30.0f; // for fontSize 15.0f
}


-(UIFont *)thefont
{
    return [UIFont systemFontOfSize:16.0f];
}

-(int)maxCharactersPerLine
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}








@end




















