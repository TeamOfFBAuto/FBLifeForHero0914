//
//  VerificationViewController.h
//  越野e族
//
//  Created by soulnear on 13-12-26.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuCeViewController.h"
#import "ATMHud.h"

@interface VerificationViewController : MyViewController<ASIHTTPRequestDelegate>
{
    UITextField * verification_tf;
    
    ASIHTTPRequest * request_;
    
    ASIHTTPRequest * reSend_request;
    
    ATMHud * hud;
    
    int time_number;
    
    NSTimer * timer;
    
    UILabel * time_label;
    
    UIButton * ReSendButton;
}

@property(nonatomic,strong)NSString * MyPhoneNumber;




@end
