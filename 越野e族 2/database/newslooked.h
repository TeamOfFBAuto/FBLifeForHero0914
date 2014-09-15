//
//  newslooked.h
//  越野e族
//
//  Created by 史忠坤 on 14-1-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newslooked : NSObject
@property(nonatomic,strong)NSString *string_newslookedid;
-(newslooked *)initWithid:(NSString *)theid;
+(int)addid:(NSString *)theid ;
+(NSMutableArray *)findbytheid:(NSString *)thelookedid;

@end
