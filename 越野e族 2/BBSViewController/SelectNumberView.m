//
//  SelectNumberView.m
//  FbLife
//
//  Created by 史忠坤 on 13-4-22.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "SelectNumberView.h"

@implementation SelectNumberView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame receiveArray:(NSArray *)_array
{
    self = [super initWithFrame:frame];
    if (self) {
        array=_array;
        self.frame = frame;
    }
    return self;
}

-(void)ShowPick{
    
    _ToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[_ToolBar setBackgroundImage:[UIImage imageNamed:@"selectbbs.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault ];
   // _ToolBar.barStyle = UIBarStyleBlackOpaque;
    _ToolBar.backgroundColor=RGBCOLOR(244, 244, 246);
    [_ToolBar sizeToFit];
    
    UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    lineview.backgroundColor=RGBCOLOR(179, 179, 181);
    [_ToolBar addSubview:lineview];

    
    
    
    UIButton *CancelButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 50, 28)];
    [CancelButton addTarget:self action:@selector(cancelshow) forControlEvents:UIControlEventTouchUpInside];
//    [CancelButton setBackgroundImage:[UIImage imageNamed:@"cancel5028.png"] forState:UIControlStateNormal];
    [CancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [CancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    CancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    
    
    
    
    UIButton *DoneButton=[[UIButton alloc]initWithFrame:CGRectMake(260, 8, 50, 28)];
   // [DoneButton setBackgroundImage:[UIImage imageNamed:@"turn5028.png"] forState:UIControlStateNormal];

    [DoneButton setTitle:@"确定" forState:UIControlStateNormal];
    DoneButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [DoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [DoneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [DoneButton.layer setMasksToBounds:YES];
//    [DoneButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
//    [DoneButton.layer setBorderWidth:0.1]; //边框宽度
    
    text_label=[[UITextField alloc]initWithFrame:CGRectMake(135, 10, 60, 24)];
    text_label.backgroundColor=[UIColor clearColor];
    text_label.text=@"1";
    text_label.textAlignment=NSTextAlignmentCenter;
    text_label.keyboardType=UIKeyboardTypeNumberPad;
    text_label.delegate=self;
    
    
  //  DoneButton.backgroundColor=[UIColor grayColor];
    [DoneButton addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
    // UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnDoneClick)];
    [_ToolBar addSubview:text_label];
    [_ToolBar addSubview:CancelButton];
    [_ToolBar addSubview:DoneButton];
    
    [self addSubview:_ToolBar];
    
    _Pick=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, 320, 160)];
    _Pick.backgroundColor=[UIColor whiteColor];
    _Pick.delegate=self;
    _Pick.dataSource=self;
    _Pick.showsSelectionIndicator = YES;
    [self addSubview:_Pick];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.delegate NoticeFrameHigh];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([text_label.text integerValue]>array.count) {
        text_label.text=[NSString stringWithFormat:@"%d",rowofPickerview+1];
        
    }else{
        
    }

    
}
-(void)Dismiss{
    [self.delegate NoticeFrameLow];
    [self removeFromSuperview];

}

-(void)cancelshow{
    [self.delegate NoticeFrameLow];
    [self removeFromSuperview];
}
-(void)btnDoneClick{
    [self.delegate NoticeFrameLow];
    [text_label resignFirstResponder];
    if ([text_label.text integerValue]>array.count) {
        text_label.text=[NSString stringWithFormat:@"%d",rowofPickerview];

    }else{
        [self.delegate ReceiveNumber:[text_label.text integerValue]];
    }
    
 
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [array objectAtIndex:row];
    
}

-(void)selectedRow:(int)row withString:(NSString *)text{
    
    NSLog(@"%s%d%@",__FUNCTION__,row,text);
    
}
-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component{
    NSLog(@"%s%d\n%d",__FUNCTION__,row,component);
    
    rowofPickerview=row+1;
    text_label.text=[NSString stringWithFormat:@"%d",row+1];
   // [self.delegate ReceiveNumber:row];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
