//
//  dataBase.h
//  QQ
//
//  Created by ibokan1 on 12-2-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface dataBase : NSObject

+(sqlite3 *)openDB;

+(void)closeDB;
@end



























