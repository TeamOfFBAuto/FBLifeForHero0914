//
//  NewMainViewModel.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-8.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "NewMainViewModel.h"

@implementation NewMainViewModel

-(void)NewMainViewModelSetdic:(NSDictionary *)thedic{
    
    @try {
        self.theid=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"id"]];
        
        self.tid=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"tid"]];
        
        self.photo=[NSArray arrayWithArray:(NSArray *)[thedic objectForKey:@"photo"]];
        
        self.title=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"title"]];
        
        self.stitle=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"stitle"]];
        
        self.storeid=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"storeid"]];
        
        self.business=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"business"]];
        
        self.classid=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"classid"]];
        
        self.channelid=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"channelid"]];
        
        self.channel_name=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"channel_name"]];
        
        self.bbsfid=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"bbsfid"]];
        
        self.forumname=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"forumname"]];
        
        self.type=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"type"]];
        
        self.publishtime=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"publishtime"]];
        
        self.likes=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"likes"]];
        
        self.shownum=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"shownum"]];

        //comment
        
        self.comment=[NSString stringWithFormat:@"%@",[thedic objectForKey:@"comment"]];

        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

}



@end
