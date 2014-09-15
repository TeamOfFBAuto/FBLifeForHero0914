//
//  CarType.m
//  FbLife
//
//  Created by soulnear on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CarType.h"

@implementation CarType
@synthesize area = _area;
@synthesize carfrom = _carfrom;
@synthesize carnum = _carnum;
@synthesize content = _content;
@synthesize fid = _fid;
@synthesize fwords = _fwords;
@synthesize groupid = _groupid;
@synthesize carid = _carid;
@synthesize name = _name;
@synthesize nwords = _nwords;
@synthesize photo = _photo;
@synthesize picnum = _picnum;
@synthesize pid = _pid;
@synthesize price = _price;
@synthesize price_range = _price_range;
@synthesize priority = _priority;
@synthesize type = _type;
@synthesize url = _url;
@synthesize series_price_max = _series_price_max;
@synthesize series_price_min = _series_price_min;
@synthesize size = _size;
@synthesize recommend = _recommend;
@synthesize words = _words;




-(CarType *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self)
    {
        self.area = [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
        
        self.carfrom = [NSString stringWithFormat:@"%@",[dic objectForKey:@"carfrom"]];
        
        self.carnum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"carnum"]];
        
        self.content = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        
        self.fid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fid"]];
        
        self.fwords = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fwords"]];
        
        self.groupid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"groupid"]];
        
        self.carid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        
        self.name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
        self.nwords = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nwords"]];
        
        self.photo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"photo"]];
        
        self.picnum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picnum"]];
        
        self.pid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pid"]];
        
        self.price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
        
        self.price_range = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price_range"]];
        
        self.priority = [NSString stringWithFormat:@"%@",[dic objectForKey:@"priority"]];
        
        self.recommend = [NSString stringWithFormat:@"%@",[dic objectForKey:@"recommend"]];
        
        self.series_price_max = [NSString stringWithFormat:@"%@",[dic objectForKey:@"series_price_max"]];
        
        self.series_price_min = [NSString stringWithFormat:@"%@",[dic objectForKey:@"series_price_min"]];
        
        self.size = [NSString stringWithFormat:@"%@",[dic objectForKey:@"size"]];
        
        self.type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]];
        
        self.url = [NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
        
        self.words = [NSString stringWithFormat:@"%@",[dic objectForKey:@"words"]];
    }
    return self;
}



@end
