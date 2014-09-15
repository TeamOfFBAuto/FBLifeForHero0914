//
//  FBModel.m
//  FbLife
//
//  Created by soulnear on 13-11-14.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "FBModel.h"
#import "FbFeed.h"
#import "Extension.h"
#import "FbNewsFeed.h"
#import "PhotoFeed.h"
#import "BlogFeed.h"

@implementation FBModel
@synthesize delegate;
@synthesize myRequest = _myRequest;


-(ASIHTTPRequest *)loadDataWithUrl:(NSString *)url
{
    self.myRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    self.myRequest.delegate = self;
    
    return self.myRequest;
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray * data_array = [[NSMutableArray alloc] init];
    
    NSDictionary * rootObject = [[NSDictionary alloc] initWithDictionary:[request.responseData objectFromJSONData]];
    
    NSString *errcode =[NSString stringWithFormat:@"%@",[rootObject objectForKey:ERRCODE]];
    
    
    if ([@"0" isEqualToString:errcode])
    {
        NSDictionary* userinfo = [rootObject objectForKey:@"weiboinfo"];
        
        if ([userinfo isEqual:[NSNull null]])
        {
            if (delegate && [delegate respondsToSelector:@selector(returnRequestFinishedData:Request:)])
            {
                [delegate returnRequestFinishedData:data_array Request:request];
            }
            
            return;
        }else
        {
            NSArray *keys;
            int i, count;
            id key, value;
            keys = [userinfo allKeys];
            
            //给keys排序降序
            NSMutableArray *arr11 = [[NSMutableArray alloc]init];
            for (int i=0; i<keys.count; i++)
            {
                [arr11 addObject:[NSNumber numberWithInt:[[keys objectAtIndex: i] intValue]]];
            }
            
            NSArray * arr1 = [NSArray arrayWithArray:arr11];
            arr1=  [ arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj2 compare:obj1];
            } ];
            
            count = [arr1 count];
            
            
            
            for (i = 0; i < count; i++)
            {
                FbFeed *obj = [[FbFeed alloc] init];
                
                key = [NSString stringWithFormat:@"%@",[arr1 objectAtIndex: i]];
                
                value = [userinfo objectForKey:key];
                
                
                
                //解析微博内容
                [obj setTid:[value objectForKey:FB_TID]];
                [obj setUid:[value objectForKey:FB_UID]];
                [obj setUserName:[value objectForKey:FB_USERNAME]];
                [obj setContent: [zsnApi imgreplace:[value objectForKey:FB_CONTENT]]];
                
                if ([[value objectForKey:FB_IMAGEID] isEqualToString:@"0"])
                {
                    [obj setNsImageFlg:@"0"];
                }else
                {
                    [obj setNsImageFlg:@"1"];
                }
                
                
                obj.image_original_url_m = [value objectForKey:@"image_original_m"];
                
                obj.image_small_url_m = [value objectForKey:@"image_small_m"];
                
                
                //是否有图片
                if ([obj imageFlg])
                {
                    [obj setImage_original_url:[value objectForKey:FB_IMAGE_ORIGINAL]];
                    [obj setImage_small_url:[value objectForKey:FB_IMAGE_SMALL]];
                }
                
                [obj setFrom:[zsnApi exchangeFrom:[value objectForKey:FB_FROM]]];
                [obj setNsType:[value objectForKey:FB_TYPE]];
                obj.sort = [value objectForKey:FB_SORT];
                obj.sortId = [value objectForKey:FB_SORTID];
                [obj setJing_lng:[value objectForKey:FB_JING_LNG]];
                [obj setWei_lat:[value objectForKey:FB_WEI_LAT]];
                [obj setLocality:[value objectForKey:FB_LOCALITY]];
                [obj setFace_original_url:[value objectForKey:FB_FACE_ORIGINAL]];
                [obj setFace_small_url:[value objectForKey:FB_FACE_SMALL]];
                [obj setNsRootFlg:[value objectForKey:FB_ROOTTID]];
                [obj setDateline:[value objectForKey:FB_DATELINE]];//[personal timestamp:[value objectForKey:FB_DATELINE]]];
                [obj setReplys:[value objectForKey:FB_REPLYS]];
                [obj setForwards:[value objectForKey:FB_FORWARDS]];
                [obj setRootFlg:NO];
                
                //解析其他类型
                
                if (([obj.sort isEqualToString:@"6"] || [obj.sort isEqualToString:@"7"])&&[obj.type isEqualToString:@"first"])
                {
                    //解析新闻评论
                    NSDictionary *exjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                    
                    Extension * ex=[[Extension alloc]initWithJson:exjson];
                    
                    [obj setExten:ex];
                    
                    [obj setContent:[NSString stringWithFormat:@"我对新闻<a href=\"fb.news://PhotoDetail/id=%@/sort=%@\">%@</a>发表了评论:%@",obj.sortId,obj.sort,ex.title,obj.content]];
                    
                    
                }else if([obj.sort isEqualToString:@"3"]&&[obj.type isEqualToString:@"first"])
                {
                    //解析图集
                    NSDictionary *photojson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
                    
                    PhotoFeed * photo=[[PhotoFeed alloc]initWithJson:photojson];
                    
                    [obj setPhoto:photo];
                    
                    [obj setContent:[NSString stringWithFormat:@"我在图集<a href=\"fb://PhotoDetail/%@\">%@</a>上传了新图片",photo.aid,photo.title]];
                    
                    [obj setImageFlg:YES];
                    
                    [obj setImage_small_url_m: photo.image_string];
                    
                    [obj setImage_original_url_m:photo.image_string];
                    
                }else if([obj.sort isEqualToString:@"2"]&&[obj.type isEqualToString:@"first"])
                {
                    //解析文集
                    NSDictionary *blogjson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
                    
                    BlogFeed * blog=[[BlogFeed alloc]initWithJson:blogjson];
                    
                    [obj setBlog:blog];
                    
                    //   href=\"fb://BlogDetail/%@\"
                    [obj setContent:[NSString stringWithFormat:@"我发表文集<a href=\"fb://BlogDetail/%@\">%@</a>:%@",blog.blogid,blog.title,blog.content]];
                    
                    [obj setImageFlg:blog.photoFlg];
                    
                    if (blog.photoFlg)
                    {
                        [obj setImage_small_url_m:blog.photo];
                        [obj setImage_original_url_m:blog.photo];
                    }
                    
                    
                }else if([obj.sort isEqualToString:@"4"]&&[obj.type isEqualToString:@"first"])
                {
                    //论坛帖子转发为微博
                    NSDictionary * newsForwoadjson= [[value objectForKey:FB_CONTENT] objectFromJSONString];
                    
                    FbNewsFeed * fbnews= [[FbNewsFeed alloc] initWithJson:newsForwoadjson];
                    
                    [obj setFbNews:fbnews];
                    
                    [obj setContent:[NSString stringWithFormat:@"转发论坛帖子<a href=\"fb://tieziDetail/%@/%@/%@/%@\">%@</a>:%@",fbnews.bbsid,fbnews.bbsid,@"999",@"999",fbnews.title,fbnews.content]];
                    
                    
                    NSLog(@"tid --  %@  --  content ---  %@",obj.tid,obj.content);
                    
                    
                    [obj setImageFlg:fbnews.photoFlg];
                    
                    if (fbnews.photoFlg)
                    {
                        [obj setImage_small_url_m:fbnews.photo];// [NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                        [obj setImage_original_url_m:fbnews.photo];// [NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                        
                    }
                    
                    
                    
                }else if([obj.sort isEqualToString:@"5"]&&[obj.type isEqualToString:@"first"])
                {
                    //论坛分享
                    NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                    Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                    [obj setExten:ex];
                    [obj setRootFlg:YES];
                    NSLog(@"论坛分享的内容 -----  %@",ex.forum_content);
                    [obj setRcontent:  [NSString stringWithFormat:@"%@:<a href=\"fb://BlogDetail/%@\">%@</a>:%@",ex.author,ex.authorid,ex.title,ex.forum_content]];
                    [obj setRsort:@"5"];
                    [obj setRsortId:ex.authorid];
                    [obj setRimageFlg:ex.photoFlg];
                    [obj setRimage_small_url_m:ex.photo];
                    [obj setRimage_original_url_m:ex.photo];
                }else if ([obj.sort isEqualToString:@"8"]&&[obj.type isEqualToString:@"first"])
                {
                    NSDictionary *exjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                    Extension * ex=[[Extension alloc]initWithJson:exjson];
                    [obj setExten:ex];
                    
                    [obj setImageFlg:ex.photoFlg];
                    
                    [obj setImage_small_url_m:ex.photo];
                    
                    [obj setImage_original_url_m:ex.photo];
                    
                    
                    [obj setContent:[NSString stringWithFormat:@"分享新闻<a href=\"fb://PhotoDetail/%@\">%@</a>:%@",ex.authorid,ex.title,obj.content]];
                }else if([obj.sort isEqualToString:@"10"]&&[obj.type isEqualToString:@"first"])
                {
                    //资源分享
                    NSDictionary *newsSendjson= [[value objectForKey:FB_EXTENSION] objectFromJSONString];
                    Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                    [obj setExten:ex];
                    [obj setRootFlg:YES];
                    NSLog(@"论坛分享的内容 -----  %@",ex.forum_content);
                    [obj setRcontent:[zsnApi ShareResourceContent:ex.forum_content]];
                    [obj setRsort:@"10"];
                    [obj setRsortId:ex.authorid];
                    [obj setRimageFlg:ex.photoFlg];
                    [obj setRimage_small_url_m:ex.photo];
                    [obj setRimage_original_url_m:ex.photo];
                }
                
                
                
                while ([obj.content rangeOfString:@"&nbsp;"].length)
                {
                    obj.content = [obj.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                }
                
                
                
                NSMutableString * tempString = [NSMutableString stringWithFormat:@"%@",obj.content];
                
                if ([tempString rangeOfString:@"<a>#"].length)
                {
                    NSString * insertString = [NSString stringWithFormat:@" href=\"fb://BlogDetail/%@\"",obj.tid];
                    [tempString insertString:insertString atIndex:[obj.content rangeOfString:@"<a>#"].location+2];
                    obj.content = [NSString stringWithString:tempString];
                }
                

                while ([obj.content rangeOfString:@"<a id="].length)
                {
                    obj.content = [zsnApi exchangeString:obj.content];
                }
                
                
                
                //解析转发内容
                if (![[value objectForKey:@"roottid"] isEqualToString:@"0"] )
                {
                    [obj setRootFlg:YES];
                    
                    NSDictionary * followinfo= [value objectForKey:@"followinfo"];
                    
                    if (followinfo==nil)
                    {
                        //原微博已删除
                        [obj setRcontent:NS_WEIBO_DEL];
                    }else
                    {
                        //解析转发的微博内容
                        [obj setRtid:[followinfo objectForKey:FB_TID]];
                        [obj setRuid:[followinfo objectForKey:FB_UID]];
                        [obj setRuserName:[followinfo objectForKey:FB_USERNAME]];
                        
                        [obj setRcontent:[ NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:%@",obj.ruserName,[zsnApi imgreplace:[followinfo objectForKey:FB_CONTENT]]]];
                        
                        if ([[followinfo objectForKey:FB_IMAGEID] isEqualToString:@"0"])
                        {
                            [obj setRNsImageFlg:@"0"];
                        }else
                        {
                            [obj setRNsImageFlg:@"1"];
                        }
                        
                        
                        obj.rimage_original_url_m = [followinfo objectForKey:@"image_original_m"];
                        
                        obj.rimage_small_url_m = [followinfo objectForKey:@"image_small_m"];
                        
                        
                        if ([obj rimageFlg])
                        {
                            [obj setRimage_original_url:[followinfo objectForKey:FB_IMAGE_ORIGINAL]];
                            [obj setRimage_small_url:[followinfo objectForKey:FB_IMAGE_SMALL]];
                        }
                        [obj setRfrom:[followinfo objectForKey:FB_FROM]];
                        [obj setRNsType:[followinfo objectForKey:FB_TYPE]];
                        obj.rsort = [followinfo objectForKey:FB_SORT];
                        obj.rsortId = [followinfo objectForKey:FB_SORTID];
                        [obj setRjing_lng:[followinfo objectForKey:FB_JING_LNG]];
                        [obj setRwei_lat:[followinfo objectForKey:FB_WEI_LAT]];
                        [obj setRlocality:[followinfo objectForKey:FB_LOCALITY]];
                        [obj setRface_original_url:[followinfo objectForKey:FB_FACE_ORIGINAL]];
                        [obj setRface_small_url:[followinfo objectForKey:FB_FACE_SMALL]];
                        [obj setRNsRootFlg:[followinfo objectForKey:FB_ROOTTID]];
                        [obj setRdateline:[followinfo objectForKey:FB_DATELINE]];
                        [obj setRreplys:[followinfo objectForKey:FB_REPLYS]];
                        [obj setRforwards:[followinfo objectForKey:FB_FORWARDS]];
                        //解析其他类型
                        if ([obj.rsort isEqualToString:@"6"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            //解析新闻评论
                            NSDictionary *exjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc]initWithJson:exjson];
                            [obj setRexten:ex];
                            [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:我对新闻<a href=\"fb://PhotoDetail/%@\">%@</a>发表了评论:%@",obj.ruserName,obj.ruserName,ex.title,obj.rcontent]];
                        }else if([obj.rsort isEqualToString:@"3"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            //解析图集
                            NSDictionary *photojson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                            PhotoFeed * photo=[[PhotoFeed alloc]initWithJson:photojson];
                            [obj setRphoto:photo];
                            [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:我在图集<a href=\"fb://PhotoDetail/%@\">%@</a>上传了新图片",obj.ruserName,photo.aid,photo.title]];
                            [obj setRimageFlg:YES];
                            [obj setRimage_small_url_m: [photo.image objectAtIndex:0]];
                            [obj setRimage_original_url_m:[photo.image objectAtIndex:0]];
                        }else if([obj.rsort isEqualToString:@"2"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            //解析文集
                            NSDictionary *blogjson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                            BlogFeed * blog=[[BlogFeed alloc]initWithJson:blogjson];
                            [obj setRblog:blog];
                            [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:我发表文集<a href=\"fb://BlogDetail/%@\">%@</a>:%@",obj.ruserName,blog.blogid,blog.title,blog.content]];
                            [obj setRimageFlg:blog.photoFlg];
                            if (blog.photoFlg) {
                                [obj setRimage_small_url_m:blog.photo];
                                [obj setRimage_original_url_m:blog.photo];
                            }
                        }else if([obj.rsort isEqualToString:@"4"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            //论坛帖子转发为微博
                            NSDictionary *newsForwoadjson= [[followinfo objectForKey:FB_CONTENT] objectFromJSONString];
                            FbNewsFeed * fbnews=[[FbNewsFeed alloc]initWithJson:newsForwoadjson];
                            [obj setRfbNews:fbnews];
                            [obj setRcontent:[NSString stringWithFormat:@"<a href=\"fb://atSomeone@/\">@%@</a>:转发论坛帖子<a href=\"fb://tieziDetail/%@/%@/%@/%@/%@\">%@</a>:%@",obj.ruserName,fbnews.bbsid,   [fbnews.title stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding],fbnews.bbsid,@"999",@"999",fbnews.title,fbnews.content]];
                            
                            [obj setRimageFlg:fbnews.photoFlg];
                            if (fbnews.photoFlg) {
                                
                                [obj setRimage_small_url_m:fbnews.photo];//[NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                                
                                [obj setRimage_original_url_m:fbnews.photo];//[NSString stringWithFormat:@"http://bbs.fblife.com/attachments/%@",fbnews.photo]];
                            }
                        }else if([obj.rsort isEqualToString:@"5"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            //论坛分享
                            
                            NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc]initWithJson:newsSendjson];
                            [obj setRexten:ex];
                            [obj setRcontent:  [NSString stringWithFormat:@"%@ %@:<a>%@</a>:%@",obj.rcontent,ex.author, ex.title,ex.forum_content]];
                            [obj setRimageFlg:ex.photoFlg];
                            [obj setRimage_small_url_m:ex.photo];
                            [obj setRimage_original_url_m:ex.photo];
                        }else if ([obj.rsort isEqualToString:@"8"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            NSDictionary *exjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc]initWithJson:exjson];
                            [obj setRexten:ex];
                            
                            
                            [obj setRimageFlg:ex.photoFlg];
                            
                            [obj setRimage_small_url_m:ex.photo];
                            
                            [obj setRimage_original_url_m:ex.photo];
                            [obj setRcontent:[NSString stringWithFormat:@"分享新闻<a href=\"fb://PhotoDetail/%@\">%@</a>:%@",ex.authorid,ex.title,obj.content]];
                        }else if([obj.rsort isEqualToString:@"10"]&&[obj.rtype isEqualToString:@"first"])
                        {
                            //资源分享
                            NSDictionary *newsSendjson= [[followinfo objectForKey:FB_EXTENSION] objectFromJSONString];
                            Extension * ex=[[Extension alloc] initWithJson:newsSendjson];
                            [obj setExten:ex];
                            [obj setRootFlg:YES];
                            [obj setRcontent:[zsnApi ShareResourceContent:ex.forum_content]];
                            [obj setRsort:@"10"];
                            [obj setRsortId:ex.authorid];
                            [obj setRimageFlg:ex.photoFlg];
                            [obj setRimage_small_url_m:ex.photo];
                            [obj setRimage_original_url_m:ex.photo];
                        }
                    }
                }
                
                while ([obj.rcontent rangeOfString:@"&nbsp;"].length)
                {
                    obj.rcontent = [obj.rcontent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                }
                
                
                
                NSMutableString * RtempString = [NSMutableString stringWithFormat:@"%@",obj.rcontent];
                
                if ([RtempString rangeOfString:@"<a>#"].length)
                {
                    NSString * insertString = [NSString stringWithFormat:@" href=\"fb://BlogDetail/%@\"",obj.rtid];
                    [RtempString insertString:insertString atIndex:[obj.rcontent rangeOfString:@"<a>#"].location+2];
                    obj.rcontent = [NSString stringWithString:RtempString];
                }
                
                while ([obj.rcontent rangeOfString:@"<a id="].length)
                {
                    obj.rcontent = [zsnApi exchangeString:obj.rcontent];
                }
                
                [data_array addObject:obj];
            }
        }
    }
    
    
    
    if (delegate && [delegate respondsToSelector:@selector(returnRequestFinishedData:Request:)])
    {
        [delegate returnRequestFinishedData:data_array Request:request];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (delegate && [delegate respondsToSelector:@selector(returnrequestFaildData:)])
    {
        [delegate returnrequestFaildData:request];
    }
}


@end
































