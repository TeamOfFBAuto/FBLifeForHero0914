//
//  commrntbbdViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-19.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadtool.h"
#import "keyboardtopview.h"
#import "ASIFormDataRequest.h"
#import "FaceScrollView.h"
#import "FaceView.h"
#import "NewFaceView.h"
#import "WeiBoFaceScrollView.h"

#import "ATMHud.h"
#import "QBImagePickerController.h"

@interface commrntbbdViewController : UIViewController<downloaddelegate,KeyboardviewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate,QBImagePickerControllerDelegate,UIActionSheetDelegate>{
    downloadtool *_tool;
    UITextView *_contenttextview;
    keyboardtopview *_keytop;
    BOOL isup;
    UITextField *subjectTextfield;
    UIImagePickerController *imagePicker;
    
    ATMHud * hud;
    UIButton *button_back;
    UIImage *currentImage;
    
    downloadtool *image_tool;
    NSString *str_aid;
    NSString *str_img;
    
    WeiBoFaceScrollView *faceScrollView;
    GrayPageControl * pageControl;
    
    
    int keyboardandface;//判断是什么键盘还是表情
    int isbiaoti;//判断是标题还是内容如果是标题isbiaoti=1
    int ischinese;
    
    BOOL issendsuccess;
    
    
    
    
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@property(nonatomic,strong)NSString *title_string;
@property(nonatomic,strong)NSString *string_tid;
@property(nonatomic,strong)NSString *string_fid;
@property(nonatomic,strong)NSString *string_pid;
@property(nonatomic,strong)NSString *string_content;
@property(nonatomic,strong)NSString *string_subject;
@property(nonatomic,strong)NSString *string_floor;
@property(nonatomic,strong)NSString *string_distinguish;




@property(nonatomic,strong)NSString * allImageUrl;
@property(nonatomic,strong)NSMutableArray * allAssesters1;
@property(nonatomic,strong)NSMutableArray * allImageArray1;

@property(nonatomic,strong)NSArray * myAllimgUrl;


@end
