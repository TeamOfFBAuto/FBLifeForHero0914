//
//  DataBase.h
//  FbLife
//
//  Created by soulnear on 13-6-8.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBase1 : NSObject
+(sqlite3 *)openDB;

+(void)closeDB;
@end
