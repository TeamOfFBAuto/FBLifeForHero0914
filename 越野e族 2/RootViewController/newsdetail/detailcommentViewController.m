//
//  detailcommentViewController.m
//  FblifeAll
//
//  Created by szk on 13-1-21.
//  Copyright (c) 2013年 fblife. All rights reserved.
//

#import "detailcommentViewController.h"
#import "personal.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "DefaultConstant.h"
#import "LogInViewController.h"
//105获取评论列表，106对评论进行评论
@interface detailcommentViewController (){
    BOOL isiphone5;
    UIButton *button_face;
    NSDictionary *_dic;
    
}

@end

@implementation detailcommentViewController
@synthesize allcount,string_ID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [MobClick beginEvent:@"detailcommentViewController"];
    
    [self fasongpinglunqingqiu];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"detailcommentViewController"];
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    isiphone5=[personal isiphone5];
    
    array_time=[[NSMutableArray alloc]init];
    array_content=[[NSMutableArray alloc]init];
    array_name=[[NSMutableArray alloc]init];
    array_weiboinfo=[[NSMutableArray alloc]init];
    dic_info=[[NSMutableDictionary alloc]init];
    
    
    aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:aview];;
    self.view.backgroundColor=[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    /// self.navigationController.navigationBarHidden=YES;
    
    
    //    UIView *view_daohang=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //    view_daohang.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pinglun_bg@2x.png"]];
    //    [aview addSubview:view_daohang];
    //
    //导航部分
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(5, 8, 32, 28)];
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    [button_back setBackgroundImage:[UIImage imageNamed:@"bc@2x.png"] forState:UIControlStateNormal];
    //  [view_daohang addSubview:button_back];
    
    self.navigationItem.title = @"评论";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //    UIButton *button_comment=[[UIButton alloc]initWithFrame:CGRectMake(265, 8, 46, 28)];
    //    [button_comment setTitle:@"排序" forState:UIControlStateNormal];
    //    //[button_comment addTarget:self action:@selector(commentyemian) forControlEvents:UIControlEventTouchUpInside];
    //    [button_comment setBackgroundImage:[UIImage imageNamed:@"ping@2x.png"] forState:UIControlStateNormal];
    //    [view_daohang addSubview:button_comment];
    //    [button_comment addTarget:self action:@selector(paixu) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //评论部分
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {

        //iOS 5 new UINavigationBar custom background

        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pinglun_bg.png"] forBarMetrics: UIBarMetricsDefault];
    }
    //
    //self.navigationController.navigationBar.tintColor=RGBCOLOR(74,73,72);
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:74 green:73 blue:72 alpha:1];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    self.navigationItem.leftBarButtonItem=back_item;
    
    //  self.navigationItem.title=@"新闻中心";
    
    
    
    
    if (isiphone5) {
        view_pinglun=[[UIView alloc]initWithFrame:CGRectMake(0, 419+88-44, 320, 41)];
        
    }else{
        view_pinglun=[[UIView alloc]initWithFrame:CGRectMake(0, 419-44, 320, 41)];
        
    }
    
    
    [aview addSubview:view_pinglun];
    [view_pinglun setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pinglun_bg1@2x.png"]]];
    
    UIImageView *image_write=[[UIImageView alloc]initWithFrame:CGRectMake(8, 7.5, 188, 26)];
    image_write.image=[UIImage imageNamed:@"pinglun2_bg@2x.png"];
    [view_pinglun addSubview:image_write];
    
    text_write=[[UITextField alloc]initWithFrame:CGRectMake(12, 10, 185, 22)];
    text_write.backgroundColor=[UIColor clearColor];
    [view_pinglun addSubview:text_write];
    text_write.placeholder=@"写评论";
    text_write.text=@"";
    text_write.delegate=self;
    
    UIButton *button_fabiao=[[UIButton alloc]initWithFrame:CGRectMake(260, 7, 50, 27)];
    [button_fabiao setBackgroundImage:[UIImage imageNamed:@"fabiao@2x.png"] forState:UIControlStateNormal];
    [view_pinglun addSubview:button_fabiao];
    button_fabiao.backgroundColor=[UIColor clearColor];
    [button_fabiao addTarget:self action:@selector(fabiao) forControlEvents:UIControlEventTouchUpInside];
    
    isjianpan=NO;
    button_face=[[UIButton alloc]initWithFrame:CGRectMake(208, 5, 40, 32)];
    [button_face setBackgroundImage:[UIImage imageNamed:@"write_face80 64@2x.png"] forState:UIControlStateNormal];
    [view_pinglun addSubview:button_face];
    button_face.backgroundColor=[UIColor clearColor];
    [button_face addTarget:self action:@selector(faceview) forControlEvents:UIControlEventTouchUpInside];
    
    //有关facescroview,刚开始是隐藏的
    
    faceScrollView = [[FaceScrollView alloc] initWithFrame:CGRectMake(0, 900, self.view.frame.size.width, 160) target:self];
    //    faceScrollView.pagingEnabled = YES;
    faceScrollView.backgroundColor = [UIColor clearColor];
    faceScrollView.contentSize = CGSizeMake(320*2, 160);
    [self.view addSubview:faceScrollView];
    
    //有关下拉刷新
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tab_pinglunliebiao.bounds.size.height, self.view.frame.size.width, tab_pinglunliebiao.bounds.size.height)];
		view.delegate = self;
       // view.backgroundColor=[UIColor redColor];
		//[tab_pinglunliebiao addSubview:view];
		_refreshHeaderView = view;
		
	}
	[_refreshHeaderView refreshLastUpdatedDate];

    //load
    //评论列表
    
    
    if (isiphone5) {
        tab_pinglunliebiao=[[UITableView alloc]initWithFrame:CGRectMake(0, 44-44, 320, 568-44-17-44)];
        
    }else{
        tab_pinglunliebiao=[[UITableView alloc]initWithFrame:CGRectMake(0, 44-44, 320, 480-44-17-44)];
        
    }
    
    tab_pinglunliebiao.backgroundColor=[UIColor clearColor];
    tab_pinglunliebiao.delegate=self;
    tab_pinglunliebiao.dataSource=self;
    tab_pinglunliebiao.userInteractionEnabled=YES;
    [aview addSubview:tab_pinglunliebiao];
    
    UISwipeGestureRecognizer *_swip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backto)];
    _swip.direction=UISwipeGestureRecognizerDirectionRight;
    [tab_pinglunliebiao addGestureRecognizer:_swip];
    
    tab_pinglunliebiao.tableHeaderView = _refreshHeaderView;
    
    
    
    //动态获取键盘高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //点击隐藏键盘按钮所触发的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /*发表评论的接口*/
    //http://t.fblife.com/openapi/index.php?mod=comment&code=commentadd&sortid=511&content=ttttt&title=ssfsf&fromtype=b5eeec0b&authkey=V2gAalEwUzcCMlM/USoH1QHAVYEMllqyUZQ=
    //获取评论的接口
    //http://t.fblife.com/openapi/index.php?mod=comment&code=commentlist&sortid=511&fbtype=json
    
    //数据解析部分
    //[self fasongpinglunqingqiu];
    
	// Do any additional setup after loading the view.
}
#pragma mark tableviewdelegate and datesource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array_content count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stringcell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:stringcell];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel *label_lou=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 20)];
    [cell.contentView addSubview:label_lou];
    label_lou.textColor=[UIColor grayColor];
    label_lou.backgroundColor=[UIColor clearColor];
    label_lou.font=[UIFont fontWithName:@"Helvetica" size:12.0];
    
    UILabel *label_name=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 100, 20)];
    label_name.backgroundColor=[UIColor clearColor];
    label_name.textColor=[UIColor grayColor];
    [cell.contentView addSubview:label_name];
    label_name.font=[UIFont fontWithName:@"Helvetica" size:12.0];
    
    UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(245, 5, 63, 20)];
    label_time.textAlignment=NSTextAlignmentRight;
    label_time.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:label_time];
    label_time.textColor=[UIColor grayColor];
    label_time.font=[UIFont fontWithName:@"Helvetica" size:11.0];
    
    UILabel *label_content=[[UILabel alloc]initWithFrame:CGRectMake(5, 27, 290, 20)];
    label_content.backgroundColor=[UIColor clearColor];
    
    // [cell.contentView addSubview:label_content];
    
    if ([array_name count]!=0) {
        label_lou.text=[NSString stringWithFormat:@"[%d楼]",allcount-indexPath.row];
        
        
        label_content.text=[NSString stringWithFormat:@"%@",[array_content objectAtIndex:indexPath.row]];
        label_name.text=[NSString stringWithFormat:@"%@",[array_name objectAtIndex:indexPath.row]];
        NSString *stringtime=[personal timestamp:[NSString stringWithFormat:@"%@",[array_time objectAtIndex:indexPath.row]]];
        label_time.text=stringtime;
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
        CGSize constraintSize = CGSizeMake(280, MAXFLOAT);
        CGSize labelSize = [label_content.text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILayoutPriorityRequired];
        label_content.frame=CGRectMake(5, 27, 290, labelSize.height);
        label_content.numberOfLines=0;
        
        NSArray *array=[array_content objectAtIndex:indexPath.row];
        
        UIView *aview1=[self assembleMessageAtIndex:array];
        aview1.frame=CGRectMake(10, 27, 240, aview1.frame.size.height);
        [cell.contentView addSubview:aview1];
        
        
        CGFloat haha=[self qugaodu:array];
        NSLog(@"haa==%f",haha);
        UIButton *button_huifu=[[UIButton alloc]initWithFrame:CGRectMake(280, haha, 28, 24)];
        [button_huifu setTitle:@"回复" forState:UIControlStateNormal];
        button_huifu.titleLabel.font=[UIFont systemFontOfSize:13];
        button_huifu.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button_huifu setTitleColor:[UIColor colorWithRed:51/255.f green:84/255.f blue:124/255.f alpha:1] forState:UIControlStateNormal];
        button_huifu.backgroundColor=[UIColor clearColor];
        [button_huifu addTarget:self action:@selector(huifupinglun:) forControlEvents:UIControlEventTouchUpInside];
        button_huifu.tag=indexPath.row+100;
        [cell.contentView addSubview:button_huifu];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float gaodu=0;
    if (array_name.count==0) {
        gaodu=40;
    }else{
        
        NSArray *array=[array_content objectAtIndex:indexPath.row];
        CGFloat haha=[self qugaodu:array];
        gaodu=27+haha;
    }
    return gaodu;
}
#pragma mark-加载数据
-(void)fasongpinglunqingqiu{
    
    //    //保存用户信息的常量key
    //#define USER_NAME @"username"
    //#define USER_PW @"userPw"
    //#define USER_IN @"user_in" //0是未登陆  1是已登陆
    //#define USER_AUTHOD @"user_authod"
    //#define USER_CHECKUSER @"checkfbuser"
    //#define TUPIANZHILIANG @"tupianzhiliang"
    //#define NOTIFICATION_QUXIAOGUANZHU @"quxiaoguanzhu"
    //#define NOTIFICATION_TIANJIAGUANZHU @"tianjiaguanzhu"
    //#define NOTIFICATION_REPLY @"reply"
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *string_autokey=[user objectForKey:USER_AUTHOD];
    NSString *String_name=[user objectForKey:USER_NAME];
    NSString *string_inornot=[user objectForKey:USER_IN];
    NSLog(@"hHhHahah====%@\n%@\n%@\n",string_autokey,String_name,string_inornot);
    
    
    
    NSString *string105=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=subcommentlist&tid=%d&fbtype=json",[self.string_ID integerValue]];
    NSLog(@"id======%@",self.string_ID);
    NSURL *url105 = [NSURL URLWithString:string105];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url105];
    request.tag=105;
    [request setDelegate:self];
    [request startAsynchronous];
    NSLog(@"开始加载更多数据");
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data=[request responseData];
    _dic = [data objectFromJSONData];
    NSLog(@"_dic====%@",_dic);
    switch (request.tag) {
        case 105:
            allcount=[[_dic objectForKey:@"total"]intValue];
            [array_name removeAllObjects];
            [array_time removeAllObjects];
            [array_content removeAllObjects];
            
            array_weiboinfo=[[NSMutableArray alloc]init];
            array_weiboinfo= [_dic objectForKey:@"weiboinfo"];
            for (int i=0; i<[array_weiboinfo count]; i++) {
                NSMutableDictionary *dic_3ge=[array_weiboinfo objectAtIndex:i];
                NSString *string_name=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"username"]];
                [array_name addObject:string_name];
                
                NSString *string_time=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"dateline"]];
                [array_time addObject:string_time];
                
                NSString *string_neirong=[NSString stringWithFormat:@"%@",[dic_3ge objectForKey:@"content"]];
                NSString *stringtest=[string_neirong stringByReplacingOccurrencesOfString:@"[" withString:@" ["];
                NSArray *arraytest = [stringtest componentsSeparatedByString:@" "];
                
                [array_content addObject:arraytest];
                NSLog(@"array_content==%@",array_content);
                
            }
            [tab_pinglunliebiao reloadData];
            
            break;
        case 106:
            NSLog(@"%@",[request responseString]);
            [self fasongpinglunqingqiu];
            
            
            break;
            
        default:
            break;
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时，请检查您的网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alertview show];
}
#pragma mark-有关图文混排的，返回view和高度

-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
#define KFacialSizeWidth 14
#define KFacialSizeHeight 14
    UIView *returnView = [[UIView alloc] init];
    
    NSArray *data = [[NSArray alloc]initWithArray:arr];
    UIFont *fon= [UIFont systemFontOfSize:14];
	CGFloat upX=0;
    CGFloat upY=0;
    
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > 230)
                {
                    upY = upY + KFacialSizeHeight+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[personal imgreplace:yaoxi];
                
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, 14, 15);
                [returnView addSubview:img];
				upX=KFacialSizeWidth+upX;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 230)
                    {
                        upY = upY + KFacialSizeHeight+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(230, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.backgroundColor=[UIColor clearColor];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    upX=upX+size.width;
                }
			}
        }
	}
    return returnView;
}
-(CGFloat)qugaodu:(NSArray*)arr{
    
    UIView *returnView = [[UIView alloc] init];
    
    NSArray *data = [[NSArray alloc]initWithArray:arr];
    
    UIFont *fon=   [UIFont fontWithName:@"Helvetica" size:14];
    
	CGFloat upX=0;
    CGFloat upY=0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > 230)
                {
                    upY = upY + KFacialSizeHeight+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[personal imgreplace:yaoxi];
                
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
				upX=KFacialSizeWidth+upX;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 230)
                    {
                        upY = upY + KFacialSizeHeight+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(230, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    upX=upX+size.width;
                }
			}
        }
	}
    
    return upY+25 ;
}


-(void)faceview{
    isjianpan=!isjianpan;
    button_face.backgroundColor=[UIColor clearColor];
    
    if (isjianpan) {
        [button_face setBackgroundImage:[UIImage imageNamed:@"write_jianpan_80 64@2x.png"] forState:UIControlStateNormal];
        button_face.frame=CGRectMake(208, 5, 35, 35*32/40);
        
        
        button_face.backgroundColor=[UIColor clearColor];
        
        [text_write resignFirstResponder];
        if (isiphone5) {
            aview.frame=CGRectMake(0,-160, 320, 568);
            
        }else{
            aview.frame=CGRectMake(0,-160, 320, 480);
            
        }
        [self facescrowviewshow];
        
    }else{
        [button_face setBackgroundImage:[UIImage imageNamed:@"write_face80 64@2x.png"] forState:UIControlStateNormal];
        button_face.frame=CGRectMake(208, 4, 40, 32);
        
        button_face.backgroundColor=[UIColor clearColor];
        
        [text_write becomeFirstResponder];
        if (isiphone5) {
            aview.frame=CGRectMake(0,-245+30, 320, 568);
            
        }else{
            aview.frame=CGRectMake(0,-245+30, 320, 480);
            
        }
        [self facescrowhiden];
    }
    
    // [faceScrollView setFrame:CGRectMake(0, -160, 320, 160)];
}
#pragma mark-回复评论的评论
-(void)huifupinglun:(UIButton*)sender{
    
    [text_write becomeFirstResponder];
    
    
    text_write.text=[NSString stringWithFormat:@"回复@%@ ：",[array_name objectAtIndex:sender.tag-100]] ;
}
#pragma mark 输入评论内容的代理

- (void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    
    if (kbSize.height == 252) {
        if (isiphone5) {
            aview.frame=CGRectMake(0,-245, 320, 568);
            
            
        }else{
            aview.frame=CGRectMake(0,-245, 320, 480);
            
        }
    }else {
        if (isiphone5) {
            aview.frame=CGRectMake(0,-245+36, 320, 568);
            
        }else{
            aview.frame=CGRectMake(0,-245+36, 320, 480);
            
        }
    }
    
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)note
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (isiphone5) {
        aview.frame = CGRectMake(0,0, 320, 568);
        
    }else{
        aview.frame = CGRectMake(0,0, 320, 480);
        
    }
    
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [text_write resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_CHECKUSER])
        {
            NSLog(@"已经激活／。。。");
            //已经激活过FB 加载个人信息
            text_write.returnKeyType=UIReturnKeyDone;
            text_write.keyboardType=UIKeyboardTypeDefault;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            if (isiphone5) {
                
                aview.frame=CGRectMake(0,-245+30, 320, 568);
                
            }else{
                aview.frame=CGRectMake(0,-245+30, 320, 480);
                
            }
            [UIView commitAnimations];
            
            
            
        }
    }
    else{
        //没有激活fb，弹出激活提示
        [text_write resignFirstResponder];
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentModalViewController:login animated:YES];    }
    
}
#pragma mark-激活fb
-(void)jihuoFb{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"激活" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    
}
#pragma mark-uiactionsheetdelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"激活");
        LogInViewController *login=[LogInViewController sharedManager];
[self presentModalViewController:login animated:YES];         
    }else{
        NSLog(@"取消");
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    faceScrollView.frame =CGRectMake(0, 1000, self.view.frame.size.width, 160);
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (isiphone5) {
        aview.frame=CGRectMake(0, 0, 320, 568);
        
    }else{
        aview.frame=CGRectMake(0, 0, 320, 480);
        
    }
    
    [UIView commitAnimations];
}
#pragma mark-发表评论的评论
-(void)fabiao{
    [text_write resignFirstResponder];
    NSLog(@"fabiaola");
    [self facescrowhiden];
    if (isiphone5) {
        aview.frame=CGRectMake(0, 0, 320, 568);
        
    }else{
        aview.frame=CGRectMake(0, 0, 320, 480);
        
    }
    
    if (text_write.text.length==0) {
        UIAlertView *viewalert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"评论内容不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [viewalert show];
        return;
    }
    //http://t.fblife.com/openapi/index.php?mod=comment&code=subcommentadd&tid=6319&content=%@&topictype=reply&fromtype=b5eeec0b&authkey=VGsGbFU0XzsCMlU5VyxQggPCV4MBm1uzB8I=
    
    
    NSString *string_106=[[NSString alloc]initWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=comment&code=subcommentadd&tid=%d&content=%@&topictype=reply&fromtype=b5eeec0b&authkey=%@",[self.string_ID integerValue],[text_write.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    NSURL *url106 = [NSURL URLWithString:string_106];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url106];
    request.tag=106;
    [request setDelegate:self];
    [request startAsynchronous];
    text_write.text=@"";
    
}

#pragma mark-让facesvrowview弹出或者隐藏的方法
-(void)facescrowviewshow{
    if (isiphone5) {
        faceScrollView.frame = CGRectMake(0, 568-180-44, self.view.frame.size.width, 160);
        
    }else{
        faceScrollView.frame = CGRectMake(0, 480-180-44, self.view.frame.size.width, 160);
        
    }
    
    
}
-(void)facescrowhiden{
    faceScrollView.frame = CGRectMake(0, 900, self.view.frame.size.width, 160);
    
}

#pragma mark-返回上一级
-(void)backto{
    [text_write resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-faceview的代理
-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_CHECKUSER])
        {
            
            text_write.text=[NSString stringWithFormat:@"%@%@",text_write.text,name];
            
        }
    }
    else{
        [self facescrowhiden];
        //没有激活fb，弹出激活提示
        [text_write resignFirstResponder];
        LogInViewController *login=[LogInViewController sharedManager];
        [self presentViewController:login animated:YES completion:nil];
    }
}
#pragma mark-下拉刷新的代理

- (void)reloadTableViewDataSource
{
    _reloading = YES;
    
    
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tab_pinglunliebiao];
    
}
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self fasongpinglunqingqiu];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//对应ios6下的横竖屏问题
- (BOOL)shouldAutorotate{
    return  NO;
}
@end
