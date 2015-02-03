//
//  DEMOMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "LeftViewController.h"
#import "ComprehensiveViewController.h"
#import "RightViewController.h"

#import "RootViewController.h"

#import "BBSViewController.h"

#import "NewWeiBoViewController.h"

#import "CarPortViewController.h"

#import "UIViewController+MMDrawerController.h"


#import "AppDelegate.h"

#import "SliderBBSViewController.h"

#import "PicShowViewController.h"

#import "ComprehensiveViewController.h"

//https://itunes.apple.com/us/app/meng-yi-tian-qi/id847338649?ls=1&mt=8
@interface LeftViewController (){
    UIImage *bgbuttonImage;
    
    UINavigationController *_rootNav;
    
    UINavigationController *_bbsNav;

    UINavigationController *_newNav;

    UINavigationController *_carNav;
    
    UINavigationController *_picNav;
    
    


}

@property (nonatomic, strong) UIImageView *blurredImageView;

@end

@implementation LeftViewController

#define IPHONE5_HEIGHT 568
#define IPHONE4_HEIGHT 480
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];


}

- (void)viewDidLoad
{
//   ComprehensiveViewController  *NewMainRootVC=[[ComprehensiveViewController alloc]init];
//    sRootVC.isMain=YES;
//    _rootNav=[[UINavigationController alloc]initWithRootViewController:sRootVC];
//    
    
    
    
    RootViewController *sRootVC=[[RootViewController alloc]init];
    sRootVC.isMain=YES;
    _rootNav=[[UINavigationController alloc]initWithRootViewController:sRootVC];
    
    SliderBBSViewController *ssbbs=[[SliderBBSViewController alloc]init];
    ssbbs.isMain=YES;
    
    
    _bbsNav=[[UINavigationController alloc]initWithRootViewController:ssbbs];

    _newNav=[[UINavigationController alloc]initWithRootViewController:[[NewWeiBoViewController alloc]init]];

    _carNav=[[UINavigationController alloc]initWithRootViewController:[[CarPortViewController alloc]init]];
    
    
    PicShowViewController *showPic=[[PicShowViewController alloc]init];
    showPic.isMain=YES;
    _picNav=[[UINavigationController alloc]initWithRootViewController:showPic];


    
    bgbuttonImage = [UIImage imageNamed:@"shouyes473_100.png"];
    bgbuttonImage = [bgbuttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(7,7, 7, 7)];
    
    self.view.backgroundColor=[UIColor redColor];
    
   [super viewDidLoad];
    _firstVC=[[ComprehensiveViewController alloc]init];
    
    titles = @[@"综合",@"论坛",@"资讯", @"自留地", @"车库", @"图集",@"夜间模式"];
    
    imageArr=@[@"zonghegray50_48.png",@"luntangray48_41.png",@"zixungray47_42.png",@"ziliudigray44_4.png",@"chekugray54_35.png",@"tujigray.png",@"zonghered50_48.png",@"",@"luntanred48_41.png",@"zixunred47_42.png",@"ziliudired44_40.png",@"chekured54_35.png",@"tujired.png",@""];
    
//    UIImage *background   =[UIImage imageNamed:IS_IPHONE_5?@"Mallbackgurand.png":@"Mallbackgurand.png"];
    
    //    CGFloat top = 5; // 顶端盖高度
    //    CGFloat bottom = 20 ; // 底端盖高度
    //    CGFloat left = 20; // 左端盖宽度
    //    CGFloat right = 0; // 右端盖宽度
    //    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    //    // 伸缩后重新赋值
    //    background = [background resizableImageWithCapInsets:insets];
    //
    
    _blurredImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    _blurredImageView.alpha = 1;
    _blurredImageView.backgroundColor=RGBCOLOR(240, 241, 245);
    
    // [_blurredImageView setImageToBlur:background blurRadius:8 completionBlock:nil];
//    _blurredImageView.image=background;
    
    [self.view addSubview:_blurredImageView];
    _blurredImageView.frame=self.view.bounds;
    
    //默认第一个
    currentSelectButtonIndex=0;
    
    for (int i=0; i<titles.count; i++) {
        
        
        UIButton *tabbutton=[[UIButton alloc] initWithFrame:CGRectMake(0,iPhone5? 64+i*70:64+i*60, 300, 50)];
       // [tabbutton setSelected:YES];
        tabbutton.tag=i+100;
        if (i==0) {
            [tabbutton setImage:[UIImage imageNamed:imageArr[6]] forState:UIControlStateNormal];
           // tabbutton.backgroundColor=RGBCOLOR(226, 230, 233);
            
            [tabbutton setBackgroundImage:bgbuttonImage forState:UIControlStateNormal];
            
           
        }else{
            [tabbutton setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
           // tabbutton.backgroundColor=RGBCOLOR(240, 241, 245);

        
        }
        
        [tabbutton setTitle:titles[i] forState:UIControlStateNormal];
        
        [tabbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [tabbutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        
        if (i==3) {
            
            [tabbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
            
            [tabbutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            
        }

        [tabbutton setTitleColor:RGBCOLOR(131, 134, 139) forState:UIControlStateNormal];
        
        [tabbutton addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tabbutton];
        
    }
    
   // [self.view addSubview:self.tableView];
}


-(void)dobutton:(UIButton *)sender{
    UIButton *preButton=(UIButton *)[self.view viewWithTag:currentSelectButtonIndex+100];
    [preButton setBackgroundImage:nil forState:UIControlStateNormal];

    [preButton setImage:[UIImage imageNamed:imageArr[currentSelectButtonIndex]] forState:UIControlStateNormal];
    sender.selected = !sender.selected;
    currentSelectButtonIndex=sender.tag-100;
    [sender setImage:[UIImage imageNamed:imageArr[sender.tag-100+6]] forState:UIControlStateNormal];
    
    [sender setBackgroundImage:bgbuttonImage forState:UIControlStateNormal];

    
    switch (sender.tag) {
        case 100:
        {
            NSLog(@"选择的第%d个button",sender.tag-100);
            
          
            
            [self.mm_drawerController
             setCenterViewController:[self appDelegate].navigationController
             withCloseAnimation:YES
             completion:nil];

        }
            break;
        case 105:
        {
            NSLog(@"选择的第%d个button",sender.tag-100);
            
            
            [self.mm_drawerController
             setCenterViewController:_picNav    withCloseAnimation:YES
             completion:nil];
        }
            break;
            
        case 102:
        {
            NSLog(@"选择的第%d个button",sender.tag-100);
            
            
            [self.mm_drawerController
             setCenterViewController:_rootNav    withCloseAnimation:YES
             completion:nil];
        }
            break;

            
        case 101:
        {
            [self.mm_drawerController
             setCenterViewController:_bbsNav    withCloseAnimation:YES
             completion:nil];


        }
            break;
        case 103:
        {
            NSLog(@"选择的第%d个button",sender.tag-100);
            
            [self.mm_drawerController
             setCenterViewController:_newNav    withCloseAnimation:YES
             completion:nil];
            



        }
            break;
        case 104:
        {
            NSLog(@"选择的第%d个button",sender.tag-100);
            [self.mm_drawerController
             setCenterViewController:_carNav    withCloseAnimation:YES
             completion:nil];
            


        }
            break;
        case 106:///夜间模式
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NightMode" object:[NSString stringWithFormat:@"%d",sender.selected] userInfo:nil];
        }
            break;

            
        default:
            break;
    }


}

-(AppDelegate *)appDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    
//    
//    
//   // return UIStatusBarStyleLightContent;
//}

@end
