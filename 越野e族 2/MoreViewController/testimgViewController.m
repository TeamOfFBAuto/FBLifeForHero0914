//
//  testimgViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "testimgViewController.h"

@interface testimgViewController ()

@end

@implementation testimgViewController
@synthesize allImageArray1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"testimgViewController"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"testimgViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *img=[self.allImageArray1 objectAtIndex:0];
    UIImageView *aimg=[[UIImageView alloc]initWithImage:img];
    aimg.center=CGPointMake(160, 240);
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:aimg];
    aimg.backgroundColor=[UIColor redColor];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
