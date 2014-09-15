//
//  DraftBoxViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "DraftBoxViewController.h"
#import "commrntbbdViewController.h"
#import "WriteBlogViewController.h"
#import "commentViewController.h"
#import "ForwardingViewController.h"
#import "testimgViewController.h"
#import "NewWeiBoCommentViewController.h"



@interface DraftBoxViewController ()
{
    UIButton * button3;
    UIButton * button4;
}

@end

@implementation DraftBoxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)hidefromview
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deletebystring_content:) name:@"refreshmydata" object:nil];

//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(5, 8, 24/2, 43/2)];
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back@2x.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItem=back_item;
    
    UIView *aview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view=aview;
    aview.backgroundColor=[UIColor underPageBackgroundColor];
    
    
    
    
    isWeiBo = YES;
    
    array_info=[[NSMutableArray alloc]init];
    
    theUserName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    
    for (DraftDatabase * data in [DraftDatabase findalldata])
    {
        if ([data.username isEqualToString:theUserName])
        {
            [array_info addObject:data];
        }
    }
    
    
    //    array_info = [DraftDatabase findallbytheColumns:@"微博"];
    
    
    tab_=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-44-20:480-44-20)];
    [aview addSubview:tab_];
    tab_.dataSource=self;
    tab_.delegate=self;
    
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0)];
    
    v.backgroundColor = [UIColor clearColor];
    
    tab_.tableFooterView = v;
    tab_.tableHeaderView = v;
    tab_.separatorColor=[UIColor clearColor];
    
    
    
    wormingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,iPhone5?568-64:480-64)];
    
    wormingLabel.backgroundColor = [UIColor clearColor];
    
    wormingLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *img_none=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_zanwu_120_120.png"]];
    img_none.center=CGPointMake(160, 375/2);
    
    [wormingLabel addSubview:img_none];
    
    UILabel *label_=[[UILabel alloc]initWithFrame:CGRectMake(0, 464/2, 320, 15)];
    label_.text=@"还没有草稿";
    label_.textAlignment=NSTextAlignmentCenter;
    label_.textColor=RGBCOLOR(197, 197, 197);
    label_.backgroundColor=[UIColor clearColor];
    [wormingLabel addSubview:label_];
    
    
    wormingLabel.hidden = YES;
    
    
    [self.view addSubview:wormingLabel];
    
    
//    button_comment=[[UIButton alloc]initWithFrame:CGRectMake(265, 8, 27/2, 39/2)];
//   // [button_comment setTitle:@"编辑" forState:UIControlStateNormal];
//   // button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
//    [button_comment setBackgroundImage:[UIImage imageNamed:@"ios7_lese@2x.png"] forState:UIControlStateNormal];
//    //   [view_daohang addSubview:button_comment];
//    [button_comment addTarget:self action:@selector(tableViewEdit:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:button_comment];
//    self.navigationItem.rightBarButtonItem=comment_item;
    
    
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, 3, 12, 43/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back.png"] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
//    [back_view addSubview:button_back];
//    back_view.backgroundColor=[UIColor clearColor];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    self.navigationItem.leftBarButtonItem=back_item;
//    
//    button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?35-3+8: 25-3+8, (44-39/2)/2, 27/2, 39/2)];
//    
//    
//    button_comment.tag=26;
//    
//    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
//    button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
//    [button_comment addTarget:self action:@selector(tableViewEdit:) forControlEvents:UIControlEventTouchUpInside];
//    [button_comment setBackgroundImage:[UIImage imageNamed:@"ios7_lese@2x.png"] forState:UIControlStateNormal];
//    
//  UIButton *  rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [rightView addTarget:self action:@selector(tableViewEdit:) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:button_comment];
//    rightView.backgroundColor=[UIColor clearColor];
//    rightView.userInteractionEnabled=YES;
//    
//    
//    
//    
//    
//    UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
//    
//    self.navigationItem.rightBarButtonItem=comment_item;
//    
//    
//    self.navigationItem.title = @"草稿箱";
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;

    self.title = @"草稿箱";
    
    self.rightImageName = @"ios7_lese";

    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeOther];
        
    
    // tab_.backgroundColor=[UIColor redColor];
    
	// Do any additional setup after loading the view.
}

-(void)rightButtonTap:(UIButton *)sender
{
    [self tableViewEdit:sender];
}

- (void)tableViewEdit:(id)sender{
    
    
    
    [tab_ setEditing:!tab_.editing animated:YES];
//    if (tab_.editing==YES) {
//        [button_comment setTitle:@"完成" forState:UIControlStateNormal];
//    }else{
//        [button_comment setTitle:@"编辑" forState:UIControlStateNormal];
//    }
    
    
    [tab_ reloadData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [array_info removeAllObjects];
    
    [MobClick beginEvent:@"DraftBoxViewController"];
     
    if (isWeiBo)
    {
        for (DraftDatabase * data in [DraftDatabase findalldata])
        {
            if ([data.username isEqualToString:theUserName])
            {
                [array_info addObject:data];
            }
        }
        
        //        array_info = [DraftDatabase findallbytheColumns:@"微博"];
        
        if(array_info.count==0)
        {
            wormingLabel.hidden = NO;
        }else
        {
            wormingLabel.hidden = YES;
        }
    }else
    {
        for (DraftDatabase * data in [DraftDatabase findalldata])
        {
            if ([data.username isEqualToString:theUserName])
            {
                [array_info addObject:data];
            }
        }
        
        //        array_info = [DraftDatabase findallbytheColumns:@"论坛"];
        
        if(array_info.count==0)
        {
            wormingLabel.text = @"暂无草稿";
            wormingLabel.hidden = NO;
        }else
        {
            wormingLabel.hidden = YES;
        }
    }
    
    [tab_ reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"DraftBoxViewController"];
    
}


-(void)titleView
{
  /*  之前的代码
   
   UIImageView * iamageView = [[UIImageView alloc] initWithFrame:CGRectMake(106.25,8,215/2,59/2)];
    
   
    iamageView.userInteractionEnabled = YES;
    
    iamageView.backgroundColor = [UIColor clearColor];
    
    
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button3.frame = CGRectMake(107/2+1.5,0,107/2,59/2);
    
    button3.adjustsImageWhenHighlighted = NO;
    
    button3.backgroundColor = [UIColor clearColor];
    
    button3.tag = 100;
    
    [button3 setImage:[UIImage imageNamed:@"论坛选中107_59.png"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"论坛未选中107_59.png"] forState:UIControlStateSelected];
    
    
    [button3 addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button4.frame = CGRectMake(0,0,107/2,59/2);
    
    button4.adjustsImageWhenHighlighted = NO;
    
    button4.backgroundColor = [UIColor clearColor];
    
    button4.tag = 101;
    button4.selected = YES;
    
   
   
    [button4 addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [iamageView addSubview:button4];
    [iamageView addSubview:button3];*/
    
  //  self.navigationItem.titleView = iamageView;
   // self.navigationController.title=@"/,,...";
    self.navigationItem.title = @"草稿箱";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}

//-(UIImageView *)SegmentView
//{
//    UIImageView * iamageView = [[UIImageView alloc] initWithFrame:CGRectMake(106.25,8,215/2,59/2)];
//
//
//    iamageView.userInteractionEnabled = YES;
//
//    iamageView.backgroundColor = [UIColor clearColor];
//
//
//    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    button3.frame = CGRectMake(107/2+1.5,0,107/2,59/2);
//
//    button3.adjustsImageWhenHighlighted = NO;
//
//    button3.backgroundColor = [UIColor clearColor];
//
//    button3.tag = 100;
//
//    [button3 setImage:[UIImage imageNamed:@"论坛选中107_59.png"] forState:UIControlStateNormal];
//    [button3 setImage:[UIImage imageNamed:@"论坛未选中107_59.png"] forState:UIControlStateSelected];
//
//
//    [button3 addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
//
//
//    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    button4.frame = CGRectMake(0,0,107/2,59/2);
//
//    button4.adjustsImageWhenHighlighted = NO;
//
//    button4.backgroundColor = [UIColor clearColor];
//
//    button4.tag = 101;
//    button4.selected = YES;
//
//
//
//    [button4 addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
//
//    [iamageView addSubview:button4];
//    [iamageView addSubview:button3];
//
//    return iamageView;

//}


-(void)doButton:(UIButton *)button
{
    [array_info removeAllObjects];
    switch (button.tag)
    {
        case 100:
        {
            isWeiBo = NO;
            button3.selected = YES;
            button4.selected = NO;
            //            array_info=[DraftDatabase findallbytheColumns:@"论坛"];
            
            
            for (DraftDatabase * data in [DraftDatabase findallbytheColumns:@"论坛"])
            {
                if ([data.username isEqualToString:theUserName])
                {
                    [array_info addObject:data];
                }
            }
            
            
            if(array_info.count==0)
            {
                wormingLabel.text = @"暂无论坛草稿";
                wormingLabel.hidden = NO;
            }else
            {
                wormingLabel.hidden = YES;
            }
            
            [tab_ reloadData];
            NSLog(@"找到了吗 ---  %d",array_info.count);
        }
            break;
        case 101:
        {
            isWeiBo = YES;
            button4.selected = YES;
            button3.selected = NO;
            //            array_info=[DraftDatabase findallbytheColumns:@"微博"];
            
            
            
            for (DraftDatabase * data in [DraftDatabase findallbytheColumns:@"微博"])
            {
                if ([data.username isEqualToString:theUserName])
                {
                    [array_info addObject:data];
                }
            }
            
            
            if(array_info.count==0)
            {
                wormingLabel.text = @"暂无微博草稿";
                wormingLabel.hidden = NO;
            }else
            {
                wormingLabel.hidden = YES;
            }
            
            
            [tab_ reloadData];
            NSLog(@"找到了吗 ---  %d",array_info.count);
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark-segment
-(void)segmentAction:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            NSLog(@"hellowb!");
            for (DraftDatabase * data in [DraftDatabase findallbytheColumns:@"论坛"])
            {
                if ([data.username isEqualToString:theUserName])
                {
                    [array_info addObject:data];
                }
            }
            
            //            array_info=[DraftDatabase findallbytheColumns:@"论坛"];
            break;
        case 1:
            NSLog(@"hellobbs!");
            
            for (DraftDatabase * data in [DraftDatabase findallbytheColumns:@"微博"])
            {
                if ([data.username isEqualToString:theUserName])
                {
                    [array_info addObject:data];
                }
            }
            
            //            array_info=[DraftDatabase findallbytheColumns:@"微博"];
            break;
            
        default:
            break;
    }
    
}
#pragma mark-返回
-(void)backto{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-tableviewdelegate and  datesource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array_info.count;
}
//- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
//    NSLog(@"%sindexPaths===%@",__FUNCTION__,indexPaths);
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    for (UIView *aview in cell.contentView.subviews)
    {
        [aview removeFromSuperview];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    DraftDatabase *base_=[array_info objectAtIndex:indexPath.row];
    NSString *str=[NSString stringWithFormat:@"%@",base_.content];

    
    
    if (str.length>30) {
        str=[str substringToIndex:30];
    }
    NSLog(@"editing===%d",cell.editing);
    
    float heightOfLabel_Content=[personal celllength:300 lablefont:[UIFont systemFontOfSize:16] labeltext:str];
    
    NSLog(@"===height====%@",base_.columns);

    
    UILabel *label_content=[[UILabel alloc]initWithFrame:CGRectMake(10, 8,tab_.editing?200:300, heightOfLabel_Content)];
    label_content.numberOfLines=0;

    label_content.text=str;
    label_content.font=[UIFont systemFontOfSize:16];
    [cell.contentView addSubview:label_content];
    
    UILabel *label_fborbbs=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+heightOfLabel_Content, 40,20 )];
    label_fborbbs.text=base_.columns;
    if ([base_.columns isEqualToString:@"微博"])
    {
        label_fborbbs.text = @"自留地";
    }
    label_fborbbs.backgroundColor=[UIColor clearColor];
    label_fborbbs.font=[UIFont systemFontOfSize:12.5];
    label_fborbbs.textColor=RGBCOLOR(154, 154, 154);
    [cell.contentView addSubview:label_fborbbs];
    
    UILabel *label_time=[[UILabel alloc]initWithFrame:CGRectMake(tab_.editing?100:200, 5+heightOfLabel_Content,110,20 )];
    label_time.text=base_.date;
    label_time.backgroundColor=[UIColor clearColor];
    label_time.font=[UIFont systemFontOfSize:12];
    label_time.textAlignment=NSTextAlignmentRight;
    label_time.textColor=RGBCOLOR(178, 178, 178);
    [cell.contentView addSubview:label_time];
    
    
    UIImageView *imgxian_=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_line594_1.png"]];
    
    imgxian_.center=CGPointMake(tab_.editing?80:160, 5+heightOfLabel_Content+31);
    [cell.contentView addSubview:imgxian_];

    //    DraftBoxView *_drafts=[[DraftBoxView alloc]initWithFrame:CGRectMake(0, 0, 320, 44) contentstring:[NSString stringWithFormat:@"%@",base_.content] datestring:[NSString stringWithFormat:@"%@",base_.date] type:base_.type tag:indexPath.row];
    //
    //    _drafts.delegate=self;
    //  [cell.contentView addSubview:_drafts];
    
//    cell.textLabel.text=[NSString stringWithFormat:@"%@",base_.content];
//    cell.textLabel.font=[UIFont systemFontOfSize:16.f];
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",base_.date] ;
//    cell.detailTextLabel.font=[UIFont systemFontOfSize:12];
//    if (tab_.editing==YES) {
//        NSLog(@"正在编辑。。。");
//        cell.imageView.image=nil;
//        [cell.imageView removeFromSuperview];
//    }else{
//
//    }
    
    //新写得
  //  UILabel *labelcontent=[[UILabel alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
//    UISwipeGestureRecognizer* recognizer;
//    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    // 不同的 Recognizer 有不同的实体变数
//    // 例如 SwipeGesture 可以指定方向
//    // 而 TapGesture 則可以指定次數
//    cell.contentView.userInteractionEnabled=YES;
//    cell.contentView.tag=indexPath.row+100;
//    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//   [cell.contentView addGestureRecognizer:recognizer];
    
    return cell;
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer {
    // 触发手勢事件后，在这里作些事情
    // 底下是刪除手势的方法
   // [self.view removeGestureRecognizer:recognizer];
    UIView *view_content=recognizer.view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIFont *cellFont = [UIFont systemFontOfSize:16];
//    CGSize constraintSize = CGSizeMake(275, MAXFLOAT);
    DraftDatabase *base_=[array_info objectAtIndex:indexPath.row];
    
    NSString *str=[NSString stringWithFormat:@"%@",base_.content];
    float height=0;
    //  CGSize labelSize = [str sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILayoutPriorityRequired];

    if (str.length>30) {
        str=[str substringToIndex:30];
    }
    
    
   height= [personal celllength:300 lablefont:[UIFont systemFontOfSize:16] labeltext:str]+37;
    NSLog(@"===height====%f",height-37);

    return height;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 10)
    {
        return UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
    }
    else if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        //删除一条条目时，更新numberOfRowsInSection
        
        DraftDatabase *drafts=[array_info objectAtIndex:indexPath.row];
        [DraftDatabase deleteStudentBythecontent:drafts.content];
        [array_info removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationBottom];
    }
}
-(void)deletebystring_content:(NSNotification*)string_content{
    
    
    
    [DraftDatabase deleteStudentBythecontent:(NSString *)string_content.object];

        [self doButton:isWeiBo? button3:button4];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DraftDatabase *data_=[array_info objectAtIndex:indexPath.row];
    
    NSLog(@"=======data.type==%@",data_.type);
    
    if ([data_.type isEqualToString:@"发帖"])
    {
        commrntbbdViewController *_fatie=[[commrntbbdViewController alloc]init];
        _fatie.title_string=@"发帖";
        _fatie.string_fid=data_.fabiaogid;
        _fatie.string_content=data_.content;
        _fatie.string_subject=data_.title;
        _fatie.string_distinguish=@"发帖";

        _fatie.allImageUrl = data_.image;
        
        

        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
        

        for (int i = 0;i < ImageArray.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
            
            if ([imgurl isEqualToString:@""]) {
                [self presentModalViewController:_fatie animated:YES];
                
            }else{
                
                
                _fatie.myAllimgUrl=ImageArray;
                NSLog(@"_fatie.myAllimg=====%@",_fatie.myAllimgUrl);
                if (i == ImageArray.count-1){
                    
                    
                    
            [self presentModalViewController:_fatie animated:YES];

                }

            }
            }
        
        
        NSLog(@"回到发帖界面");
    }else if([data_.type isEqualToString:@"回帖"])
    {
        DraftDatabase *data_=[array_info objectAtIndex:indexPath.row];
        
        commrntbbdViewController *_comment=[[commrntbbdViewController alloc]init];
        _comment.title_string=@"回帖";
        _comment.string_distinguish=@"回帖";
        _comment.string_fid=data_.huifubbsfid;
        _comment.string_tid=data_.huifubbsid;
        _comment.string_content=data_.content;
        _comment.string_subject=data_.title;
        
        
        _comment.allImageUrl = data_.image;
        
        
        
    
        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
        
        for (int i = 0;i < ImageArray.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
            
            if ([imgurl isEqualToString:@""]) {
                [self presentModalViewController:_comment animated:YES];
                
            }else{
                
                
                _comment.myAllimgUrl=ImageArray;
                NSLog(@"_fatie.myAllimg=====%@",_comment.myAllimgUrl);
                if (i == ImageArray.count-1){
                    
                    
                    
                    [self presentModalViewController:_comment animated:YES];
                    
                }
                
            }
        }
      
        
        NSLog(@"回到回帖界面");
    }
    
    else if([data_.type isEqualToString:@"回复主题"])
    {
        NSLog(@"=======data.type==%@",data_.type);

        DraftDatabase *data_=[array_info objectAtIndex:indexPath.row];

        commrntbbdViewController *_comment=[[commrntbbdViewController alloc]init];
        _comment.title_string=[NSString stringWithFormat:@"回帖"];
        _comment.string_distinguish=@"回复主题";
        _comment.string_fid=data_.huifubbsfid;
        _comment.string_tid=data_.huifubbsid;
        _comment.string_content=data_.content;
        _comment.string_subject=data_.title;
        _comment.string_pid=data_.weiboid;
        _comment.string_floor=data_.fabiaogid;

        _comment.allImageUrl = data_.image;


        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
        
        for (int i = 0;i < ImageArray.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
            
            if ([imgurl isEqualToString:@""]) {
                [self presentModalViewController:_comment animated:YES];
                
            }else{
                
                
                _comment.myAllimgUrl=ImageArray;
                NSLog(@"_fatie.myAllimg=====%@",_comment.myAllimgUrl);
                if (i == ImageArray.count-1){
                    
                    
                    
                    [self presentModalViewController:_comment animated:YES];
                    
                }
                
            }
        }
        
          
    }
    
    
    else if([data_.type isEqualToString:@"发微博"])
    {
        WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
        
        writeBlogView.theText = data_.content;
        
        
        writeBlogView.allImageUrl = data_.image;
        
        writeBlogView.tid = data_.fabiaogid;
        writeBlogView.rid = data_.huifubbsid;
        writeBlogView.username = data_.username;
        
            
        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
        
        for (int i = 0;i < ImageArray.count;i++)
        {
            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
            
            if ([imgurl isEqualToString:@""]) {
                
                [self presentViewController:writeBlogView animated:YES completion:NULL];
                
            }else{
                
                
                writeBlogView.myAllimgUrl=ImageArray;
                NSLog(@"_fatie.myAllimg=====%@",writeBlogView.myAllimgUrl);
                if (i == ImageArray.count-1){
                    
                    [self presentViewController:writeBlogView animated:YES completion:NULL];
                    
                }
                
            }
        
        

    
            
        }
    }else if([data_.type isEqualToString:@"微博评论"])
    {
        NewWeiBoCommentViewController * comment = [[NewWeiBoCommentViewController alloc] init];
        
        
        comment.theText = data_.content;
        
        comment.tid = data_.weiboid;
        
        comment.rid = data_.fabiaogid;
        
        comment.theTitle = data_.title;
        
        comment.username = data_.huifubbsid;
        
        comment.zhuanfa = data_.huifubbsfid;
        
        [self presentModalViewController:comment animated:YES];
        
        
        
    }else if([data_.type isEqualToString:@"微博转发"])
    {
        ForwardingViewController * forward = [[ForwardingViewController alloc] init];
        
        forward.theText = data_.content;
        
        forward.tid = data_.weiboid;
        
        forward.rid = data_.fabiaogid;
        
        forward.username = data_.image;
        
        forward.totid = data_.huifubbsid;
        
        forward.theTitle = data_.huifubbsfid;
        
        forward.zhuanfa = data_.title;
        
        
        [self presentModalViewController:forward animated:YES];
        
        
    }
//    if ([data_.type isEqualToString:@"发帖"])
//    {
//        commrntbbdViewController *_fatie=[[commrntbbdViewController alloc]init];
//        _fatie.title_string=@"发帖";
//        _fatie.string_fid=data_.fabiaogid;
//        _fatie.string_content=data_.content;
//        _fatie.string_subject=data_.title;
//        
//        _fatie.allImageUrl = data_.image;
//        
//        
//        
//        NSMutableArray * allImageArray = [[NSMutableArray alloc] init];
//        NSMutableArray * allass = [[NSMutableArray alloc] init];
//        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
//        
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        for (int i = 0;i < ImageArray.count;i++)
//        {
//            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
//            
//            
//            NSURL *referenceURL = [NSURL URLWithString:imgurl];
//            
//            __block UIImage *returnValue = nil;
//            [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
//             {
//                 returnValue = [UIImage imageWithCGImage:[asset thumbnail]]; //Retain Added
//                 
//                 [allImageArray addObject:returnValue];
//                 [allass addObject:imgurl];
//                 
//                 if (i == ImageArray.count-1)
//                 {
//                     _fatie.allImageArray1 = allImageArray;
//                     
//                     _fatie.allAssesters1 = allass;
//                     
//                     [self presentModalViewController:_fatie animated:YES];
//                 }
//                 
//                 
//             } failureBlock:^(NSError *error) {
//                 // error handling
//                 [self presentModalViewController:_fatie animated:YES];
//             }];
//        }
//        
//        
//        NSLog(@"回到发帖界面");
//    }else if([data_.type isEqualToString:@"回帖"])
//    {
//        DraftDatabase *data_=[array_info objectAtIndex:indexPath.row];
//        
//        commrntbbdViewController *_comment=[[commrntbbdViewController alloc]init];
//        _comment.title_string=@"回帖";
//        _comment.string_fid=data_.huifubbsfid;
//        _comment.string_tid=data_.huifubbsid;
//        _comment.string_content=data_.content;
//        _comment.string_subject=data_.title;
//        
//        
//        _comment.allImageUrl = data_.image;
//        
//        
//        
//        NSMutableArray * allImageArray = [[NSMutableArray alloc] init];
//        NSMutableArray * allass = [[NSMutableArray alloc] init];
//        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
//        
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        for (int i = 0;i < ImageArray.count;i++)
//        {
//            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
//            NSURL *referenceURL = [NSURL URLWithString:imgurl];
//            
//            __block UIImage *returnValue = nil;
//            [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
//             {
//                 returnValue = [UIImage imageWithCGImage:[asset thumbnail]]; //Retain Added
//                 
//                 [allImageArray addObject:returnValue];
//                 [allass addObject:imgurl];
//                 
//                 if (i == ImageArray.count-1)
//                 {
//                     _comment.allImageArray1 = allImageArray;
//                     
//                     _comment.allAssesters1 = allass;
//                     
//                     [self presentModalViewController:_comment animated:YES];
//                 }
//             } failureBlock:^(NSError *error) {
//                 // error handling
//                 [self presentModalViewController:_comment animated:YES];
//             }];
//        }
//        
//        NSLog(@"回到回帖界面");
//    }
//    else if([data_.type isEqualToString:@"回复主题"])
//    {
//        NSLog(@"=======data.type==%@",data_.type);
//
//        DraftDatabase *data_=[array_info objectAtIndex:indexPath.row];
//        
//        commrntbbdViewController *_comment=[[commrntbbdViewController alloc]init];
//        _comment.title_string=data_.type;
//        _comment.string_fid=data_.huifubbsfid;
//        _comment.string_tid=data_.huifubbsid;
//        _comment.string_content=data_.content;
//        _comment.string_subject=data_.title;
//        _comment.string_pid=data_.weiboid;
//        _comment.string_floor=data_.fabiaogid;
//        
//        _comment.allImageUrl = data_.image;
//        
//        
//        
//        NSMutableArray * allImageArray = [[NSMutableArray alloc] init];
//        NSMutableArray * allass = [[NSMutableArray alloc] init];
//        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
//        
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        for (int i = 0;i < ImageArray.count;i++)
//        {
//            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
//            
//            if ([imgurl isEqualToString:@""]) {
//                [self presentModalViewController:_comment animated:YES];
//
//            }else{
//                NSURL *referenceURL = [NSURL URLWithString:imgurl];
//                
//                __block UIImage *returnValue = nil;
//                [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
//                 {
//                     returnValue = [UIImage imageWithCGImage:[asset thumbnail]]; //Retain Added
//                     
//                     [allImageArray addObject:returnValue];
//                     [allass addObject:imgurl];
//                     
//                     if (i == ImageArray.count-1)
//                     {
//                         _comment.allImageArray1 = allImageArray;
//                         
//                         _comment.allAssesters1 = allass;
//                         
//                         [self presentModalViewController:_comment animated:YES];
//                     }
//                 } failureBlock:^(NSError *error) {
//                     // error handling
//                     [self presentModalViewController:_comment animated:YES];
//                 }];
//            }
//            
//            }
//          
//    }
//
//    
//    
//    
//    else if([data_.type isEqualToString:@"发微博"])
//    {
//        WriteBlogViewController * writeBlogView = [[WriteBlogViewController alloc] init];
//        
//        writeBlogView.theText = data_.content;
//        
//        
//        writeBlogView.allImageUrl = data_.image;
//        
//        writeBlogView.tid = data_.fabiaogid;
//        writeBlogView.rid = data_.huifubbsid;
//        writeBlogView.username = data_.username;
//        
//        
//        NSMutableArray * allImageArray = [[NSMutableArray alloc] init];
//        NSMutableArray * allass = [[NSMutableArray alloc] init];
//        
//        NSArray * ImageArray = [data_.image componentsSeparatedByString:@"||"];
//              ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        for (int i = 0;i < ImageArray.count;i++)
//        {
//            NSLog(@"heihei===%@",ImageArray);
//            
//            NSString *imgurl=[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:i]];
//            if ([imgurl isEqualToString:@""]) {
//                [self presentModalViewController:writeBlogView animated:YES];
//
//            }else{
//                NSURL *referenceURL = [NSURL URLWithString:imgurl];
//                
//                __block UIImage *returnValue = nil;
//                [library assetForURL:referenceURL resultBlock:^(ALAsset *asset)
//                 {
//                     returnValue = [UIImage imageWithCGImage:[asset thumbnail]]; //Retain Added
//                     
//                     [allImageArray addObject:returnValue];
//                     [allass addObject:imgurl];
//                     
//                     if (i == ImageArray.count-1)
//                     {
//                         writeBlogView.allImageArray1 = allImageArray;
//                         
//                         writeBlogView.allAssesters1 = allass;
//                         
//                         [self presentModalViewController:writeBlogView animated:YES];
//                     }
//                     
//                     
//                 } failureBlock:^(NSError *error) {
//                     // error handling
//                     [self presentModalViewController:writeBlogView animated:YES];
//                 }];
//
//            }
//            
//            
//                        
//
//        }
//    }else if([data_.type isEqualToString:@"微博评论"])
//    {
//        CommentViewController * comment = [[CommentViewController alloc] init];
//        
//        comment.theText = data_.content;
//        
//        comment.tid = data_.weiboid;
//        
//        comment.rid = data_.fabiaogid;
//        
//        comment.theTitle = data_.title;
//        
//        comment.username = data_.huifubbsid;
//        
//        comment.zhuanfa = data_.huifubbsfid;
//        
//        [self presentModalViewController:comment animated:YES];
//        
//        
//        
//    }else if([data_.type isEqualToString:@"微博转发"])
//    {
//        ForwardingViewController * forward = [[ForwardingViewController alloc] init];
//        
//        forward.theText = data_.content;
//        
//        forward.tid = data_.weiboid;
//        
//        forward.rid = data_.fabiaogid;
//        
//        forward.username = data_.image;
//        
//        forward.totid = data_.huifubbsid;
//        
//        forward.theTitle = data_.huifubbsfid;
//        
//        forward.zhuanfa = data_.title;
//        
//        
//        [self presentModalViewController:forward animated:YES];
//        
//        
//    }
}
#pragma mark-draftboxdelegate

-(void)resendrow:(int)numberofrow type:(NSString *)sendtype{
    NSLog(@"%d",numberofrow);
    NSLog(@"sentype=%@",sendtype);
    NSLog(@"走你。。。。");
    indexpathofrow=numberofrow;
    
    DraftDatabase *_base=[array_info objectAtIndex:numberofrow];
    _tool=[[downloadtool alloc]init];
    NSLog(@"111sending...");
    
    if ([_base.type isEqualToString:@"发帖"]) {
        if (_base.title.length==0) {
            UIAlertView *alertview_=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"帖子标题不能为空" delegate:nil cancelButtonTitle:@"请输入标题" otherButtonTitles:nil, nil];
            [alertview_ show];
        }else{
            [_tool setUrl_string:[NSString stringWithFormat: @"http://bbs.fblife.com/bbsapinew/postthread.php?fid=%@&&subject=%@&message=%@&formattype=json&authcode=%@",_base.fabiaogid,[_base.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_base.content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
        }
        
    }else if ([_base.type isEqualToString:@"回帖"]) {
        [_tool setUrl_string:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/postreply.php?fid=%@&tid=%@&subject=%@&message=%@&formattype=json&authcode=%@",_base.huifubbsfid,_base.huifubbsid,[_base.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_base.content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]]];
    }
    [_tool start];
    //需要传的有fid,tid,biaoti,neirong,
    _tool.delegate=self;
    
    
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        NSLog(@"fabudic==%@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue]==0) {
            NSLog(@"diccomment==%@",dic);
            
            DraftDatabase *drafts=[array_info objectAtIndex:indexpathofrow];
            [DraftDatabase deleteStudentBythecontent:drafts.content];
            [array_info removeObjectAtIndex:indexpathofrow];
            [tab_ reloadData];
            
        }else{
            NSString *str=[NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsinfo"]];
            UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert_ show];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
-(void)downloadtoolError{
    NSLog(@"网络不稳定");
    
}
-(void)dele:(UIButton *)sender type:(NSString *)sendtype{
    //    NSLog(@"%d",sender.tag);
    //    NSLog(@"sentype=%@",sendtype);
    //    NSLog(@"走你。。。。");
}
@end
