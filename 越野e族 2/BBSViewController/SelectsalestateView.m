//
//  SelectsalestateView.m
//  FbLife
//
//  Created by 史忠坤 on 13-6-6.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SelectsalestateView.h"

@implementation SelectsalestateView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame receiveSalestateArray:(NSArray *)_array locationarray:(NSArray *)_arraylocation{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        array_salestate=_array;

        array_location=_arraylocation;
        self.frame = frame;
    }
    return self;

}

#pragma mark-Uipickerview代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return array_salestate.count;
    }else{
        return array_location.count;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0) {
        return [array_salestate objectAtIndex:row];
    }else{
        return [array_location objectAtIndex:row];
    }
    
}

-(void)selectedRow:(int)row withString:(NSString *)text{
    
    NSLog(@"%s%d%@",__FUNCTION__,row,text);
    
}
-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component{
    NSLog(@"%s%d\n%d",__FUNCTION__,row,component);
    if (component==0) {
        salenumber=row;
    }else{
        if (row<3) {
            locationnumber=row;

        }else if(row==3){
            locationnumber=31;
        }else if(row>3){
            locationnumber=row-1;
        }
            
    }
    
    // [self.delegate ReceiveNumber:row];
}


-(void)ShowPick{
    
    _ToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
   // [_ToolBar setBackgroundImage:[UIImage imageNamed:@"selectbbs.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault ];
    _ToolBar.backgroundColor=RGBCOLOR(252, 252, 252);
    // _ToolBar.barStyle = UIBarStyleBlackOpaque;
    [_ToolBar sizeToFit];
    
    
    
    UIButton *CancelButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 50, 28)];
    [CancelButton addTarget:self action:@selector(Dismiss) forControlEvents:UIControlEventTouchUpInside];
   // [CancelButton setBackgroundImage:[UIImage imageNamed:@"cancel5028.png"] forState:UIControlStateNormal];
    
    [CancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [CancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    CancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
        
    
    
    
    
    UIButton *DoneButton=[[UIButton alloc]initWithFrame:CGRectMake(260, 8, 50, 28)];
   // [DoneButton setBackgroundImage:[UIImage imageNamed:@"turn5028.png"] forState:UIControlStateNormal];
    
    [DoneButton setTitle:@"完成" forState:UIControlStateNormal];
    DoneButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [DoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [DoneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
 
    
    
    [DoneButton addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
   
    [_ToolBar addSubview:CancelButton];
    [_ToolBar addSubview:DoneButton];
    
    [self addSubview:_ToolBar];
    
    _Pick=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, 320, 160)];
    _Pick.delegate=self;
    _Pick.dataSource=self;
    _Pick.showsSelectionIndicator = YES;
    [self addSubview:_Pick];
    
}
-(void)Dismiss{
    [self removeFromSuperview];

}
-(void)btnDoneClick{
    NSLog(@"点击完成");

    [self.delegate salenumber:salenumber locationnumber:locationnumber];
    [self Dismiss];
}


@end
