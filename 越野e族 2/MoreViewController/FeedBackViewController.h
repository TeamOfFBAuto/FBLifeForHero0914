//
//  FeedBackViewController.h
//  FbLife
//
//  Created by 史忠坤 on 13-5-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"
@interface FeedBackViewController : UIViewController<UMFeedbackDataDelegate,UITextViewDelegate>{

    UMFeedback *umFeedback;
    UIButton *button_comment;
    UITextField *_contenttextview;


}

@end
