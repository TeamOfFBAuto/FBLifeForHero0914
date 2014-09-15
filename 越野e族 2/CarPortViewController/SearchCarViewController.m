//
//  SearchCarViewController.m
//  FbLife
//
//  Created by soulnear on 13-10-11.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SearchCarViewController.h"

@interface SearchCarViewController ()

@end

@implementation SearchCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"SearchCarViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"SearchCarViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end



























