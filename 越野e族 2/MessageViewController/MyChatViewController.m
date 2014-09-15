//
//  MyChatViewController.m
//  FbLife
//
//  Created by soulnear on 13-8-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//


#define INPUT_HEIGHT 40.0f
#define image_width 81.0f
#define image_height 70.0f


#import "MyChatViewController.h"
#import "ChatInfo.h"
#import "NSString+JSMessagesView.h"
#import "UIView+AnimationOptionsForCurve.h"
#import "UIColor+JSMessagesView.h"
#import "MyChatViewCell.h"
#import "fbWebViewController.h"

@interface MyChatViewController ()
{
    AlertRePlaceView * _replaceAlertView;
    
    int temp_count;
    
    UITextView * temp_textView;
}

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
@synthesize photo_array = _photo_array;

@synthesize theTouchView = _theTouchView;


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
        
        NSDictionary * dic = [_requset_data.responseData objectFromJSONData];
        
        @try
        {
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
            
            NSLog(@"什么东西啊没走啊");
            
            [self finishSend];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
        
    }];
    
    
    [request__ setFailedBlock:^{
        _replaceAlertView.hidden=NO;
        [_replaceAlertView hide];
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
        
        //        NSDictionary * dictionary = [_request_send.responseData objectFromJSONData];
    }];
    
    [request_ setFailedBlock:^{
        
    }];
    
    
    [_request_send startAsynchronous];
}

-(void)loadNewMessage
{
    if (self.data_array.count>0)
    {
        ChatInfo * info = [self.data_array objectAtIndex:self.data_array.count-1];
        
        [self initHttpRequestWithMaxId:info.msg_id];
    }
}

-(void)back:(UIButton *)button
{
    [timer invalidate];
    
    [_replaceAlertView removeFromSuperview];
    
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
    NSLog(@"走没走啊 ----  %d",self.data_array.count);
    [self.inputToolBarView.textView setText:@""];
    //     [self textViewDidChange:self.inputToolBarView.textView];
    [self.tableView reloadData];
    [self scrollToBottomAnimated:NO];
}

-(void)finnishendsend2{
    [self.inputToolBarView.textView setText:@""];
    [self textViewDidChange:self.inputToolBarView.textView];
    [self.tableView reloadData];
    [self scrollToBottomAnimated:NO];
    
}
- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    
    if(rows > 0)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
}


-(void)PeopleView:(UIButton *)sender
{
    
    NSString * myUid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
    
    
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    if ([myUid isEqualToString:self.info.to_uid])
    {
        mine.uid = self.info.from_uid;
    }else
    {
        mine.uid = self.info.to_uid;
    }
    
    [self.navigationController pushViewController:mine animated:YES];
}


#pragma mark - Initialization
- (void)setup
{
    
    temp_count = 1;
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    self.navigationItem.title = self.info.othername;
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    
//    UIBarButtonItem * spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceButton.width = MY_MACRO_NAME?0:5;
//    
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,12,21.5)];
//    [button_back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back@2x.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItems=@[spaceButton,back_item];
//    
//    
//    UIButton * peopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    peopleButton.frame = CGRectMake(0,0,36/2,33/2);
//    
//    [peopleButton setImage:[UIImage imageNamed:@"chat_people.png"] forState:UIControlStateNormal];
//    
//    [peopleButton addTarget:self action:@selector(PeopleView:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem * People_button = [[UIBarButtonItem alloc] initWithCustomView:peopleButton];
//    
//    self.navigationItem.rightBarButtonItems = @[spaceButton,People_button];
    
    
    self.rightImageName = @"chat_people";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeOther];
    
    self.navigationItem.title = self.info.othername;

    self.view.backgroundColor = RGBCOLOR(248,248,248);
    
    self.data_array = [[NSMutableArray alloc] init];
    
    self.messageArray = [[NSMutableArray alloc] init];
    
    self.timesArray = [[NSMutableArray alloc] init];
    
    [self initHttpRequestWithMaxId:@""];
    
    
    //    timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(loadNewMessage) userInfo:nil repeats:YES];
    
    
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
    self.tableView.backgroundColor = RGBCOLOR(248,248,248);
	[self.view addSubview:self.tableView];
    
    backkeyboard =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backkeyboard)];
    
    // Set required taps and number of touches
    [backkeyboard setNumberOfTapsRequired:1];
    [backkeyboard setNumberOfTouchesRequired:1];
    self.tableView.userInteractionEnabled=YES;
    [self.tableView addGestureRecognizer:backkeyboard];
    
    
    CGRect inputFrame = CGRectMake(0.0f, size.height - INPUT_HEIGHT, size.width, INPUT_HEIGHT);
    self.inputToolBarView = [[JSMessageInputView alloc] initWithFrame:inputFrame delegate:self];
    
    // TODO: refactor
    self.inputToolBarView.textView.dismissivePanGestureRecognizer = self.tableView.panGestureRecognizer;
    self.inputToolBarView.backgroundColor=[UIColor clearColor];
    
    self.inputToolBarView.textView.keyboardDelegate = self;
    
    UIButton *sendButton = [self sendButton];
    sendButton.enabled = NO;
    sendButton.frame = CGRectMake(self.inputToolBarView.frame.size.width - 55.0f, 5.0f, 113/2, 30.0f);
    [sendButton addTarget:self
                   action:@selector(sendPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.inputToolBarView setSendButton:sendButton];
    [self.view addSubview:self.inputToolBarView];
    
    
    
    
    _replaceAlertView=[[AlertRePlaceView alloc]initWithFrame:CGRectMake(85, 200, 150, 100) labelString:@"您的网络不给力哦，请检查网络"];
    _replaceAlertView.delegate=self;
    _replaceAlertView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_replaceAlertView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewMessage) name:@"postNewMessage" object:nil];
    
}

-(void)rightButtonTap:(UIButton *)sender
{
    [self PeopleView:sender];
}

#pragma mark-显示框
-(void)hidefromview
{
    [self performSelector:@selector(hidealert) withObject:nil afterDelay:2];
}
-(void)hidealert
{
    _replaceAlertView.hidden=YES;
}

#pragma mark-收回键盘
-(void)backkeyboard
{
    //    CGSize size = self.view.frame.size;
    
    //  self.inputToolBarView.frame=CGRectMake(0.0f, size.height - INPUT_HEIGHT, size.width, INPUT_HEIGHT);
    
    [self.tableView removeGestureRecognizer:backkeyboard];
    
    [self.inputToolBarView.textView resignFirstResponder];
    
}
-(void)sendPressed:(UIButton *)button
{
    [self.timesArray addObject:[personal mycurrenttime]];
    
    ChatInfo * info = [[ChatInfo alloc] init];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *string_date___=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    
    info.date_now =string_date___ ;
    
    
    if ([self.info.from_uid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]])
    {
        info.to_uid = self.info.to_uid;
        
        info.to_username = self.info.to_username;
        
        info.from_username = self.info.from_username;
        
        info.from_uid = self.info.from_uid;
    }else
    {
        info.to_uid = self.info.from_uid;
        
        info.to_username = self.info.from_username;
        
        info.from_username = self.info.to_username;
        
        info.from_uid = self.info.to_uid;
    }
    
    info.msg_message = [self.inputToolBarView.textView.text trimWhitespace];
    
    [self.data_array addObject:info];
    
    [self writeMessageRequest:info];
    
    [self finnishendsend2];
}


- (UIButton *)sendButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor clearColor];
    
    [button setTitle:@"发送" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return button;
    
    //    return [UIButton defaultSendButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setup];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"MyChatViewController"];
    
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
    
    [MobClick endEvent:@"MyChatViewController"];
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
    float theHeight = 0;
    for (NSString * string in array)
    {
        if (string.length > 0)
        {
            if ([string rangeOfString:@"[img]"].length && [string rangeOfString:@"[/img]"].length)
            {
                theWidth = theWidth>140?theWidth:140;
                theHeight = theHeight + image_height + 5;
            }else
            {
                
                NSString * tempString = string;
                
                while ([tempString rangeOfString:@"&nbsp;"].length )
                {
                    tempString = [tempString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                }
                
                //去除[url] [b] [i] [u]
                
                
                NSString * clean_string = tempString;
                
                
                while ([clean_string rangeOfString:@"[b]"].length || [clean_string rangeOfString:@"[i]"].length || [clean_string rangeOfString:@"[u]"].length || [clean_string rangeOfString:@"[url]"].length|| [clean_string rangeOfString:@"[url="].length|| [clean_string rangeOfString:@"]"].length)
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
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"[url" withString:@""];
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"]" withString:@""];
                }
                
                
                UILabel * tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(theType ==JSBubbleMessageTypeIncoming?15:5,theHeight,250,50)];
                
                CGPoint thePoint = [self LinesWidth:clean_string Label:tempLabel];
                
                theWidth = thePoint.x>theWidth?thePoint.x:theWidth;
                
                
                while ([clean_string rangeOfString:@"&"].length)
                {
                    clean_string = [clean_string stringByReplacingOccurrencesOfString:@"&" withString:@""];
                }
                
                theHeight += [zsnApi theHeight:clean_string withHeight:240 WidthFont:[UIFont systemFontOfSize:16]];
            }
        }
    }
    
    return CGPointMake(theWidth,theHeight);
}

-(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label
{
    
    float theLastWidth = 0;
    NSArray * array = [string componentsSeparatedByString:@"\n"];
    
    for (NSString * str in array)
    {
        CGSize titleSize = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        theLastWidth = titleSize.width>theLastWidth?titleSize.width:theLastWidth;
    }
    
    
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGPoint lastPoint;
    CGSize sz = [string sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT,40)];
    CGSize linesSz = [string sizeWithFont:label.font constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if(sz.width <= linesSz.width) //判断是否折行
    {
        lastPoint = CGPointMake(label.frame.origin.x + sz.width,linesSz.height);
    }else
    {
        lastPoint = CGPointMake(label.frame.origin.x + (int)sz.width % (int)linesSz.width,titleSize.height+((titleSize.height/19)-1)*3);
    }
    
    lastPoint = CGPointMake(theLastWidth,lastPoint.y);
    
    return lastPoint;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.data_array.count-1>=indexPath.row)
    {
        ChatInfo * info = [self.data_array objectAtIndex:indexPath.row];
        
        MyChatViewCellType theType;
        
        if ([info.from_username isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]])
        {
            theType = JSBubbleMessageTypeOutgoing;
        }else
        {
            theType = JSBubbleMessageTypeIncoming;
        }
        
        if (!test_cell)
        {
            test_cell = [[MyChatViewCell alloc] init];
        }
        
        
        CGPoint point = [test_cell returnHeightWithArray:[zsnApi stringExchange:info.msg_message] WithType:theType];
        
        //        CGPoint point = [self returnHeightWithArray:[zsnApi stringExchange:info.msg_message] WithType:JSBubbleMessageTypeIncoming];
        
        return point.y < 40? 50+25:point.y + 50;
    }else
    {
        return 88;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell";
    
    MyChatViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[MyChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSLog(@"self.data_array -----  %d",self.data_array.count);
    if (self.data_array.count>0)
    {
        ChatInfo * info = [self.data_array objectAtIndex:indexPath.row];
        MyChatViewCellType theType;
        
        if ([info.from_uid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]])
        {
            theType = JSBubbleMessageTypeOutgoing;
        }else
        {
            theType = JSBubbleMessageTypeIncoming;
        }
        
        [cell loadAllViewWithUrl:info Style:theType];
    }
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



-(void)showImageDetail:(UIImage *)image
{
    MWPhoto * photo = [MWPhoto photoWithImage:image];
    _photo_array = [[NSMutableArray alloc] init];
    
    [_photo_array addObject:photo];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    
    [self presentModalViewController:browser animated:YES];
}


-(void)showClickUrlDetail:(NSString *)theUrl
{
    fbWebViewController *fbweb=[[fbWebViewController alloc]init];
    
    fbweb.urlstring = theUrl;
    
    [self.navigationController pushViewController:fbweb animated:YES];
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photo_array.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photo_array.count)
        return [_photo_array objectAtIndex:index];
    return nil;
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
    
    [self scrollToBottomAnimated:YES];
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
                         
                         _theTouchView.frame = CGRectMake(0,0,320,self.inputToolBarView.frame.origin.y);
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



#pragma mark-touches


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _theTouchView.hidden = YES;
    
    [self.inputToolBarView.textView resignFirstResponder];
    
}



#pragma mark - Text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
    
    if (!_theTouchView)
    {
        //        _theTouchView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,iPhone5?568-20-44:480-22-44)];
        
        
        _theTouchView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.inputToolBarView.frame.origin.y)];
        
        _theTouchView.backgroundColor = [UIColor clearColor];
        
        [self.view bringSubviewToFront:_theTouchView];
        
        [self.view addSubview:_theTouchView];
    }else
    {
        _theTouchView.hidden = NO;
    }
    
    if(!self.previousTextViewContentHeight)
		self.previousTextViewContentHeight = textView.contentSize.height;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
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
    
    
    
    /*
     
     CGFloat maxHeight = [JSMessageInputView maxHeight];
     
     CGFloat textViewContentHeight = textView.contentSize.height;
     
     BOOL isShrinking = textViewContentHeight < self.previousTextViewContentHeight;
     
     CGFloat changeInHeight = textViewContentHeight - self.previousTextViewContentHeight;
     
     if(!isShrinking && self.previousTextViewContentHeight == maxHeight) {
     changeInHeight = 0;
     }
     else {
     changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
     }
     
     if(changeInHeight != 0.0f)
     {
     if(!isShrinking)
     [self.inputToolBarView adjustTextViewHeightBy:changeInHeight];
     
     [UIView animateWithDuration:0.25f
     animations:^{
     
     CGRect inputViewFrame = self.inputToolBarView.frame;
     self.inputToolBarView.frame = CGRectMake(0.0f,
     inputViewFrame.origin.y - changeInHeight,
     inputViewFrame.size.width,
     inputViewFrame.size.height + changeInHeight);
     }
     completion:^(BOOL finished) {
     if(isShrinking)
     [self.inputToolBarView adjustTextViewHeightBy:changeInHeight];
     }];
     
     self.previousTextViewContentHeight = MIN(textViewContentHeight, maxHeight);
     }
     
     */
    
    self.inputToolBarView.sendButton.enabled = ([textView.text trimWhitespace].length > 0);
}





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
    return [UIFont systemFontOfSize:15.0f];
}

-(int)maxCharactersPerLine
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)?30:109;
}








@end




















