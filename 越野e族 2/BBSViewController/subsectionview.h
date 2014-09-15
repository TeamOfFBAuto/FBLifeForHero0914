//
//  subsectionview.h
//  FbLife
//
//  Created by 史忠坤 on 13-3-6.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class subsectionview;
@protocol butoonindexdelegate <NSObject>

-(void)selectbuttontag:(NSInteger)tag;
@end
@interface subsectionview : UIView{
    
}
@property(nonatomic,strong)NSArray *array_name;
@property(nonatomic,strong)NSArray *array_id;

@property(assign,nonatomic)id<butoonindexdelegate> buttonselectdelegate;

@end
