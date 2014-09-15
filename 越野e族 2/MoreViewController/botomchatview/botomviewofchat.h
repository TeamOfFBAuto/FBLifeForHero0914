//
//  botomviewofchat.h
//  FbLife
//
//  Created by 史忠坤 on 13-8-15.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class botomviewofchat;
@protocol botomviewofchatDelegate <NSObject>

-(void)sendwithtext:(NSString *)mytext;


@end
@interface botomviewofchat : UIView{
     
    
}
@property(nonatomic,strong)UITextView *atextv;
@property(assign,nonatomic)id<botomviewofchatDelegate>delegate;
@end
