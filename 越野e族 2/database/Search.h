//
//  Search.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-29.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *id_ofbbs;
-(Search *)initWithname:(NSString *)bbsname bbsid:(NSString*)_bbsid;
+(NSMutableArray *)findall;
+(int)addbbsname:(NSString *)thebbsname  id:(NSString *)theid ;
@end
