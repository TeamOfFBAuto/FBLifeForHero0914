//
//  FbFeed.m
//  FblifeAll
//
//  Created by zhang xinhao on 12-11-17.
//  Copyright (c) 2012年 fblife. All rights reserved.
//

#import "FbFeed.h"
#import "DataBase.h"

@implementation FbFeed

@synthesize tid=_tid;
@synthesize uid=_uid;
@synthesize userName=_userName;
@synthesize content=_content;
@synthesize imageFlg=_imageFlg;
@synthesize image_small_url=_image_small_url;
@synthesize image_original_url=_image_original_url;
@synthesize image_small_url_m=_image_small_url_m;
@synthesize image_original_url_m=_image_original_url_m;
@synthesize replys=_replys;
@synthesize forwards=_forwards;
@synthesize rootFlg=_rootFlg;
@synthesize dateline=_dateline;
@synthesize from=_from;
@synthesize sort=_sort;
@synthesize sortId = _sortId;
@synthesize jing_lng=_jing_lng;
@synthesize wei_lat=_wei_lat;
@synthesize locality=_locality;
@synthesize face_small_url=_face_small_url;
@synthesize face_original_url=_face_original_url;
@synthesize type=_type;
@synthesize totid = _totid;
@synthesize title_content = _title_content;
@synthesize musicurl = _musicurl;
@synthesize olink = _olink;


@synthesize blog=_blog;
@synthesize photo=_photo;
@synthesize exten=_exten;
@synthesize fbNews=_fbNews;

//-------------------------------------------------
@synthesize rtid=_rtid;
@synthesize ruid=_ruid;
@synthesize ruserName=_ruserName;
@synthesize rcontent=_rcontent;
@synthesize rimageFlg=_rimageFlg;
@synthesize rimage_small_url=_rimage_small_url;
@synthesize rimage_original_url=_rimage_original_url;
@synthesize rimage_small_url_m=_rimage_small_url_m;
@synthesize rimage_original_url_m=_rimage_original_url_m;
@synthesize rreplys=_rreplys;
@synthesize rforwards=_rforwards;
@synthesize rrootFlg=_rrootFlg;
@synthesize rdateline=_rdateline;
@synthesize rfrom=_rfrom;
@synthesize rsort=_rsort;
@synthesize rsortId = _rsortId;
@synthesize rjing_lng=_rjing_lng;
@synthesize rwei_lat=_rwei_lat;
@synthesize rlocality=_rlocality;
@synthesize rface_small_url=_rface_small_url;
@synthesize rface_original_url=_rface_original_url;
@synthesize rtype=_rtype;
@synthesize rtitle_content = _rtitle_content;
@synthesize rmusicurl = _rmusicurl;
@synthesize rolink = _rolink;


@synthesize photo_title = _photo_title;

@synthesize rblog=_rblog;
@synthesize rphoto=_rphoto;
@synthesize rexten=_rexten;
@synthesize rfbNews=_rfbNews;

@synthesize hualangFlg=_hualangFlg;


////用于copy  bean时调用
//-(id)copyWithZone:(NSZone *)zone{
//    FbFeed *newFeed=[[[FbFeed allocWithZone:zone]init]autorelease];
//    [newFeed setTid:_tid];
//    [newFeed setUid:_uid];
//    [newFeed setUserName:_userName];
//    [newFeed setContent:_content];
//    [newFeed setImageFlg:_imageFlg];
//    [newFeed setImage_original_url:_image_original_url];
//    [newFeed setImage_small_url:_image_small_url];
//    [newFeed setReplys:_replys];
//    [newFeed setForwards:_forwards];
//    [newFeed setRootFlg:_rootFlg];
//    [newFeed setDateline:_dateline];
//    [newFeed setFrom:_from];
//    [newFeed setSort:_sort];
//    [newFeed setJing_lng:_jing_lng];
//    [newFeed setWei_lat:_wei_lat];
//    [newFeed setLocality:_locality];
//    [newFeed setFace_original_url:_face_original_url];
//    [newFeed setFace_small_url:_face_small_url];
//    [newFeed setType:_type];
//    [newFeed setBlog:_blog];
//    [newFeed setPhoto:_photo];
//    [newFeed setExten:_exten];
//    [newFeed setFbNews:_fbNews];
//    return newFeed;
//
//}

-(void)setNsImageFlg:(NSString*)imageFlg{
    if ([@"0" isEqualToString:imageFlg]) {
        _imageFlg=NO;
    }else{
        _imageFlg=YES;
    }
}
-(void)setNsRootFlg:(NSString*)rootFlg{
    if ([@"0" isEqualToString:rootFlg]) {
        _rootFlg=NO;
    }else{
        _rootFlg=YES;
    }
}
//-(void)setFrom:(NSString *)from
//{
//
//    NSLog(@"from -=-=-=  %@",from);
////    NSString * theFrom;
////
////    if ([from isEqualToString:@"iphone"])
////    {
////        theFrom = @"iPhone";
////    }else if ([from isEqualToString:@"web"])
////    {
////        theFrom = @"网页";
////    }else if ([from isEqualToString:@"bbs"])
////    {
////        theFrom = @"论坛";
////    }else if([from isEqualToString:@"news"])
////    {
////        theFrom = @"新闻";
////    }
//
//    if (self.from != from)
//    {
//        [self.from release];
//        self.from = [[NSString stringWithFormat:@"来自 %@",from] copy];
//    }
//}

-(void)setNsType:(NSString *)type
{
    if ([@"first" isEqualToString:type])
    {
        _type=@"first";
    }else  if ([@"both" isEqualToString:type])
    {
        _type=@"both";
    }else  if ([@"reply" isEqualToString:type])
    {
        _type=@"reply";
    }else if([@"forward" isEqualToString:type])
    {
        _type=@"forward";
    }
}
//-(void)setNsSort:(NSString *)sort
//{
//    NSLog(@"sort ---- %d",[sort intValue]);
//    if ([@"0" isEqualToString:sort])
//    {
//        _sort=weibo;
//        _hualangFlg=NO;
//    }else  if ([@"1" isEqualToString:sort])
//    {
//        _sort=@"defualt1";
//         _hualangFlg=NO;
//    }else  if ([@"2" isEqualToString:sort])
//    {
//        _sort=@"blog";
//         _hualangFlg=NO;
//    }else  if ([@"3" isEqualToString:sort])
//    {
//        _sort=@"photo";
//        _hualangFlg=YES;
//    }else  if ([@"4" isEqualToString:sort])
//    {
//        _sort=@"bbsForward";
//         _hualangFlg=NO;
//    }else  if ([@"5" isEqualToString:sort])
//    {
//        _sort=@"bbsSend";
//         _hualangFlg=NO;
//    }else  if ([@"6" isEqualToString:sort])
//    {
//        _sort=@"newsReply";
//         _hualangFlg=NO;
//    }else  if ([@"7" isEqualToString:sort])
//    {
//        _sort=@"defualt7";
//         _hualangFlg=NO;
//    }else  if ([@"8" isEqualToString:sort])
//    {
//        _sort=@"defualt8";
//         _hualangFlg=NO;
//    }else  if ([@"9" isEqualToString:sort])
//    {
//        _sort=@"defualt9";
//         _hualangFlg=NO;
//    }else  if ([@"10" isEqualToString:sort])
//    {
//        _sort=@"defualt10";
//         _hualangFlg=NO;
//    }else  if ([@"11" isEqualToString:sort])
//    {
//        _sort=@"defualt11";
//         _hualangFlg=NO;
//    }
//}

//----------------------------------------------
-(void)setRNsImageFlg:(NSString*)imageFlg{
    if ([@"0" isEqualToString:imageFlg]) {
        
        _rimageFlg=NO;
    }else{
        _rimageFlg=YES;
    }
}
-(void)setRNsRootFlg:(NSString*)rootFlg{
    if ([@"0" isEqualToString:rootFlg]) {
        _rrootFlg=NO;
    }else{
        _rrootFlg=YES;
    }
}
-(void)setRFrom:(NSString *)rfrom
{
    if (_rfrom != rfrom)
    {
        [_rfrom release];
        _rfrom = [[NSString stringWithFormat:@"来自 %@",rfrom] copy];
    }
    
}
-(void)setRNsType:(NSString *)type{
    if ([@"first" isEqualToString:type]) {
        _rtype=@"first";
    }else  if ([@"both" isEqualToString:type]) {
        _rtype=@"both";
    }else  if ([@"reply" isEqualToString:type]) {
        _rtype=@"reply";
    }
}
//-(void)setRNsSort:(NSString *)sort{
//    if ([@"0" isEqualToString:sort]) {
//        _rsort=@"weibo";
//         _hualangFlg=NO;
//    }else  if ([@"1" isEqualToString:sort]) {
//        _rsort=@"defualt1";
//         _hualangFlg=NO;
//    }else  if ([@"2" isEqualToString:sort]) {
//        _rsort=@"blog";
//         _hualangFlg=NO;
//    }else  if ([@"3" isEqualToString:sort]) {
//        _rsort=@"photo";
//        _hualangFlg=YES;
//    }else  if ([@"4" isEqualToString:sort]) {
//        _rsort=@"bbsForward";
//         _hualangFlg=NO;
//    }else  if ([@"5" isEqualToString:sort]) {
//        _rsort=@"bbsSend";
//         _hualangFlg=NO;
//    }else  if ([@"6" isEqualToString:sort]) {
//        _rsort=@"newsReply";
//         _hualangFlg=NO;
//    }else  if ([@"7" isEqualToString:sort]) {
//        _rsort=@"defualt7";
//         _hualangFlg=NO;
//    }else  if ([@"8" isEqualToString:sort]) {
//        _rsort=@"defualt8";
//         _hualangFlg=NO;
//    }else  if ([@"9" isEqualToString:sort]) {
//        _rsort=@"defualt9";
//         _hualangFlg=NO;
//    }else  if ([@"10" isEqualToString:sort]) {
//        _rsort=@"defualt10";
//         _hualangFlg=NO;
//    }else  if ([@"11" isEqualToString:sort]) {
//        _rsort=@"defualt11";
//         _hualangFlg=NO;
//    }
//
//}
//- (void)dealloc {
//    [_tid release];
//    [_uid release];
//    [_userName release];
//    [_content release];
//    [_image_small_url release];
//    [_image_original_url release];
//    [_replys release];
//    [_forwards release];
//    [_dateline release];
//    [_jing_lng release];
//    [_wei_lat release];
//    [_locality release];
//    [_face_small_url release];
//    [_face_original_url release];
//
//    [_photo release];
//    [_exten release];
//    [_blog release];
//    [_fbNews release];
////---------------------------------------------------------------
//    [_rtid release];
//    [_ruid release];
//    [_ruserName release];
//    [_rcontent release];
//    [_rimage_small_url release];
//    [_rimage_original_url release];
//    [_rreplys release];
//    [_rforwards release];
//    [_rdateline release];
//    [_rjing_lng release];
//    [_rwei_lat release];
//    [_rlocality release];
//    [_rface_small_url release];
//    [_rface_original_url release];
//
//    [_rphoto release];
//    [_rexten release];
//    [_rblog release];
//    [_rfbNews release];
//    [super dealloc];
//}


//数据库


+(NSMutableArray *)findAllByType:(int)theType
{
    sqlite3 * db = [DataBase openDB];
    
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from newcontent where WeiBoType=? order by tid desc",-1,&stmt, nil);
    
    if (result == SQLITE_OK)
    {
        //        sqlite3_bind_text(stmt, 1,[theQuarter UTF8String], -1, nil);
        sqlite3_bind_int(stmt,1,theType);
        NSMutableArray * perArray = [[NSMutableArray alloc] init];
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            const unsigned char * tid = sqlite3_column_text(stmt,0);
            const unsigned char * uid = sqlite3_column_text(stmt,1);
            const unsigned char * username = sqlite3_column_text(stmt,2);
            const unsigned char * content = sqlite3_column_text(stmt,3);
            const unsigned char * image_original = sqlite3_column_text(stmt,4);
            const unsigned char * image_small = sqlite3_column_text(stmt,5);
            const unsigned char * from = sqlite3_column_text(stmt,6);
            const unsigned char * type = sqlite3_column_text(stmt,7);
            const unsigned char * sort = sqlite3_column_text(stmt,8);
            const unsigned char * sortId = sqlite3_column_text(stmt,9);
            const unsigned char * jing_lng = sqlite3_column_text(stmt,10);
            const unsigned char * wei_lat = sqlite3_column_text(stmt,11);
            const unsigned char * locality = sqlite3_column_text(stmt,12);
            const unsigned char * face_original = sqlite3_column_text(stmt,13);
            const unsigned char * face_small = sqlite3_column_text(stmt,14);
            BOOL rootFlg = sqlite3_column_int(stmt,15);
            BOOL imageFlg = sqlite3_column_int(stmt,16);
            const unsigned char * dateline = sqlite3_column_text(stmt,17);
            const unsigned char * replys = sqlite3_column_text(stmt,18);
            const unsigned char * forwards = sqlite3_column_text(stmt,19);
            
            const unsigned char * rtid = sqlite3_column_text(stmt,20);
            const unsigned char * ruid = sqlite3_column_text(stmt,21);
            const unsigned char * rusername = sqlite3_column_text(stmt,22);
            const unsigned char * rcontent = sqlite3_column_text(stmt,23);
            const unsigned char * rimage_original = sqlite3_column_text(stmt,24);
            const unsigned char * rimage_small = sqlite3_column_text(stmt,25);
            const unsigned char * rfrom = sqlite3_column_text(stmt,26);
            const unsigned char * rtype = sqlite3_column_text(stmt,27);
            const unsigned char * rsort = sqlite3_column_text(stmt,28);
            const unsigned char * rsortId = sqlite3_column_text(stmt,29);
            const unsigned char * rjing_lng = sqlite3_column_text(stmt,30);
            const unsigned char * rwei_lat = sqlite3_column_text(stmt,31);
            const unsigned char * rlocality = sqlite3_column_text(stmt,32);
            const unsigned char * rface_original = sqlite3_column_text(stmt,33);
            const unsigned char * rface_small = sqlite3_column_text(stmt,34);
            BOOL rrootFlg = sqlite3_column_int(stmt,35);
            BOOL rimageFlg = sqlite3_column_int(stmt,36);
            const unsigned char * rdateline = sqlite3_column_text(stmt,37);
            const unsigned char * rreplys = sqlite3_column_text(stmt,38);
            const unsigned char * rforwards = sqlite3_column_text(stmt,39);
            
            //            const unsigned char * WeiBotype = sqlite3_column_text(stmt,40);
            
            const unsigned char * imageOriginalM = sqlite3_column_text(stmt,41);
            const unsigned char * imageSmallM = sqlite3_column_text(stmt,42);
            
            const unsigned char * rimageOriginalM = sqlite3_column_text(stmt,43);
            const unsigned char * rimageSmallM = sqlite3_column_text(stmt,44);
            
            const unsigned char * aid = sqlite3_column_text(stmt,45);
            const unsigned char * raid = sqlite3_column_text(stmt,46);
            
            const unsigned char * titleContent = sqlite3_column_text(stmt,47);
            const unsigned char * rtitleContent = sqlite3_column_text(stmt,48);
            
            const unsigned char * musicurl = sqlite3_column_text(stmt,49);
            const unsigned char * rmusicurl = sqlite3_column_text(stmt,50);
            
            const unsigned char * olink = sqlite3_column_text(stmt,51);
            const unsigned char * rolink = sqlite3_column_text(stmt,52);
            const unsigned char * photo_title = sqlite3_column_text(stmt,53);
            
            
            FbFeed * per = [[FbFeed alloc] init];
            
            
            
            per.tid = tid?[NSString stringWithUTF8String:(const char *)tid]:@"";
            per.uid = uid?[NSString stringWithUTF8String:(const char *)uid]:@"";
            per.userName = username?[NSString stringWithUTF8String:(const char *)username]:@"";
            per.content = content?[NSString stringWithUTF8String:(const char *)content]:@"";
            per.image_original_url = image_original?[NSString stringWithUTF8String:(const char *)image_original]:@"";
            per.image_small_url = image_small?[NSString stringWithUTF8String:(const char *)image_small]:@"";
            per.from = from?[NSString stringWithUTF8String:(const char *)from]:@"";
            per.type = type?[NSString stringWithUTF8String:(const char *)type]:@"";
            per.sort = sort?[NSString stringWithUTF8String:(const char *)sort]:@"";
            per.sortId = sortId?[NSString stringWithUTF8String:(const char *)sortId]:@"";
            per.jing_lng = jing_lng?[NSString stringWithUTF8String:(const char *)jing_lng]:@"";
            per.wei_lat = wei_lat?[NSString stringWithUTF8String:(const char *)wei_lat]:@"";
            per.locality = locality?[NSString stringWithUTF8String:(const char *)locality]:@"";
            per.face_original_url = face_original?[NSString stringWithUTF8String:(const char *)face_original]:@"";
            per.face_small_url = face_small?[NSString stringWithUTF8String:(const char *)face_small]:@"";
            per.rootFlg = rootFlg;
            per.imageFlg = imageFlg;
            per.dateline = dateline?[NSString stringWithUTF8String:(const char *)dateline]:@"";
            per.replys = replys?[NSString stringWithUTF8String:(const char *)replys]:@"";
            per.forwards = forwards?[NSString stringWithUTF8String:(const char *)forwards]:@"";
            
            
            
            per.rtid = rtid?[NSString stringWithUTF8String:(const char *)rtid]:@"";
            per.ruid = ruid?[NSString stringWithUTF8String:(const char *)ruid]:@"";
            per.ruserName = rusername?[NSString stringWithUTF8String:(const char *)rusername]:@"";
            per.rcontent = rcontent?[NSString stringWithUTF8String:(const char *)rcontent]:@"";
            per.rimage_original_url = rimage_original?[NSString stringWithUTF8String:(const char *)rimage_original]:@"";
            per.rimage_small_url = rimage_small?[NSString stringWithUTF8String:(const char *)rimage_small]:@"";
            per.rfrom = rfrom?[NSString stringWithUTF8String:(const char *)rfrom]:@"";
            per.rtype = rtype?[NSString stringWithUTF8String:(const char *)rtype]:@"";
            per.rsort = rsort?[NSString stringWithUTF8String:(const char *)rsort]:@"";
            per.rsortId = rsortId?[NSString stringWithUTF8String:(const char *)rsortId]:@"";
            per.rjing_lng = rjing_lng?[NSString stringWithUTF8String:(const char *)rjing_lng]:@"";
            per.rwei_lat = rwei_lat?[NSString stringWithUTF8String:(const char *)rwei_lat]:@"";
            per.rlocality = rlocality?[NSString stringWithUTF8String:(const char *)rlocality]:@"";
            per.rface_original_url = rface_original?[NSString stringWithUTF8String:(const char *)rface_original]:@"";
            per.rface_small_url = rface_small?[NSString stringWithUTF8String:(const char *)rface_small]:@"";
            per.rrootFlg = rrootFlg;
            per.rimageFlg = rimageFlg;
            per.rdateline = rdateline?[NSString stringWithUTF8String:(const char *)rdateline]:@"";
            per.rreplys = rreplys?[NSString stringWithUTF8String:(const char *)rreplys]:@"";
            per.rforwards = rforwards?[NSString stringWithUTF8String:(const char *)rforwards]:@"";
            
            per.image_original_url_m = imageOriginalM?[NSString stringWithUTF8String:(const char *)imageOriginalM]:@"";
            per.image_small_url_m = imageSmallM?[NSString stringWithUTF8String:(const char *)imageSmallM]:@"";
            
            per.rimage_original_url_m = rimageOriginalM?[NSString stringWithUTF8String:(const char *)rimageOriginalM]:@"";
            per.rimage_small_url_m = rimageSmallM?[NSString stringWithUTF8String:(const char *)rimageSmallM]:@"";
            
            if ([per.sort isEqualToString:@"3"])
            {
                PhotoFeed * photot = [[PhotoFeed alloc] init];
                photot.aid = aid?[NSString stringWithUTF8String:(const char *)aid]:@"";
                per.photo = photot;
                
                photot.aid = raid?[NSString stringWithUTF8String:(const char *)raid]:@"";
                per.rphoto = photot;
            }
            
            
            per.title_content = titleContent?[NSString stringWithUTF8String:(const char *)titleContent]:@"";
            per.rtitle_content = rtitleContent?[NSString stringWithUTF8String:(const char *)rtitleContent]:@"";
            
            per.musicurl = musicurl?[NSString stringWithUTF8String:(const char *)musicurl]:@"";
            per.rmusicurl = rmusicurl?[NSString stringWithUTF8String:(const char *)rmusicurl]:@"";
            
            per.olink = olink?[NSString stringWithUTF8String:(const char *)olink]:@"";
            per.rolink = rolink?[NSString stringWithUTF8String:(const char *)rolink]:@"";
            per.photo_title = photo_title?[NSString stringWithUTF8String:(const char *)photo_title]:@"";
            
            [perArray addObject:per];
        }
        return perArray;
        
    }else
    {
        NSLog(@"failed with result:%d",result);
        return [NSMutableArray array];
    }
    sqlite3_finalize(stmt);
}



+(NSMutableArray *)findAll
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    int result = sqlite3_prepare_v2(db,"select * from newcontent order by tid desc", -1,&stmt,nil);
    NSLog(@"resulttttttt --- %d",result);
    
    if (result == SQLITE_OK)
    {
        NSMutableArray * perArray = [[NSMutableArray alloc] init];
        
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            const unsigned char * tid = sqlite3_column_text(stmt,0);
            const unsigned char * uid = sqlite3_column_text(stmt,1);
            const unsigned char * username = sqlite3_column_text(stmt,2);
            const unsigned char * content = sqlite3_column_text(stmt,3);
            const unsigned char * image_original = sqlite3_column_text(stmt,4);
            const unsigned char * image_small = sqlite3_column_text(stmt,5);
            const unsigned char * from = sqlite3_column_text(stmt,6);
            const unsigned char * type = sqlite3_column_text(stmt,7);
            const unsigned char * sort = sqlite3_column_text(stmt,8);
            const unsigned char * sortId = sqlite3_column_text(stmt,9);
            const unsigned char * jing_lng = sqlite3_column_text(stmt,10);
            const unsigned char * wei_lat = sqlite3_column_text(stmt,11);
            const unsigned char * locality = sqlite3_column_text(stmt,12);
            const unsigned char * face_original = sqlite3_column_text(stmt,13);
            const unsigned char * face_small = sqlite3_column_text(stmt,14);
            BOOL rootFlg = sqlite3_column_int(stmt,15);
            BOOL imageFlg = sqlite3_column_int(stmt,16);
            const unsigned char * dateline = sqlite3_column_text(stmt,17);
            const unsigned char * replys = sqlite3_column_text(stmt,18);
            const unsigned char * forwards = sqlite3_column_text(stmt,19);
            
            const unsigned char * rtid = sqlite3_column_text(stmt,20);
            const unsigned char * ruid = sqlite3_column_text(stmt,21);
            const unsigned char * rusername = sqlite3_column_text(stmt,22);
            const unsigned char * rcontent = sqlite3_column_text(stmt,23);
            const unsigned char * rimage_original = sqlite3_column_text(stmt,24);
            const unsigned char * rimage_small = sqlite3_column_text(stmt,25);
            const unsigned char * rfrom = sqlite3_column_text(stmt,26);
            const unsigned char * rtype = sqlite3_column_text(stmt,27);
            const unsigned char * rsort = sqlite3_column_text(stmt,28);
            const unsigned char * rsortId = sqlite3_column_text(stmt,29);
            const unsigned char * rjing_lng = sqlite3_column_text(stmt,30);
            const unsigned char * rwei_lat = sqlite3_column_text(stmt,31);
            const unsigned char * rlocality = sqlite3_column_text(stmt,32);
            const unsigned char * rface_original = sqlite3_column_text(stmt,33);
            const unsigned char * rface_small = sqlite3_column_text(stmt,34);
            BOOL rrootFlg = sqlite3_column_int(stmt,35);
            BOOL rimageFlg = sqlite3_column_int(stmt,36);
            const unsigned char * rdateline = sqlite3_column_text(stmt,37);
            const unsigned char * rreplys = sqlite3_column_text(stmt,38);
            const unsigned char * rforwards = sqlite3_column_text(stmt,39);
            
            //            const unsigned char * WeiBotype = sqlite3_column_text(stmt,40);
            
            const unsigned char * imageOriginalM = sqlite3_column_text(stmt,41);
            const unsigned char * imageSmallM = sqlite3_column_text(stmt,42);
            
            const unsigned char * rimageOriginalM = sqlite3_column_text(stmt,43);
            const unsigned char * rimageSmallM = sqlite3_column_text(stmt,44);
            
            const unsigned char * aid = sqlite3_column_text(stmt,45);
            const unsigned char * raid = sqlite3_column_text(stmt,46);
            
            const unsigned char * titleContent = sqlite3_column_text(stmt,47);
            const unsigned char * rtitleContent = sqlite3_column_text(stmt,48);
            
            const unsigned char * musicurl = sqlite3_column_text(stmt,49);
            const unsigned char * rmusicurl = sqlite3_column_text(stmt,50);
            
            const unsigned char * olink = sqlite3_column_text(stmt,51);
            const unsigned char * rolink = sqlite3_column_text(stmt,52);
            const unsigned char * photoTitle = sqlite3_column_text(stmt,53);
            
            
            FbFeed * per = [[FbFeed alloc] init];
            
            
            
            per.tid = tid?[NSString stringWithUTF8String:(const char *)tid]:@"";
            per.uid = uid?[NSString stringWithUTF8String:(const char *)uid]:@"";
            per.userName = username?[NSString stringWithUTF8String:(const char *)username]:@"";
            per.content = content?[NSString stringWithUTF8String:(const char *)content]:@"";
            per.image_original_url = image_original?[NSString stringWithUTF8String:(const char *)image_original]:@"";
            per.image_small_url = image_small?[NSString stringWithUTF8String:(const char *)image_small]:@"";
            per.from = from?[NSString stringWithUTF8String:(const char *)from]:@"";
            per.type = type?[NSString stringWithUTF8String:(const char *)type]:@"";
            per.sort = sort?[NSString stringWithUTF8String:(const char *)sort]:@"";
            per.sortId = sortId?[NSString stringWithUTF8String:(const char *)sortId]:@"";
            per.jing_lng = jing_lng?[NSString stringWithUTF8String:(const char *)jing_lng]:@"";
            per.wei_lat = wei_lat?[NSString stringWithUTF8String:(const char *)wei_lat]:@"";
            per.locality = locality?[NSString stringWithUTF8String:(const char *)locality]:@"";
            per.face_original_url = face_original?[NSString stringWithUTF8String:(const char *)face_original]:@"";
            per.face_small_url = face_small?[NSString stringWithUTF8String:(const char *)face_small]:@"";
            per.rootFlg = rootFlg;
            per.imageFlg = imageFlg;
            per.dateline = dateline?[NSString stringWithUTF8String:(const char *)dateline]:@"";
            per.replys = replys?[NSString stringWithUTF8String:(const char *)replys]:@"";
            per.forwards = forwards?[NSString stringWithUTF8String:(const char *)forwards]:@"";
            
            
            
            per.rtid = rtid?[NSString stringWithUTF8String:(const char *)rtid]:@"";
            per.ruid = ruid?[NSString stringWithUTF8String:(const char *)ruid]:@"";
            per.ruserName = rusername?[NSString stringWithUTF8String:(const char *)rusername]:@"";
            per.rcontent = rcontent?[NSString stringWithUTF8String:(const char *)rcontent]:@"";
            per.rimage_original_url = rimage_original?[NSString stringWithUTF8String:(const char *)rimage_original]:@"";
            per.rimage_small_url = rimage_small?[NSString stringWithUTF8String:(const char *)rimage_small]:@"";
            per.rfrom = rfrom?[NSString stringWithUTF8String:(const char *)rfrom]:@"";
            per.rtype = rtype?[NSString stringWithUTF8String:(const char *)rtype]:@"";
            per.rsort = rsort?[NSString stringWithUTF8String:(const char *)rsort]:@"";
            per.rsortId = rsortId?[NSString stringWithUTF8String:(const char *)rsortId]:@"";
            per.rjing_lng = rjing_lng?[NSString stringWithUTF8String:(const char *)rjing_lng]:@"";
            per.rwei_lat = rwei_lat?[NSString stringWithUTF8String:(const char *)rwei_lat]:@"";
            per.rlocality = rlocality?[NSString stringWithUTF8String:(const char *)rlocality]:@"";
            per.rface_original_url = rface_original?[NSString stringWithUTF8String:(const char *)rface_original]:@"";
            per.rface_small_url = rface_small?[NSString stringWithUTF8String:(const char *)rface_small]:@"";
            per.rrootFlg = rrootFlg;
            per.rimageFlg = rimageFlg;
            per.rdateline = rdateline?[NSString stringWithUTF8String:(const char *)rdateline]:@"";
            per.rreplys = rreplys?[NSString stringWithUTF8String:(const char *)rreplys]:@"";
            per.rforwards = rforwards?[NSString stringWithUTF8String:(const char *)rforwards]:@"";
            
            per.image_original_url_m = imageOriginalM?[NSString stringWithUTF8String:(const char *)imageOriginalM]:@"";
            per.image_small_url_m = imageSmallM?[NSString stringWithUTF8String:(const char *)imageSmallM]:@"";
            
            per.rimage_original_url_m = rimageOriginalM?[NSString stringWithUTF8String:(const char *)rimageOriginalM]:@"";
            per.rimage_small_url_m = rimageSmallM?[NSString stringWithUTF8String:(const char *)rimageSmallM]:@"";
            
            per.photo.aid = aid?[NSString stringWithUTF8String:(const char *)aid]:@"";
            per.rphoto.aid = raid?[NSString stringWithUTF8String:(const char *)raid]:@"";
            
            
            per.title_content = titleContent?[NSString stringWithUTF8String:(const char *)titleContent]:@"";
            per.rtitle_content = rtitleContent?[NSString stringWithUTF8String:(const char *)rtitleContent]:@"";
            
            per.musicurl = musicurl?[NSString stringWithUTF8String:(const char *)musicurl]:@"";
            per.rmusicurl = rmusicurl?[NSString stringWithUTF8String:(const char *)rmusicurl]:@"";
            
            per.olink = olink?[NSString stringWithUTF8String:(const char *)olink]:@"";
            per.rolink = rolink?[NSString stringWithUTF8String:(const char *)rolink]:@"";
            per.photo_title = photoTitle?[NSString stringWithUTF8String:(const char *)photoTitle]:@"";
            
            
            
            
            [perArray addObject:per];
        }
        sqlite3_finalize(stmt);
        return perArray;
    }else
    {
        return [NSMutableArray array];
    }
}


+(int)addWeiBoContentWithInfo:(FbFeed *)info WithType:(int)theType
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db,"insert into newcontent(tid,uid,username,content,imageOriginal,imageSmall,froms,type,sort,sortId,jingLng,weiLat,locality,faceOriginal,faceSmall,rootFlg,imageFlg,dateLine,replys,forwards,ruid,rtid,rusername,rcontent,rimageOriginal,rimageSmall,rfroms,rtype,rsort,rsortId,rjingLng,rweiLat,rlocality,rfaceOriginal,rfaceSmall,rrootFlg,rimageFlg,rdateLine,rreplys,rforwards,WeiBoType,imageOriginalM,imageSmallM,rimageOriginalM,rimageSmallM,aid,raid,titleContent,musicurl,olink,rtitleContent,rmusicurl,rolink,photoTitle) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", -1,&stmt,nil);
    
    
    
    
    sqlite3_bind_text(stmt,1,[info.tid UTF8String],-1,nil);
    sqlite3_bind_text(stmt,2,[info.uid UTF8String],-1,nil);
    sqlite3_bind_text(stmt,3,[info.userName UTF8String],-1,nil);
    sqlite3_bind_text(stmt,4,[info.content UTF8String],-1,nil);
    sqlite3_bind_text(stmt,5,[info.image_original_url UTF8String],-1,nil);
    sqlite3_bind_text(stmt,6,[info.image_small_url UTF8String],-1,nil);
    sqlite3_bind_text(stmt,7,[info.from UTF8String],-1,nil);
    sqlite3_bind_text(stmt,8,[info.type UTF8String],-1,nil);
    sqlite3_bind_text(stmt,9,[info.sort UTF8String],-1,nil);
    sqlite3_bind_text(stmt,10,[info.sortId UTF8String],-1,nil);
    sqlite3_bind_text(stmt,11,[info.jing_lng UTF8String],-1,nil);
    sqlite3_bind_text(stmt,12,[info.wei_lat UTF8String],-1,nil);
    sqlite3_bind_text(stmt,13,[info.locality UTF8String],-1,nil);
    sqlite3_bind_text(stmt,14,[info.face_original_url UTF8String],-1,nil);
    sqlite3_bind_text(stmt,15,[info.face_small_url UTF8String],-1,nil);
    sqlite3_bind_int(stmt,16,info.rootFlg?1:0);
    sqlite3_bind_int(stmt,17,info.imageFlg?1:0);
    sqlite3_bind_text(stmt,18,[info.dateline UTF8String],-1,nil);
    sqlite3_bind_text(stmt,19,[info.replys UTF8String],-1,nil);
    sqlite3_bind_text(stmt,20,[info.forwards UTF8String],-1,nil);
    
    
    
    sqlite3_bind_text(stmt,21,[info.ruid UTF8String],-1,nil);
    sqlite3_bind_text(stmt,22,[info.rtid UTF8String],-1,nil);
    sqlite3_bind_text(stmt,23,[info.ruserName UTF8String],-1,nil);
    sqlite3_bind_text(stmt,24,[info.rcontent UTF8String],-1,nil);
    sqlite3_bind_text(stmt,25,[info.rimage_original_url UTF8String],-1,nil);
    sqlite3_bind_text(stmt,26,[info.rimage_small_url UTF8String],-1,nil);
    sqlite3_bind_text(stmt,27,[info.rfrom UTF8String],-1,nil);
    sqlite3_bind_text(stmt,28,[info.rtype UTF8String],-1,nil);
    sqlite3_bind_text(stmt,29,[info.rsort UTF8String],-1,nil);
    sqlite3_bind_text(stmt,30,[info.rsortId UTF8String],-1,nil);
    sqlite3_bind_text(stmt,31,[info.rjing_lng UTF8String],-1,nil);
    sqlite3_bind_text(stmt,32,[info.rwei_lat UTF8String],-1,nil);
    sqlite3_bind_text(stmt,33,[info.rlocality UTF8String],-1,nil);
    sqlite3_bind_text(stmt,34,[info.rface_original_url UTF8String],-1,nil);
    sqlite3_bind_text(stmt,35,[info.rface_small_url UTF8String],-1,nil);
    sqlite3_bind_int(stmt,36,info.rrootFlg?1:0);
    sqlite3_bind_int(stmt,37,info.rimageFlg?1:0);
    sqlite3_bind_text(stmt,38,[info.rdateline UTF8String],-1,nil);
    sqlite3_bind_text(stmt,39,[info.rreplys UTF8String],-1,nil);
    sqlite3_bind_text(stmt,40,[info.rforwards UTF8String],-1,nil);
    sqlite3_bind_int(stmt,41,theType);
    
    sqlite3_bind_text(stmt,42,[info.image_original_url_m UTF8String],-1,nil);
    sqlite3_bind_text(stmt,43,[info.image_small_url_m UTF8String],-1,nil);
    
    sqlite3_bind_text(stmt,44,[info.rimage_original_url_m UTF8String],-1,nil);
    sqlite3_bind_text(stmt,45,[info.rimage_small_url_m UTF8String],-1,nil);
    
    sqlite3_bind_text(stmt,46,[info.photo.aid UTF8String],-1,nil);
    sqlite3_bind_text(stmt,47,[info.rphoto.aid UTF8String],-1,nil);
    
    sqlite3_bind_text(stmt,48,[info.title_content UTF8String],-1,nil);
    sqlite3_bind_text(stmt,49,[info.musicurl UTF8String],-1,nil);
    
    sqlite3_bind_text(stmt,50,[info.olink UTF8String],-1,nil);
    sqlite3_bind_text(stmt,51,[info.rtitle_content UTF8String],-1,nil);
    
    sqlite3_bind_text(stmt,52,[info.rmusicurl UTF8String],-1,nil);
    sqlite3_bind_text(stmt,53,[info.rolink UTF8String],-1,nil);
    sqlite3_bind_text(stmt,54,[info.photo_title UTF8String],-1,nil);
    
    
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return  result;
    
}


+(FbFeed *)findPersonSaveByTid:(int)thePage
{
    
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    int result = sqlite3_prepare_v2(db, "select * from newcontent where Page=?",-1,&stmt, nil);
    if (result == SQLITE_OK)
    {
        //        sqlite3_bind_text(stmt, 1,[theQuarter UTF8String], -1, nil);
        sqlite3_bind_int(stmt,1,thePage);
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            const unsigned char * tid = sqlite3_column_text(stmt,0);
            const unsigned char * uid = sqlite3_column_text(stmt,1);
            const unsigned char * username = sqlite3_column_text(stmt,2);
            const unsigned char * content = sqlite3_column_text(stmt,3);
            const unsigned char * image_original = sqlite3_column_text(stmt,4);
            const unsigned char * image_small = sqlite3_column_text(stmt,5);
            const unsigned char * from = sqlite3_column_text(stmt,6);
            const unsigned char * type = sqlite3_column_text(stmt,7);
            const unsigned char * sort = sqlite3_column_text(stmt,8);
            const unsigned char * sortId = sqlite3_column_text(stmt,9);
            const unsigned char * jing_lng = sqlite3_column_text(stmt,10);
            const unsigned char * wei_lat = sqlite3_column_text(stmt,11);
            const unsigned char * locality = sqlite3_column_text(stmt,12);
            const unsigned char * face_original = sqlite3_column_text(stmt,13);
            const unsigned char * face_small = sqlite3_column_text(stmt,14);
            BOOL rootFlg = sqlite3_column_int(stmt,15);
            BOOL imageFlg = sqlite3_column_int(stmt,16);
            const unsigned char * dateline = sqlite3_column_text(stmt,17);
            const unsigned char * replys = sqlite3_column_text(stmt,18);
            const unsigned char * forwards = sqlite3_column_text(stmt,19);
            
            const unsigned char * rtid = sqlite3_column_text(stmt,20);
            const unsigned char * ruid = sqlite3_column_text(stmt,21);
            const unsigned char * rusername = sqlite3_column_text(stmt,22);
            const unsigned char * rcontent = sqlite3_column_text(stmt,23);
            const unsigned char * rimage_original = sqlite3_column_text(stmt,24);
            const unsigned char * rimage_small = sqlite3_column_text(stmt,25);
            const unsigned char * rfrom = sqlite3_column_text(stmt,26);
            const unsigned char * rtype = sqlite3_column_text(stmt,27);
            const unsigned char * rsort = sqlite3_column_text(stmt,28);
            const unsigned char * rsortId = sqlite3_column_text(stmt,29);
            const unsigned char * rjing_lng = sqlite3_column_text(stmt,30);
            const unsigned char * rwei_lat = sqlite3_column_text(stmt,31);
            const unsigned char * rlocality = sqlite3_column_text(stmt,32);
            const unsigned char * rface_original = sqlite3_column_text(stmt,33);
            const unsigned char * rface_small = sqlite3_column_text(stmt,34);
            BOOL rrootFlg = sqlite3_column_int(stmt,35);
            BOOL rimageFlg = sqlite3_column_int(stmt,36);
            const unsigned char * rdateline = sqlite3_column_text(stmt,37);
            const unsigned char * rreplys = sqlite3_column_text(stmt,38);
            const unsigned char * rforwards = sqlite3_column_text(stmt,39);
            
            //            const unsigned char * WeiBotype = sqlite3_column_text(stmt,40);
            const unsigned char * imageOriginalM = sqlite3_column_text(stmt,41);
            const unsigned char * imageSmallM = sqlite3_column_text(stmt,42);
            
            const unsigned char * rimageOriginalM = sqlite3_column_text(stmt,43);
            const unsigned char * rimageSmallM = sqlite3_column_text(stmt,44);
            
            
            const unsigned char * aid = sqlite3_column_text(stmt,45);
            const unsigned char * raid = sqlite3_column_text(stmt,46);
            
            
            const unsigned char * titleContent = sqlite3_column_text(stmt,47);
            const unsigned char * rtitleContent = sqlite3_column_text(stmt,48);
            
            const unsigned char * musicurl = sqlite3_column_text(stmt,49);
            const unsigned char * rmusicurl = sqlite3_column_text(stmt,50);
            
            const unsigned char * olink = sqlite3_column_text(stmt,51);
            const unsigned char * rolink = sqlite3_column_text(stmt,52);
            const unsigned char * photoTitle = sqlite3_column_text(stmt,53);
            
            
            FbFeed * per = [[FbFeed alloc] init];
            
            
            
            per.tid = tid?[NSString stringWithUTF8String:(const char *)tid]:@"";
            per.uid = uid?[NSString stringWithUTF8String:(const char *)uid]:@"";
            per.userName = username?[NSString stringWithUTF8String:(const char *)username]:@"";
            per.content = content?[NSString stringWithUTF8String:(const char *)content]:@"";
            per.image_original_url = image_original?[NSString stringWithUTF8String:(const char *)image_original]:@"";
            per.image_small_url = image_small?[NSString stringWithUTF8String:(const char *)image_small]:@"";
            per.from = from?[NSString stringWithUTF8String:(const char *)from]:@"";
            per.type = type?[NSString stringWithUTF8String:(const char *)type]:@"";
            per.sort = sort?[NSString stringWithUTF8String:(const char *)sort]:@"";
            per.sortId = sortId?[NSString stringWithUTF8String:(const char *)sortId]:@"";
            per.jing_lng = jing_lng?[NSString stringWithUTF8String:(const char *)jing_lng]:@"";
            per.wei_lat = wei_lat?[NSString stringWithUTF8String:(const char *)wei_lat]:@"";
            per.locality = locality?[NSString stringWithUTF8String:(const char *)locality]:@"";
            per.face_original_url = face_original?[NSString stringWithUTF8String:(const char *)face_original]:@"";
            per.face_small_url = face_small?[NSString stringWithUTF8String:(const char *)face_small]:@"";
            per.rootFlg = rootFlg;
            per.imageFlg = imageFlg;
            per.dateline = dateline?[NSString stringWithUTF8String:(const char *)dateline]:@"";
            per.replys = replys?[NSString stringWithUTF8String:(const char *)replys]:@"";
            per.forwards = forwards?[NSString stringWithUTF8String:(const char *)forwards]:@"";
            
            
            
            per.rtid = rtid?[NSString stringWithUTF8String:(const char *)rtid]:@"";
            per.ruid = ruid?[NSString stringWithUTF8String:(const char *)ruid]:@"";
            per.ruserName = rusername?[NSString stringWithUTF8String:(const char *)rusername]:@"";
            per.rcontent = rcontent?[NSString stringWithUTF8String:(const char *)rcontent]:@"";
            per.rimage_original_url = rimage_original?[NSString stringWithUTF8String:(const char *)rimage_original]:@"";
            per.rimage_small_url = rimage_small?[NSString stringWithUTF8String:(const char *)rimage_small]:@"";
            per.rfrom = rfrom?[NSString stringWithUTF8String:(const char *)rfrom]:@"";
            per.rtype = rtype?[NSString stringWithUTF8String:(const char *)rtype]:@"";
            per.rsort = rsort?[NSString stringWithUTF8String:(const char *)rsort]:@"";
            per.rsortId = rsortId?[NSString stringWithUTF8String:(const char *)rsortId]:@"";
            per.rjing_lng = rjing_lng?[NSString stringWithUTF8String:(const char *)rjing_lng]:@"";
            per.rwei_lat = rwei_lat?[NSString stringWithUTF8String:(const char *)rwei_lat]:@"";
            per.rlocality = rlocality?[NSString stringWithUTF8String:(const char *)rlocality]:@"";
            per.rface_original_url = rface_original?[NSString stringWithUTF8String:(const char *)rface_original]:@"";
            per.rface_small_url = rface_small?[NSString stringWithUTF8String:(const char *)rface_small]:@"";
            per.rrootFlg = rrootFlg;
            per.rimageFlg = rimageFlg;
            per.rdateline = rdateline?[NSString stringWithUTF8String:(const char *)rdateline]:@"";
            per.rreplys = rreplys?[NSString stringWithUTF8String:(const char *)rreplys]:@"";
            per.rforwards = rforwards?[NSString stringWithUTF8String:(const char *)rforwards]:@"";
            
            
            per.image_original_url_m = imageOriginalM?[NSString stringWithUTF8String:(const char *)imageOriginalM]:@"";
            per.image_small_url_m = imageSmallM?[NSString stringWithUTF8String:(const char *)imageSmallM]:@"";
            
            per.rimage_original_url_m = rimageOriginalM?[NSString stringWithUTF8String:(const char *)rimageOriginalM]:@"";
            per.rimage_small_url_m = rimageSmallM?[NSString stringWithUTF8String:(const char *)rimageSmallM]:@"";
            
            per.photo.aid = aid?[NSString stringWithUTF8String:(const char *)aid]:@"";
            per.rphoto.aid = raid?[NSString stringWithUTF8String:(const char *)raid]:@"";
            
            
            
            per.title_content = titleContent?[NSString stringWithUTF8String:(const char *)titleContent]:@"";
            per.rtitle_content = rtitleContent?[NSString stringWithUTF8String:(const char *)rtitleContent]:@"";
            
            per.musicurl = musicurl?[NSString stringWithUTF8String:(const char *)musicurl]:@"";
            per.rmusicurl = rmusicurl?[NSString stringWithUTF8String:(const char *)rmusicurl]:@"";
            
            per.olink = olink?[NSString stringWithUTF8String:(const char *)olink]:@"";
            per.rolink = rolink?[NSString stringWithUTF8String:(const char *)rolink]:@"";
            per.photo_title = photoTitle?[NSString stringWithUTF8String:(const char *)photoTitle]:@"";
            
            
            return per;
        }
    }else
    {
        NSLog(@"failed with result:%d",result);
    }
    sqlite3_finalize(stmt);
    return nil;
}

+(int)updateReplys:(NSString *)theReplys WithTid:(NSString *)theTid
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db, "UPDATE newcontent SET replys=? WHERE tid=?", -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1, [theReplys UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2, [theTid UTF8String], -1, nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    NSLog(@"update replys result = %d",result);
    return result;
}

+(int)updateForwards:(NSString *)theForwards WithTid:(NSString *)theTid
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db, "UPDATE newcontent SET forwards=? WHERE tid=?", -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1, [theForwards UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2, [theTid UTF8String], -1, nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    NSLog(@"update replys result = %d",result);
    return result;
}



+(int)deleteAllByType:(int)theType
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db, "delete from newcontent where WeiBotype=?", -1, &stmt, nil);
    //    sqlite3_bind_text(stmt, 1, [theQQ UTF8String], -1, nil);
    sqlite3_bind_int(stmt,1,theType);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    NSLog(@"delete error = %d",result);
    return result;
}

+(int)deleteWeiBoBytId:(NSString *)thetId
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db, "delete from newcontent where tid=?", -1, &stmt, nil);
    //    sqlite3_bind_text(stmt, 1, [theQQ UTF8String], -1, nil);
    sqlite3_bind_text(stmt,1,[thetId UTF8String],-1,nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    NSLog(@"delete error = %d",result);
    return result;
}



+(int)deleteWeiBoByContent:(NSString *)theContent
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    sqlite3_prepare_v2(db, "delete from newcontent where tid=?", -1, &stmt, nil);
    //    sqlite3_bind_text(stmt, 1, [theQQ UTF8String], -1, nil);
    sqlite3_bind_text(stmt,1,[theContent UTF8String],-1,nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
}



@end


























