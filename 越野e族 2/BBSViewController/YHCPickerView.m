//
//  YHCPickerView.m
//  TestDB
//
//  Created by Yashesh Chauhan on 01/10/12.
//  Copyright (c) 2012 Yashesh Chauhan. All rights reserved.
//

#import "YHCPickerView.h"

@implementation YHCPickerView
@synthesize arrRecords,delegate;


-(id)initWithFrame:(CGRect)frame withNSArray:(NSArray *)arrValues{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrRecords = arrValues;
    }
    return self;

}
-(void)showPicker{
    
    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(keyboardWillShowNotification:)
//     name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(keyboardWillHideNotification:)
//     name:UIKeyboardWillHideNotification object:nil];
    
    
    self.userInteractionEnabled = TRUE;
    self.backgroundColor = [UIColor clearColor];
    
    copyListOfItems = [[NSMutableArray alloc] init];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44, 320.0, 0.0)];
    
    //[picketView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    picketToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    picketToolbar.barStyle = UIBarStyleBlackOpaque;
    [picketToolbar sizeToFit];
    
    txtSearch = [[UISearchBar alloc] initWithFrame:CGRectMake(45, 7, 220, 31)];
    txtSearch.tag = 1;
    txtSearch.barStyle = UIBarStyleBlackTranslucent;
    txtSearch.backgroundColor = [UIColor clearColor];
    txtSearch.delegate = self;
    txtSearch.userInteractionEnabled = TRUE;
    
    for (UIView *subview in txtSearch.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    
    UIButton *CancelButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 7, 40, 30)];
    [CancelButton addTarget:self action:@selector(cancelshow) forControlEvents:UIControlEventTouchUpInside];
    [CancelButton.layer setMasksToBounds:YES];
    [CancelButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [CancelButton setTitle:@"取消" forState:UIControlStateNormal];
    CancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [CancelButton.layer setBorderWidth:1.0]; //边框宽度

    CancelButton.backgroundColor=[UIColor colorWithRed:36/255.f green:36/255.f blue:36/255.f alpha:1];


    
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIButton *DoneButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 40, 30)];
    [DoneButton setTitle:@"完成" forState:UIControlStateNormal];
    DoneButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [DoneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [DoneButton.layer setMasksToBounds:YES];
    [DoneButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [DoneButton.layer setBorderWidth:1.0]; //边框宽度

    DoneButton.backgroundColor=[UIColor colorWithRed:36/255.f green:36/255.f blue:36/255.f alpha:1];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:DoneButton];
    [DoneButton addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
   // UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnDoneClick)];
    [picketToolbar addSubview:txtSearch];
    [picketToolbar addSubview:CancelButton];
    
    NSArray *arrBarButtoniTems = [[NSArray alloc] initWithObjects:flexible,btnitem, nil];
    [picketToolbar setItems:arrBarButtoniTems];
    [self addSubview:pickerView];
    
    [self addSubview:picketToolbar];
    
}
-(void)cancelshow{
    [self removeFromSuperview];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
 
    searching = NO;
	letUserSelectRow = NO;
////    if (pickerView) {
////        [pickerView removeFromSuperview];
////    }
//    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
//    pickerView.showsSelectionIndicator = YES;
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
	[copyListOfItems removeAllObjects];
	
	if([searchText length] > 0) {
    
		searching = YES;
		letUserSelectRow = YES;
    
		[self searchTableView];
	}
	else {
		
		searching = NO;
		letUserSelectRow = NO;

	}
	
	[pickerView reloadAllComponents];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self btnDoneClick];
}

- (void) searchTableView {
	
	NSString *searchText = txtSearch.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];

	
	for (NSString *sTemp in self.arrRecords)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0){
			[copyListOfItems addObject:sTemp];
        }
	}
    [pickerView reloadAllComponents];
	
	[searchArray release];
	searchArray = nil;
}

//-(void)keyboardWillShowNotification:(id)sender{
//    
////    pickerView.frame = CGRectMake(0, 44, 320, 216);
////    picketToolbar.frame = CGRectMake(0, 0, 320, 44);
//    NSLog(@"??");
//}
//
//-(void)keyboardWillHideNotification:(id)sender{
//    NSLog(@"??");
//
////    pickerView.frame = CGRectMake(0.0, 200, 320, 216);
////    picketToolbar.frame = CGRectMake(0, 156, 320, 44);
//    
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)btnDoneClick{
    
    NSString *strSelectedValue;
    
    if (searching ) {
        
        if (copyListOfItems.count > 0) {
            
            strSelectedValue = [copyListOfItems objectAtIndex:[pickerView selectedRowInComponent:0]];
            int selectedIndex = [self.arrRecords indexOfObject:strSelectedValue];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:withString:)]) {
                [self.delegate selectedRow:selectedIndex withString:strSelectedValue];
            }
            
        }else{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:withString:)]) {
                [self.delegate selectedRow:-1 withString:@"NOT FOUND"];
            }
        }
        
    }else{
        
        strSelectedValue = [arrRecords objectAtIndex:[pickerView selectedRowInComponent:0]];
        int selectedIndex = [self.arrRecords indexOfObject:strSelectedValue];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:withString:)]) {
            [self.delegate selectedRow:selectedIndex withString:strSelectedValue];
        }
    }
    [self removeFromSuperview];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (searching) {
        return copyListOfItems.count;
    }else{
        return self.arrRecords.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (searching) {
        return [copyListOfItems objectAtIndex:row];
    }else{
        return [self.arrRecords objectAtIndex:row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
           
}

@end
