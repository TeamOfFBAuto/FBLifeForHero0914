//
//  ShoucangViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-10.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//


#import "newsdetailViewController.h"

#import "bbsdetailViewController.h"

#import "BBSfenduiViewController.h"

#import "QBShowImagesScrollView.h"


#import "SzkLoadData.h"

#import "ShoucangViewController.h"

#import "NewshoucangTableViewCell.h"



@interface ShoucangViewController ()

@end

@implementation ShoucangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;

    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -15:5, 0
                                                                     , 44, 44)];
    
    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    [button_back setImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        //iOS 5 new UINavigationBar custom background
//        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//    }
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -5:5, 3, 12, 43/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
//    [back_view addSubview:button_back];
//    back_view.backgroundColor=[UIColor clearColor];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    self.navigationItem.leftBarButtonItem=back_item;
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    newsScrow=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64)];
    newsScrow.contentSize=CGSizeMake(320*4, 0);
    newsScrow.pagingEnabled=YES;
    newsScrow.delegate=self;
    newsScrow.showsHorizontalScrollIndicator=NO;
    newsScrow.showsVerticalScrollIndicator=NO;
    newsScrow.backgroundColor=[UIColor whiteColor];
    newsScrow.scrollEnabled = NO;
    
    [self.view addSubview:newsScrow];
    
    for (int i=0; i<4; i++) {
        
        FinalshoucangView *mytesttab=[[FinalshoucangView alloc]initWithFrame:CGRectMake(320*i, 0, 320, iPhone5?568-64:480-64) Type:i];
        mytesttab.tag=i+800;
        mytesttab.delegate=self;
        [newsScrow addSubview:mytesttab];
        mytesttab.backgroundColor=[UIColor redColor];
        
        
        
    }
    
    
    _weibo_seg = [[ShoucangSeg alloc] initWithFrame:CGRectMake(0,0,240,44)];
    
    UIView *daohangview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 44)];
    [daohangview addSubview:_weibo_seg];
    
    _weibo_seg.delegate = self;
    
    _weibo_seg.backgroundColor = [UIColor clearColor];
    
    [_weibo_seg setAllViewsWith:[NSArray arrayWithObjects:@"新闻",@"帖子",@"版块",@"图集",nil] index:0];
    
    self.navigationItem.titleView = daohangview;

    
    
    // Do any additional setup after loading the view.
}


-(void)sClickWeiBoCustomSegmentWithIndex:(int)index{
    
  
    
    NSLog(@"xxxsindex===%d",index);
    
    
    [UIView animateWithDuration:0.3 animations:^{
        newsScrow.contentOffset=CGPointMake(320*index, 0);
    } completion:^(BOOL finished) {
        
    }];



}

-(void)sWeiBoViewLogIn{
    
   LogInViewController *   logIn = [LogInViewController sharedManager];
    
    
    [self presentViewController:logIn animated:YES completion:NULL];

}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
   if(scrollView ==newsScrow)
    {
        int   number=scrollView.contentOffset.x/320;
        
        NSLog(@"number========%d",number);
        
        [_weibo_seg MyButtonStateWithIndex:number];
        
    }

}


-(void)loadView{
    
    [super loadView];
    
    
    
}

-(void)backto{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
