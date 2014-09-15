//
//  ChangeAllbbsViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-5-6.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "ChangeAllbbsViewController.h"

@interface ChangeAllbbsViewController ()
@end

@implementation ChangeAllbbsViewController

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
    
    [MobClick beginEvent:@"ChangeAllbbsViewController"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"ChangeAllbbsViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
