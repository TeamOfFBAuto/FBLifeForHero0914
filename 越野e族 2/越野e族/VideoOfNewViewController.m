//
//  VideoOfNewViewController.m
//  越野e族
//
//  Created by szk on 15/3/8.
//  Copyright (c) 2015年 soulnear. All rights reserved.
//


#define VIDEO_CLASSNAME @"v"

#import "VideoOfNewViewController.h"

#import "UIViewController+MMDrawerController.h"


@interface VideoOfNewViewController ()

@end

@implementation VideoOfNewViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor=[UIColor redColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    
    [self prepairNavigationBar];
    
    [self setMainView];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark--主view

-(void)setMainView{

    newsTableview *mytesttab=[[newsTableview alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-40)];
    mytesttab.tag=1210;
    mytesttab.delegate=self;
    [self.view addSubview:mytesttab];

    [self prepairVideoData];


}

#pragma mark--获取video数据
-(void)prepairVideoData{

    rootnewsModel *model=[[rootnewsModel alloc]init];
    [model startloadcommentsdatawithtag:1210 thetype:VIDEO_CLASSNAME];
    model.delegate=self;

}




#pragma mark-新的请求新闻和推荐新闻

-(void)loadmorewithtage:(int)_tag page:(int)_page{
    
    
    
    rootnewsModel *model=[[rootnewsModel alloc]init];
    [model loadmorewithtag:_tag thetype:VIDEO_CLASSNAME page:_page];
    model.delegate=self;
    NSLog(@"11111111111111111111tag===%d",_tag);
    
}

-(void)refreshmydatawithtag:(int)tag{
    
    
    rootnewsModel *model=[[rootnewsModel alloc]init];
    [model startloadcommentsdatawithtag:tag thetype:VIDEO_CLASSNAME];
    model.delegate=self;
}

-(void)doneloadmoremornormal:(NSDictionary*)_morenormaldic tag:(int)_tag{
    
    newsTableview *mytab=(newsTableview*)[self.view viewWithTag:_tag];
    
    [mytab newstabreceivemorenormaldic:_morenormaldic];
}
-(void)successloadcommentdic:(NSDictionary *)_comdic mormaldic:(NSDictionary *)_nordic tag:(int)_tag{
    
    NSLog(@"推荐新闻的dic===%@普通新闻的dic=====%@=======%d",_comdic,_nordic,_tag);
    newsTableview *mytab=(newsTableview*)[self.view viewWithTag:_tag];
    [mytab newstabreceivecommentdic:_comdic normaldic:_nordic];
    
    
}







#pragma mark-准备uinavigationbar

-(void)prepairNavigationBar{
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7evaDEVICE_WIDTH_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -2:5, (44-33/2)/2, 36/2, 33/2)];
    
    [button_back addTarget:self action:@selector(leftDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [button_back setImage: [UIImage imageNamed:@"homenewz36_33.png"] forState:UIControlStateNormal];
    
    button_back.backgroundColor = [UIColor clearColor];
    
    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [back_view addSubview:button_back];
    back_view.backgroundColor=[UIColor clearColor];
    [back_view addTarget:self action:@selector(leftDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
    self.navigationItem.leftBarButtonItem=back_item;
    
    
    
    //[UIImage imageNamed:@"fblifelogo102_38_.png"];
    
    self.navigationItem.title = @"视频";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //右边
    
    UIButton *  button_comment=[[UIButton alloc]initWithFrame:CGRectMake(MY_MACRO_NAME?37: 25, (44-34/2)/2, 37/2, 34/2)];
    
    
    
    //[button_comment setTitle:@"评论" forState:UIControlStateNormal];
    
        button_comment.titleLabel.font=[UIFont systemFontOfSize:14];
        [button_comment addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [button_comment setBackgroundImage:[UIImage imageNamed:@"menewz37_36.png"] forState:UIControlStateNormal];
        
        UIButton *  rightView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        [rightView addTarget:self action:@selector(rightDrawerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:button_comment];
        rightView.backgroundColor=[UIColor clearColor];
        
        
        
        
        UIBarButtonItem *comment_item=[[UIBarButtonItem alloc]initWithCustomView:rightView];
        
        self.navigationItem.rightBarButtonItem=comment_item;
        
    
    
    
    
    
    
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress{
    
    
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
      
}

-(void)rightDrawerButtonPress{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
