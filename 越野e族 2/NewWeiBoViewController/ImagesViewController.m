//
//  ImagesViewController.m
//  FbLife
//
//  Created by soulnear on 13-3-25.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "ImagesViewController.h"
#import "ImagesCell.h"
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"

@interface ImagesViewController ()
{
    NSString * _name;
    
}

@end

@implementation ImagesViewController
@synthesize myTableView = _myTableView;
@synthesize dataArray = _dataArray;
@synthesize photos = _photos;
@synthesize tid = _tid;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)backH
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



-(void)initHttpRequest
{
    
    [self Alertloading];
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString* fullURL = [NSString stringWithFormat:URL_HUALANG,authkey,self.tid];
    NSLog(@"请求的url -=-=  %@",fullURL);
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    request.delegate = self;
    
    [request setFailedBlock:^{
        
    }];
    
    
    [request setCompletionBlock:^{
        @try {
            [hud hide];
            NSDictionary * dictionary = [_requset.responseData objectFromJSONData];
            NSLog(@"图片信息 -=-=-  %@",dictionary);
            NSString *errcode = [dictionary objectForKey:@"errcode"];
            if ([@"0" isEqualToString:errcode])
            {
                NSDictionary* albuminfo = [dictionary objectForKey:@"albuminfo"];
                
                NSDictionary* albuminfo2 = [albuminfo objectForKey:@"albuminfo"];
                
                _name= [albuminfo2 objectForKey:@"name"];
                
                NSArray* userinfo = [albuminfo objectForKey:@"picinfo"];
                
                if ([userinfo isEqual:[NSNull null]])
                {
                    //如果没有微博的话
                    NSLog(@"------------本画廊没有图片---------------");
                }else
                {
                    NSInteger count = [userinfo count];
                    for(int i = 0;i<count;i++)
                    {
                        if([userinfo objectAtIndex:i])
                        {
                            [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[userinfo objectAtIndex:i] objectForKey:@"bigphoto"]]]];//大图
                            [self.dataArray addObject:[[userinfo objectAtIndex:i] objectForKey:@"photo"]];//小图
                        }
                    }
                    [_myTableView reloadData];
                    //                NavTitle.title = _name;
                    self.title = _name;
                }
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }];
    
    [request startAsynchronous];
}



-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"ImagesViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"ImagesViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(242,242,242);
    
    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
//    {
//        //iOS 5 new UINavigationBar custom background
//        
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:MY_MACRO_NAME?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
//    }
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = MY_MACRO_NAME?-5:5;
//    
//    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(0,0,12,21.5)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
//    self.navigationItem.leftBarButtonItems=@[negativeSpacer,back_item];
    
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    
    
    
    self.photos = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    
    [self initHttpRequest];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,iPhone5?568-20-44:460-44) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 79.2;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor = RGBCOLOR(242,242,242);
    [self.view addSubview:_myTableView];
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
    
}
-(void)Alertloading{
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    // [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"popss0" ofType:@"wav"]];
    [hud setCaption:@"正在加载"];
    [hud setActivity:YES];
    //[hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num = self.dataArray.count%4?self.dataArray.count/4+1:self.dataArray.count/4;
    return num;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    
    ImagesCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[ImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.delegate = self;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    [cell setAllView];
    
    
    if (indexPath.row*4 < self.dataArray.count)
    {
        [cell.imageView1 loadImageFromURL:[self.dataArray objectAtIndex:indexPath.row*4] withPlaceholdImage:[personal getImageWithName:@"photo_default"]];
    }
    
    if (indexPath.row*4+1 < self.dataArray.count)
    {
        [cell.imageView2 loadImageFromURL:[self.dataArray objectAtIndex:indexPath.row*4+1] withPlaceholdImage:[personal getImageWithName:@"photo_default"]];
    }
    
    if (indexPath.row*4+2 < self.dataArray.count)
    {
        [cell.imageView3 loadImageFromURL:[self.dataArray objectAtIndex:indexPath.row*4+2] withPlaceholdImage:[personal getImageWithName:@"photo_default"]];
    }
    
    if (indexPath.row*4+3 < self.dataArray.count)
    {
        [cell.imageView4 loadImageFromURL:[self.dataArray objectAtIndex:indexPath.row*4+3] withPlaceholdImage:[personal getImageWithName:@"photo_default"]];
    }
    return cell;
}

-(void)showDetailImage:(UITableViewCell *)cell imageTag:(int)image
{
    NSIndexPath * indexPath = [_myTableView indexPathForCell:cell];
    
    int num = indexPath.row*4+image-1;
    
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    
    [browser setInitialPageIndex:num];
    
    
    //    [self.navigationController pushViewController:browser animated:YES];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self presentViewController:browser animated:YES completion:NULL];
    
}



#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }else
    {
        return nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end










