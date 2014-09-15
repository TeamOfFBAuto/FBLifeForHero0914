//
//  FansViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-3-6.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "FansViewController.h"

@interface FansViewController ()

@end

@implementation FansViewController

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
    
    [MobClick endEvent:@"FansViewController"];
    
//    CGRect rect = self.navigationController.view.frame;
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        
//        self.navigationController.view.frame = CGRectMake(0,rect.origin.y,rect.size.width,rect.size.height);
//        
//    } completion:^(BOOL finished) {
//        
//    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"FansViewController"];
    
//    CGRect rect = self.navigationController.view.frame;
//        
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.navigationController.view.frame = CGRectMake(320,rect.origin.y,rect.size.width,rect.size.height);
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
}


-(void)setNavigationHiddenWith:(BOOL)isHidden WithBlock:(hiddenNavgationBlock)theBlock
{
    hiddennavigation_block = theBlock;
    
    CGRect rect = self.navigationController.view.frame;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.navigationController.view.frame = CGRectMake(isHidden?320:0,rect.origin.y,rect.size.width,rect.size.height);
        
    } completion:^(BOOL finished)
     {
        hiddennavigation_block();
    }];
}



-(AppDelegate *)getAppDelegate
{
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return appdelegate;
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
