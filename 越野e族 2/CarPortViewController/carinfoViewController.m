//
//  carinfoViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-10-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "carinfoViewController.h"
#define GRAYZI RGBCOLOR(89, 89, 89)
#define GRAYXIAN   RGBCOLOR(223, 223, 223)
@interface carinfoViewController ()

@end

@implementation carinfoViewController
@synthesize string_cid,string_name;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"carinfoViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"carinfoViewController"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
  
    
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -15:5, 0, 44, 44)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    [button_back setImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE]forState:UIControlStateNormal];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
        
    }

    
   // UILabel *labelbiaoti=[[UILabel alloc]initWithFrame:CGRectMake(120, 8, 80, 28)];
    while ([self.string_name rangeOfString:@"（已停产）"].length){
        self.string_name = [self.string_name stringByReplacingOccurrencesOfString:@"（已停产）" withString:@""];

    }
    
    
    
  //  self.navigationItem.title = self.string_name;
    
    
    
     UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,44)];
    topView.backgroundColor = [UIColor clearColor];
    //    //导航栏上的label
 UILabel   *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_MACRO_NAME? -40:0, 0, 180, 44)];
    titleLabel.text = self.string_name;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font= [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    [topView addSubview:titleLabel];
    //
    //
    //
    //    UIButton *button_author=[[UIButton alloc]initWithFrame:CGRectMake(120, (44-35/2)/2, 70/2, 35/2)];
    //    button_author.tag=1314;
    //    [button_author setBackgroundImage:[UIImage imageNamed:@"ios7_authorunselect70_37.png"] forState:UIControlStateNormal];
    //    [button_author setTitle:@"楼主" forState:UIControlStateNormal];
    //    button_author.titleLabel.font=[UIFont systemFontOfSize:12];
    //    [button_author setTitleColor:RGBCOLOR(108, 108, 108) forState:UIControlStateNormal];
    //    [button_author setTitleColor:RGBCOLOR(108, 108, 108) forState:UIControlStateSelected];
    //    [button_author setTitleColor:RGBCOLOR(108, 108, 108) forState:UIControlStateHighlighted];
    //
    //    [topView addSubview:button_author];
    //    [button_author addTarget:self action:@selector(Doauthor:) forControlEvents:UIControlEventTouchUpInside];
    //    
    //
    //
        self.navigationItem.titleView = topView;
    
    
    
    
    
//    UIView *titleV=[[UIView alloc]initWithFrame:<#(CGRect)#>];
    
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;

    
//    labelbiaoti.font= [UIFont fontWithName:@"Helvetica" size:20];
//    //[view_daohang addSubview:labelbiaoti];
//    labelbiaoti.backgroundColor=[UIColor clearColor];
//    labelbiaoti.textColor=[UIColor blackColor];
//    self.navigationItem.titleView=labelbiaoti;

   // self.navigationItem.title=self.string_name;
    
    
    tab_ =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-20-44:480-20-44) style:UITableViewStylePlain];
    tab_.delegate=self;
    tab_.dataSource=self;
    tab_.separatorColor=[UIColor clearColor];
    header_array=[[NSMutableArray alloc]init];
    row_array=[[NSMutableArray alloc]init];
    [self.view addSubview:tab_];
    
    
    
    _carinfomodel=[[CarInfoModel alloc]init];
    [_carinfomodel startloadcarinfoWithcid:self.string_cid];
    _carinfomodel.delegate=self;
    
	// Do any additional setup after loading the view.
}
-(void)finishloadCarinfowitharray:(NSArray *)carinfoarray{
    NSLog(@"carinfoarray===%@",carinfoarray);
    allinfo=[NSArray arrayWithArray:carinfoarray];
    
    
    
    for (int i=0; i<allinfo.count; i++) {
//        NSDictionary *dic_header=[allinfo objectAtIndex:i];
//        NSArray *array_hea=[dic_header objectForKey:@"desc"];
//        NSString *string_header=[NSString stringWithFormat:@"%@",[array_hea objectAtIndex:0]];
//        [header_array addObject:string_header];
//        
//        NSArray *array=[dic_header allValues];
//        NSMutableArray *array_mu=[[NSMutableArray alloc]init];
//        for (NSArray * arrayyyyyy in array) {
//            
//            if (arrayyyyyy.count==2) {
//                NSString *stringte=[NSString stringWithFormat:@"%@",[arrayyyyyy objectAtIndex:1]];
//                
//                if (![stringte rangeOfString:@"id"].length) {
//                    [array_mu addObject:arrayyyyyy];
//                }
//            }
//        }
//        
//        [row_array addObject:array_mu];
        
        NSArray *arry_header=[allinfo objectAtIndex:i];
              NSMutableArray *array_mu=[[NSMutableArray alloc]init];

        for (NSArray *arrtest in arry_header) {
            
            
            NSLog(@"arrtest===%@",arrtest);
            if (arrtest.count==2) {
                
  
                   NSString *string_header=[NSString stringWithFormat:@"%@",[arrtest objectAtIndex:0]];
                
                
                     [header_array addObject:string_header];
            }
            
            if (arrtest.count==3) {
                
                
                [array_mu addObject:arrtest];
            }
        }
        
        [row_array addObject:array_mu];
        
        
    }
    
    
    
    NSLog(@"rowarray==%@",row_array);
    
    
    
    
    NSLog(@"...stringheader===%@",header_array);
    
    [tab_ reloadData];
}
-(void)backto
{
    [_carinfomodel stop];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-tableviewdelegateanddatesource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[row_array  objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return header_array.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return (NSString *)[header_array objectAtIndex:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string_cell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string_cell];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string_cell];
    }
    for (UIView *aview in cell.contentView.subviews)
    {
        [aview removeFromSuperview];
    }
    
    NSArray *twovalue=[[row_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    @try
    {
        UILabel *keylabel=[[UILabel alloc]initWithFrame:CGRectMake(13, 5, 140, 20)];
        keylabel.font=[UIFont systemFontOfSize:14];
        keylabel.backgroundColor=[UIColor clearColor];
        keylabel.textAlignment=UITextAlignmentLeft;
        keylabel.textColor=GRAYZI;
        keylabel.text=[NSString stringWithFormat:@"%@",[twovalue objectAtIndex:1]];
        [cell.contentView addSubview:keylabel];
        
        
        UILabel *valuelabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 5, 140, 20)];
        valuelabel.font=[UIFont systemFontOfSize:14];
        valuelabel.backgroundColor=[UIColor clearColor];
        valuelabel.textAlignment=UITextAlignmentLeft;
        valuelabel.textColor=[UIColor blackColor];
        NSString *string_text=[NSString stringWithFormat:@"%@",[twovalue objectAtIndex:0]];
        [cell.contentView addSubview:valuelabel];
        if ([string_text isEqualToString:@"1"]) {
            string_text=@"●";
        }
        if ([string_text isEqualToString:@"0"]) {
            string_text=@"-";
        }

        if (string_text.length>15) {
            string_text=[string_text substringToIndex:15];
        }
        if ([keylabel.text isEqualToString:@"最后修改时间"]) {
            string_text=[personal timchange:string_text];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        valuelabel.text=string_text;
        
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 29, 320, 1)];
        img.image=[UIImage imageNamed:@"line-2.png"];
        [cell.contentView addSubview:img];

    }
    @catch (NSException *exception) {
        NSLog(@"........");
    }
    @finally {
        
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view_header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 28)];
    view_header.backgroundColor=RGBCOLOR(227, 227, 227);
    
    
    UILabel *labelheader=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 28)];
    NSString *string_header=[NSString stringWithFormat:@"%@",[header_array objectAtIndex:section]];
    if ([string_header isEqualToString:@"基本参数"]) {
        string_header=[NSString stringWithFormat:@"基本参数配置"];
    }
    labelheader.text=[NSString stringWithFormat:@"   %@     ",string_header ];
    labelheader.backgroundColor=RGBCOLOR(227, 227, 227);
    labelheader.font=[UIFont systemFontOfSize:13];
    labelheader.textColor=[UIColor blackColor];
    [view_header addSubview:labelheader];
    
    UILabel *label_point=[[UILabel alloc]initWithFrame:CGRectMake(180, 0, 15, 28)];
    label_point.text=[NSString stringWithFormat:@"● "];
    label_point.backgroundColor=RGBCOLOR(227, 227, 227);
    label_point.font=[UIFont systemFontOfSize:14];
    label_point.textColor=[UIColor blackColor];
    [view_header addSubview:label_point];
    
    UILabel *label_biaopei=[[UILabel alloc]initWithFrame:CGRectMake(200, 0, 320, 28)];
    label_biaopei.text=[NSString stringWithFormat:@"标配 - 无"];
    label_biaopei.backgroundColor=RGBCOLOR(227, 227, 227);
    label_biaopei.font=[UIFont systemFontOfSize:13];
    label_biaopei.textColor=[UIColor blackColor];
    [view_header addSubview:label_biaopei];

    
    
    return view_header;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
