//
//  CarPortDetailViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-9-23.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "CarPortDetailViewController.h"
#import "summarycellview.h"
#import "newsdetailViewController.h"
#import "carinfoViewController.h"
#import "BBSfenduiViewController.h"

#define GRAYZI RGBCOLOR(89, 89, 89)
#define GRAYXIAN   RGBCOLOR(223, 223, 223)

@interface CarPortDetailViewController ()

@end

@implementation CarPortDetailViewController
@synthesize string_title;
@synthesize the_type = _the_type;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"CarPortDetailViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginEvent:@"CarPortDetailViewController"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pagesofnews=1;
    
    //车库
    
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -7:5, 3, 12, 43/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:BACK_DEFAULT_IMAGE] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
//    [back_view addSubview:button_back];
//    back_view.backgroundColor=[UIColor clearColor];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    self.navigationItem.leftBarButtonItem=back_item;
//    
//    self.navigationItem.title = self.the_type.name;
//    
//    UIColor * cc = [UIColor blackColor];
//    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        //iOS 5 new UINavigationBar custom background
//        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//    }
    
    
    self.title = self.the_type.name;
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];

    
    
    UIView *aview=[[UIView alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,20 + DEVICE_HEIGHT)];
    self.view=aview;
    aview.backgroundColor=[UIColor whiteColor];
    
    segview=[[CarPortSeg alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 33)];
    [segview setNameArray:[NSArray arrayWithObjects:@"综述",@"图片",@"资讯",@"论坛", nil]];
    
    
    [segview setType:0];
    
    
    segview.delegate=self;
    [aview addSubview:segview];
    
  
    
    //车系图片的tableview
    imagetableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 33.5, DEVICE_WIDTH, DEVICE_HEIGHT - 20-33.5-44)];
    imagetableview.separatorColor=[UIColor clearColor];
    imagetableview.delegate=self;
    imagetableview.dataSource=self;
    imagetableview.hidden=YES;
    smallimagearray=[[NSMutableArray alloc]init];
    bigimagearray=[[NSMutableArray alloc]init];
    [self.view addSubview:imagetableview];
    //车系新闻的tableview
    
    newstab=[[UITableView alloc]initWithFrame:CGRectMake(0, 33.5, DEVICE_WIDTH, DEVICE_HEIGHT - 20-33.5-44)];
    newstab.separatorColor=[UIColor clearColor];
    newstab.delegate=self;
    newstab.dataSource=self;
    newstab.hidden=YES;
    newstab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    isnewsloadsuccess=NO;
    newsofdiscriptionarray=[[NSMutableArray alloc]init];
    newsofdatearray=[[NSMutableArray alloc]init];
    newsoftitlearray=[[NSMutableArray alloc]init];
    newsofidarray=[[NSMutableArray alloc]init];
    newsofimgarray=[[NSMutableArray alloc]init];
    
    
    loadview=[[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 900, DEVICE_WIDTH, 40)];
    loadview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:newstab];
    
    
    summarytabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 33, DEVICE_WIDTH, DEVICE_HEIGHT - 20-33-44)];
    summarytabview.separatorColor=GRAYXIAN;
    summarytabview.delegate=self;
    summarytabview.dataSource=self;
    summarytabview.hidden=NO;
    summarytabview.separatorColor=[UIColor clearColor];
    summarayarrayinfo=[[NSArray alloc]init];
    [self.view addSubview:summarytabview];
    
    
    
    
    _picmodel=[[PictureModel alloc]init];
    _newsmodel=[[NewsModel alloc]init];
    _newsmodel.delegate=self;
    _summarymodel=[[SummaryModel alloc]init];
    _summarymodel.delegate=self;
    [_summarymodel startloaddatawithwords:self.the_type.words];

 	// Do any additional setup after loading the view.
}
#pragma mark-tableviewdelegateAndDatesource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num=0;
    if (tableView==imagetableview)
    {
        num= 1;

    }if (tableView==newstab)
    {
        num= 1;

    }
    if (tableView==summarytabview)
    {
        num= 2;
    }
    return num;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num=0;
    if (tableView==imagetableview)
    {
        num = smallimagearray.count%3?smallimagearray.count/3+1:smallimagearray.count/3;
    }
   if (tableView==newstab)
   {
        num= newsofdiscriptionarray.count;
   }
    if (tableView==summarytabview)
    {
        if (section==0)
        {
            num=0;
        }else
        {
            num=summarayarrayinfo.count;
        }
    }
    return num;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int num=0;
    if (tableView==imagetableview)
    {
        num = [self heightFor:154/2-4];
    }
    if (tableView==newstab)
    {
        num= 78;
    }
    if (tableView==summarytabview)
    {
        num=110/2;
    }
    return num;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==summarytabview)
    {
        if (section==0)
        {
            UIView *aviews=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 90)];
            aviews.backgroundColor=RGBCOLOR(245, 245, 245);
            
            AsyncImageView *_imgV=[[AsyncImageView alloc]initWithFrame:CGRectMake(5, 10, 105, 70)];
            [_imgV loadImageFromURL:self.the_type.photo withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
            [aviews addSubview:_imgV];
            
            UILabel *label_tit=[[UILabel alloc]initWithFrame:CGRectMake(120, 10, 200, 25)];
            label_tit.text=self.the_type.name;
            [aviews addSubview:label_tit];
            label_tit.numberOfLines=0;
            label_tit.font=[UIFont systemFontOfSize:15];
            label_tit.backgroundColor=[UIColor clearColor];
            
            
            UILabel *label_chicun=[[UILabel alloc]initWithFrame:CGRectMake(120, 35, 200, 20)];
            label_chicun.text=[NSString stringWithFormat:@"尺寸：%@",self.the_type.size];
            label_chicun.textColor=GRAYZI;
            [aviews addSubview:label_chicun];
            label_chicun.numberOfLines=0;
            label_chicun.font=[UIFont systemFontOfSize:14];
            label_chicun.backgroundColor=[UIColor clearColor];
            
            
            UILabel *label_price=[[UILabel alloc]initWithFrame:CGRectMake(120, 58, 200, 20)];
            
            
            NSString *string_qujian=[NSString stringWithFormat:@"指导价:%@-%@万",[personal getwanwithstring: self.the_type.series_price_min ],[personal getwanwithstring: self.the_type.series_price_max ]];
            
            if (IOS_VERSION>=6)
            {
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:string_qujian];
                [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(230, 0, 18) range:NSMakeRange(4, string_qujian.length-4)];
                [str addAttribute:NSForegroundColorAttributeName value:GRAYZI range:NSMakeRange(0, 4)];
                [str addAttribute:NSForegroundColorAttributeName value:GRAYZI range:NSMakeRange(string_qujian.length-1, 1)];
                
                label_price.backgroundColor=[UIColor clearColor];
                label_price.attributedText=str;

            }else
            {
                label_price.text=string_qujian;
            }
             label_price.font=[UIFont systemFontOfSize:14];
            [aviews addSubview:label_price];
    
            return aviews;
        }else
        {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 25)];
            label.backgroundColor=RGBCOLOR(227, 227, 227);
            label.text=@"  参数配置";
            label.font=[UIFont systemFontOfSize:14];
            label.textAlignment=UITextAlignmentLeft;
            return label;
        }
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==summarytabview)
    {
        if (section==0)
        {
            return 90;
        }else
        {
            return 25;
        }
    }else
    {
        return 0;
    }
    
}

//根据宽度适应高度
- (CGFloat)heightFor:(CGFloat)oHeight
{
    CGFloat aHeight = (DEVICE_WIDTH / 320) * oHeight;
    return aHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string_cell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string_cell];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string_cell];
    }
    for (UIView *aview in cell.contentView.subviews)
    {
        [aview removeFromSuperview];
    }
    
    if (tableView==imagetableview)
    {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        AsyncImageView *asyimagev;
        

        UIImage *placeImg=[UIImage imageNamed:@"implaceofcarport.png"];
        
        CGFloat aWidth = (DEVICE_WIDTH - 9*4)/3;
        
        if (indexPath.row*3 < smallimagearray.count)
        {
            asyimagev=[[AsyncImageView alloc] initWithFrame:CGRectMake(9, 9, aWidth, [self heightFor:152/2-12])];
            [asyimagev loadImageFromURL:[smallimagearray objectAtIndex:indexPath.row*3] withPlaceholdImage:placeImg];
            asyimagev.tag=indexPath.row*3;
            [cell.contentView addSubview:asyimagev];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShowbigImage:)];
            tap.numberOfTapsRequired=1;
            tap.numberOfTouchesRequired=1;
            asyimagev.userInteractionEnabled=YES;
            [asyimagev addGestureRecognizer:tap];

        }
        
        if (indexPath.row*3+1 < smallimagearray.count)
        {
            asyimagev=[[AsyncImageView alloc] initWithFrame:CGRectMake(9 + aWidth +9, 9, aWidth, [self heightFor:152/2-12])];
            [asyimagev loadImageFromURL:[smallimagearray objectAtIndex:indexPath.row*3+1] withPlaceholdImage:placeImg];
            asyimagev.tag=indexPath.row*3+1;
            [cell.contentView addSubview:asyimagev];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShowbigImage:)];
            tap.numberOfTapsRequired=1;
            tap.numberOfTouchesRequired=1;
            asyimagev.userInteractionEnabled=YES;
            [asyimagev addGestureRecognizer:tap];


        }
        
        if (indexPath.row*3+2 < smallimagearray.count)
        {
//            asyimagev=[[AsyncImageView alloc] initWithFrame:CGRectMake(9+94.5+9+94.5+9, 9, 94.5, 152/2-12)];
            
            asyimagev=[[AsyncImageView alloc] initWithFrame:CGRectMake(9 + aWidth +9 + aWidth +9, 9, aWidth, [self heightFor:152/2-12])];
            [asyimagev loadImageFromURL:[smallimagearray objectAtIndex:indexPath.row*3+2] withPlaceholdImage:placeImg];
            asyimagev.tag=indexPath.row*3+2;
            [cell.contentView addSubview:asyimagev];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShowbigImage:)];
            tap.numberOfTapsRequired=1;
            tap.numberOfTouchesRequired=1;
            asyimagev.userInteractionEnabled=YES;
            [asyimagev addGestureRecognizer:tap];

        }
        
    }
    
    if (tableView==newstab)
    {
        orcell=[[newscellview alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 77)];
        [orcell setImv_string:[newsofimgarray objectAtIndex:indexPath.row]];
        [orcell setTitle_string:[newsoftitlearray objectAtIndex:indexPath.row]];
        [orcell setDate_string:[newsofdatearray objectAtIndex:indexPath.row]];
        [orcell setDiscribe_string:[newsofdiscriptionarray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:orcell];
        
//        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 77, DEVICE_WIDTH, 1)];
//        img.contentMode =  UIViewContentModeScaleToFill;
//        img.image=[UIImage imageNamed:@"line-2.png"];
//        [cell.contentView addSubview:img];
        UIView *selectback=[[UIView alloc]initWithFrame:cell.frame];
        selectback.backgroundColor=RGBCOLOR(242, 242, 242);
        cell.selectedBackgroundView=selectback;

    }
    if (tableView==summarytabview)
    {        
        NSDictionary *sumdicinfo=[summarayarrayinfo objectAtIndex:indexPath.row];
        summarycellview *scellview=[[summarycellview alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 55)];
        [scellview setSuminfo:sumdicinfo];
        [cell.contentView addSubview:scellview];
        
        UIView *selectback=[[UIView alloc]initWithFrame:cell.frame];
        selectback.backgroundColor=RGBCOLOR(242, 242, 242);
        cell.selectedBackgroundView=selectback;
    }
    
    
    return cell;    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==newstab)
    {
        newsdetailViewController *_newsdetail=[[newsdetailViewController alloc]initWithID:[newsofidarray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:_newsdetail animated:YES];
    }
    if (tableView==summarytabview)
    {        
        carinfoViewController *_detailcar=[[carinfoViewController alloc]init];
        NSDictionary *sumdicinfo=[summarayarrayinfo objectAtIndex:indexPath.row];
        
        _detailcar.string_name=[NSString stringWithFormat:@"%@",[[sumdicinfo objectForKey:@"name"] objectAtIndex:0]];
        _detailcar.string_cid=[NSString stringWithFormat:@"%@",[[sumdicinfo objectForKey:@"cid"] objectAtIndex:0]];
        [self.navigationController pushViewController:_detailcar animated:YES];
    }
}
#pragma mark-newsmodeldelegate
-(void)finishloadwithimagearray:(NSMutableArray *)imgarray datearray:(NSMutableArray *)_datearray discriptionarray:(NSMutableArray *)_discriptionarray titlearray:(NSMutableArray *)_titlearray newsidarray:(NSMutableArray *)_newsidarray
{
    [loadview stopLoading:1];
    isnewsloadsuccess=NO;
    [newsofdatearray addObjectsFromArray: _datearray];
    [newsoftitlearray addObjectsFromArray: _titlearray];
    [newsofdiscriptionarray addObjectsFromArray: _discriptionarray];
    [newsofimgarray addObjectsFromArray: imgarray];
    [newsofidarray addObjectsFromArray: _newsidarray];
    newstab.tableFooterView=loadview;

    if (_discriptionarray.count==0)
    {
        UILabel *    label_nonedata=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
            label_nonedata.text=@"没有更多数据";
            label_nonedata.textColor=GRAYZI;
            label_nonedata.textAlignment=UITextAlignmentCenter;
            label_nonedata.font=[UIFont systemFontOfSize:14];
        newstab.tableFooterView=label_nonedata;
            isnewsloadsuccess=YES;
    }
    
    [newstab reloadData];
}

#pragma mark-summarymodeldelegate
-(void)finishloaddatawitharray:(NSArray *)_suminfoarray
{
    summarayarrayinfo=_suminfoarray;
    NSLog(@"summarayarrayinfo=%@",summarayarrayinfo);

    [summarytabview reloadData];
}
#pragma mark-picmodel
-(void)finishloadWithsmallarray:(NSMutableArray *)__smallimagearray bigimagearray:(NSMutableArray *)__bigimagearray
{
    NSLog(@"=====%@=====%@",__smallimagearray,__bigimagearray);
    smallimagearray=__smallimagearray;
    bigimagearray=__bigimagearray;
    NSLog(@"smallarray=====%@",smallimagearray);

    [imagetableview reloadData];
}
#pragma mark-carportDelegate
-(void)TapbuttonWithindex:(int)buttonondex type:(int)__segtype whichseg:(CarPortSeg *)_seg{
    if (_seg==segview)
    {
        if (buttonondex!=3)
        {
            summarytabview.hidden=YES;
            imagetableview.hidden=YES;
            threeseg.hidden=YES;
            
            newstab.hidden=YES;
        }
       

        switch (buttonondex)
        {
            case 0:
                NSLog(@"综述");
            {
                summarytabview.hidden=NO;

                if (summarayarrayinfo.count==0)
                {
                    [_summarymodel startloaddatawithwords:@""];
                }
            
            }
                break;
                
            case 1:
            {
                if (!threeseg)
                {
                    threeseg=[[CarPortSeg alloc]initWithFrame:CGRectMake(8, 33, 304, 27)];
                    [threeseg setNameArray:[NSArray arrayWithObjects:@"外观",@"内饰",@"细节", nil]];
                    [threeseg setType:2];
                    threeseg.delegate=self;
                    //[self.view addSubview:threeseg];
                }
            
                threeseg.hidden=NO;
                imagetableview.hidden=NO;
                
                if (smallimagearray.count>0)
                {
                    
                }else
                {
                    _picmodel.delegate=self;
                    
                    [_picmodel startloadimageWithtype:1 words:self.the_type.words];
                }
                
            }
                NSLog(@"图片");
                
                break;
                
            case 2:
            {
                newstab.hidden=NO;
                if (newsofdiscriptionarray.count>0)
                {
                    
                }else
                {
                    [_newsmodel startloaddatawithpage:1 words:self.the_type.words];
                }
                
            }
                NSLog(@"资讯");
                break;
                
            case 3:
                NSLog(@"经销商");
                
            {
//                if ([self.the_type.fid isEqualToString:@"0"]) {
//                    NSLog(@"没有该车系的相关贴子");
//                    NSLog(@"fiffffid===%@====pid=%@",self.the_type.fid,self.the_type.pid);
//
//                }else{
//                    BBSfenduiViewController *   fendui_=[[BBSfenduiViewController alloc]init];
//                    fendui_.string_id=self.the_type.fid;
//                    
//                    //    [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
//                    fendui_.string_name=self.the_type.name;
//                    [self.navigationController pushViewController:fendui_ animated:YES];
//
//                }
                
                
                _salemodel=[[SaleModel alloc]init];
                _salemodel.delegate=self;
                [_salemodel startloadbbswithwords:self.the_type.words];
                
            }
                break;
                
            default:
                break;
        }
    }else
    {
        
        switch (buttonondex)
        {
            case 0:
                NSLog(@"外观");
                [smallimagearray removeAllObjects];
                [imagetableview reloadData];
                [_picmodel startloadimageWithtype:1 words:self.the_type.words];

                break;
                
            case 1:
            {
                [smallimagearray removeAllObjects];
                [imagetableview reloadData];
                [_picmodel startloadimageWithtype:2 words:self.the_type.words];

                
            }
                NSLog(@"内饰");
                
                break;
                
            case 2:
                
                [smallimagearray removeAllObjects];
                [imagetableview reloadData];
                [_picmodel startloadimageWithtype:3 words:self.the_type.words];

                NSLog(@"细节");
                break;
                
           
            default:
                break;
        }

        
        
    }
 
}

#pragma mark-saleModeldelegate
-(void)finishloadwithid:(NSString *)str_fid{
    if ([str_fid isEqualToString:@"0"])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该车型暂无论坛版块" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"muyou");
    }else
    {
                    BBSfenduiViewController *   fendui_=[[BBSfenduiViewController alloc]init];
                    fendui_.string_id=str_fid;

                    //    [self setHidesBottomBarWhenPushed:YES];//跳入下一个View时先隐藏掉tabbar
//                    fendui_.string_name=self.the_type.name;
                    [self.navigationController pushViewController:fendui_ animated:YES];
        
    }
}
#pragma mark - MWPhotoBrowserDelegate
//一共多少张
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}
//返回点击的哪一张
- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < smallimagearray.count)
        return [_photos objectAtIndex:index];
    return nil;
    
}
-(void)ShowbigImage:(UITapGestureRecognizer *)sender
{
    
    _photos=[[NSMutableArray alloc]init];
    
    for (int i=0; i<bigimagearray.count; i++)
    {
        NSString *string_imgurl=[NSString stringWithFormat:@"%@",[bigimagearray objectAtIndex:i]];
        NSLog(@"string_url=%@",string_imgurl);
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:string_imgurl]]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.title_string=self.the_type.name;
    
    [browser setInitialPageIndex:sender.view.tag];
    
    [self presentModalViewController:browser animated:YES];
}

#pragma mark-uiscrowviewdelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView==newstab)
    {
        if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height+40) && scrollView.contentOffset.y > 0&&isnewsloadsuccess==NO)
        {
            
            isnewsloadsuccess=!isnewsloadsuccess;
            pagesofnews++;
            [loadview startLoading];
            [_newsmodel startloaddatawithpage:pagesofnews words:self.the_type.words];
            
        }
    }
    
    
}


-(void)backto
{
    [_summarymodel stop];
    [_salemodel stop];
    [_newsmodel stop];
    [_picmodel stop];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
