//
//  PraiseAndCollectedModel.m
//  越野e族
//
//  Created by soulnear on 14-7-18.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "PraiseAndCollectedModel.h"
#import "AppDelegate.h"

@implementation PraiseAndCollectedModel

@dynamic atlasid;
@dynamic praise;





//插入数据
+(void)addIntoDataSourceWithId:(NSString *)sender WithPraise:(NSNumber *)thePraise
{
    AppDelegate * myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    PraiseAndCollectedModel* user=(PraiseAndCollectedModel *)[NSEntityDescription insertNewObjectForEntityForName:@"PraiseAndCollectedModel" inManagedObjectContext:myAppDelegate.managedObjectContext];
//    
//    user.atlasid = sender.atlasid;
//    
//    user.praise = sender.praise;
//    
//    user.collected = sender.collected;
    
    
    NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:@"PraiseAndCollectedModel" inManagedObjectContext:myAppDelegate.managedObjectContext];
    
    [object setValue:sender forKey:@"atlasid"];
    
    [object setValue:[NSNumber numberWithBool:YES] forKey:@"praise"];
    
    NSError* error;
    BOOL isSaveSuccess=[myAppDelegate.managedObjectContext save:&error];
    if (!isSaveSuccess)
    {
        NSLog(@"Error:%@",error);
    }else{
        NSLog(@"Save successful!");
    }
    
}
//查询
+(NSMutableArray *)findQueryWithId:(NSString *)theId
{
    AppDelegate * myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    
    NSEntityDescription* user=[NSEntityDescription entityForName:@"PraiseAndCollectedModel" inManagedObjectContext:myAppDelegate.managedObjectContext];
    
    [request setEntity:user];
    
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"atlasid==%@",theId];
    [request setPredicate:predicate];
  
    NSError* error=nil;
    
    NSMutableArray* mutableFetchResult = [NSMutableArray array];
    
    mutableFetchResult=[[myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    
    if (mutableFetchResult==nil)
    {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %i",[mutableFetchResult count]);
    
    
    for (PraiseAndCollectedModel * name in mutableFetchResult)
    {
        NSLog(@"name:%@----age:%@------%@",name.atlasid,name.praise,mutableFetchResult);
    }
    
    return mutableFetchResult;
    
    
}


+(PraiseAndCollectedModel *)getTeamInfoById:(NSString *)theId
{
    PraiseAndCollectedModel *teamObject = nil;
    
    AppDelegate * myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *teamEntity = [NSEntityDescription entityForName:@"PraiseAndCollectedModel" inManagedObjectContext:myAppDelegate.managedObjectContext];
    [fetchRequest setEntity:teamEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"atlasid == %@",theId];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = NULL;
    NSArray *array = [myAppDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error---- : %@\n", [error localizedDescription]);
    }
    
    if (array && [array count] > 0) {
        teamObject = [array objectAtIndex:0];
    }
    
    NSLog(@"怎么读不出数据呢 ----  %@ --  %@ ---  %@",teamObject.atlasid,teamObject.praise,array);
    
    [fetchRequest release], fetchRequest = nil;
    
    return teamObject;
}



//更新
+(void)update:(PraiseAndCollectedModel *)sender
{
    AppDelegate * myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    
    NSEntityDescription* user=[NSEntityDescription entityForName:@"PraiseAndCollectedModel" inManagedObjectContext:myAppDelegate.managedObjectContext];
    [request setEntity:user];
    //查询条件
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"atlasid==%@",sender.atlasid];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %i",[mutableFetchResult count]);
    //更新age后要进行保存，否则没更新
    for (PraiseAndCollectedModel* user in mutableFetchResult)
    {
        user.atlasid = sender.atlasid;
        
        user.praise = sender.praise;

    }
    [myAppDelegate.managedObjectContext save:&error];
}
//删除
+(void)deleteWithId:(NSString *)theId
{
    AppDelegate * myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    
    NSEntityDescription* user=[NSEntityDescription entityForName:@"PraiseAndCollectedModel" inManagedObjectContext:myAppDelegate.managedObjectContext];
    
    [request setEntity:user];
    
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"atlasid==%@",theId];
    
    [request setPredicate:predicate];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (mutableFetchResult==nil)
    {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %i",[mutableFetchResult count]);
    
    for (PraiseAndCollectedModel* user in mutableFetchResult) {
        [myAppDelegate.managedObjectContext deleteObject:user];
    }
    
    if ([myAppDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }  
}






@end













