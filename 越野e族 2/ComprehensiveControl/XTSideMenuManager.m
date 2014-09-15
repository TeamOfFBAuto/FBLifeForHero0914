//
//  XTSideMenuManager.m
//  XTNews
//
//  Created by tage on 14-5-27.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTSideMenuManager.h"

#import "MMDrawerController.h"


@implementation XTSideMenuManager

+ (void)resetSideMenuRecognizerEnable:(BOOL)canOpen
{
    AppDelegate *app=   (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    MMDrawerController *menu = (MMDrawerController *)app.RootVC;
    if (canOpen) {
        
        [menu setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];


    }else{
    
        [menu setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    }
}


@end
