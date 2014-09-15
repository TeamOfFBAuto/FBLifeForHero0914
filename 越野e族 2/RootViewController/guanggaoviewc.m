//
//  guanggaoviewc.m
//  FbLife
//
//  Created by 史忠坤 on 13-4-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "guanggaoviewc.h"

@interface guanggaoviewc ()

@end

@implementation guanggaoviewc

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
    [self showguanggao];
	// Do any additional setup after loading the view.
}
-(void)showguanggao{
    downloadtool *tool_=[[downloadtool alloc]init];
    [tool_ setUrl_string:@"http://cast.aim.yoyi.com.cn/afp/door/;ap=x17117be4be6c5150001;ct=js;pu=n1428243fc09e7230001;/?"];
    tool_.delegate=self;
    [tool_ start];
    
}
-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    
    @try {
        //  NSDictionary * dic = [data objectFromJSONData];
        NSArray *array_test=[data objectFromJSONData];
        NSLog(@"dic== %@",array_test);
        NSDictionary *dic=[array_test objectAtIndex:0];
        NSLog(@"dic== %@",dic);
        
        guanggao_image=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568:480)];
        [self.view addSubview:guanggao_image];
        NSString *string_src=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
        NSLog(@"src==%@",string_src);
        [guanggao_image loadImageFromURL:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]] withPlaceholdImage:nil];
        NSTimer *  timer;
        timer=[NSTimer scheduledTimerWithTimeInterval:5
                                               target:self
                                             selector:@selector(dongqilai)
                                             userInfo:nil
                                              repeats:YES];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
   
    
}
-(void)downloadtoolError{
}
-(void)dongqilai{
    [self dismissModalViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
