//
//  CompreTableViewCell.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-1.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#define BIGORIGIN 55

#define BIGHEIGHT 14




#import "CompreTableViewCell.h"



#import "NewMainViewModel.h"//新的首页，普通数据的model


@implementation CompreTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        com_id_array=[NSMutableArray array];
        com_link_array=[NSMutableArray array];
        com_type_array=[NSMutableArray array];
        com_title_array=[NSMutableArray array];
        
        _myDic=[NSDictionary dictionary];
        
        
   
        
        NSLog(@"xxxx==%f=====w==%f",self.contentView.frame.size.height,self.contentView.frame.size.width);
        
        
    }
    return self;
}


//图集或者普通的用这个


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CompreTableViewCellStyle)sstyle{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bigLabel=[[UILabel alloc] init];
        
        self.leftImageV=[[AsyncImageView alloc] init];
        
        self.centerImageV=[[AsyncImageView alloc] init];
        
        self.rightImageV=[[AsyncImageView alloc] init];
        
        _zanImageV=[[UIImageView alloc]init];
        _zanImageV.image=[UIImage imageNamed:@"talknumberofnew.png"];
        
        self.zanlabel=[[UILabel alloc] init];
        
        self.bigLeixing=[[UIButton alloc] init];
        
        self.littleLeixing=[[UIButton alloc] init];
        
        self.normalLine=[[UIView alloc]init];
        
        self.textBigLabel=[[UILabel alloc]init];
        self.fenGeLine=[[UILabel alloc]init];
        
        self.littleAndBigLine=[[UIImageView alloc]init];
        
        
        [self addSubview:self.bigLabel];
        
        [self addSubview:self.leftImageV];
        
        [self addSubview:self.rightImageV];
        
        [self addSubview:self.centerImageV];
        
        [self addSubview:self.zanImageV];
        
        [self addSubview:self.zanlabel];
        
        [self addSubview:self.bigLeixing];
        
        [self addSubview:self.littleLeixing];
        
        [self addSubview:self.textBigLabel];
        
        [self addSubview:self.normalLine];
        
       // [self addSubview:self.fenGeLine];
        
        self.littleAndBigLine.image=[UIImage imageNamed:@"bigandlittle.png"];
        [self addSubview:self.littleAndBigLine];
        
        
        
        _bigLeixing.titleLabel.font=[UIFont systemFontOfSize:11];
        [_bigLeixing setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _bigLeixing.backgroundColor=RGBCOLOR(244, 244, 244);
        
        
        [_bigLeixing addTarget:self action:@selector(clickBigButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _littleLeixing.titleLabel.font=[UIFont systemFontOfSize:11];
        [_littleLeixing setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _littleLeixing.backgroundColor=RGBCOLOR(244, 244, 244);
        [_littleLeixing addTarget:self action:@selector(clickSmallButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _zanlabel.font=[UIFont systemFontOfSize:9];
        
        _zanlabel.textColor=RGBCOLOR(160, 160, 160);
        
        _zanlabel.textAlignment=NSTextAlignmentLeft;
        
        _fenGeLine.backgroundColor=RGBCOLOR(142, 142, 142);
        
     //   self.littleAndBigLine.backgroundColor=[UIColor redColor];
        
    }
    return self;
}

#pragma mark--Pic的用这个

-(void)normalsetDic:(NSDictionary *)theDic cellStyle:(CompreTableViewCellStyle)theStyle thecellbloc:(CompreTableViewCellBloc)thebloc{
    
    _myDic=theDic;
    
    

    _mybloc=thebloc;
    
    @try {
        
        switch (theStyle) {
            case CompreTableViewCellStylePictures:
            {   NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
                [_newmodel NewMainViewModelSetdic:theDic];

                
                _zanImageV.frame=CGRectMake(0, 0, 22/2, 23/2);
                _zanImageV.center=CGPointMake(286, 122-3);
                
                _zanlabel.frame=CGRectMake(286+9,113 , 320-286-10, 11);
                
//                if (_newmodel.likes.length>2) {
//                    _zanImageV.center=CGPointMake(286, 122-4);
//                    _zanlabel.frame=CGRectMake(286,112 , 320-286-10, 11);
//
//                }
                
                             //标题
                
                _bigLabel.frame=CGRectMake(12, 12, 320, 18);
                _bigLabel.font=[UIFont systemFontOfSize:16];
                _bigLabel.text=_newmodel.title;
                _bigLabel.textColor=RGBCOLOR(49, 49, 49);
                _bigLabel.textAlignment=NSTextAlignmentLeft;
                
                
                _zanlabel.text=_newmodel.comment;
                
                //三个图片
                
                if (_newmodel.photo.count>=3) {
                    
                    _leftImageV.frame=CGRectMake(12+102*0, 36, 90, 60);
                    [_leftImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:0]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
                    
                    _centerImageV.frame=CGRectMake(12+102*1, 36, 90, 60);
                    [_centerImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:1]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
                    
                    _rightImageV.frame=CGRectMake(12+102*2, 36, 90, 60);
                    [_rightImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:2]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
                }
                
                _bigLeixing.frame=CGRectMake(12, 105, 30, 20);
                [_bigLeixing setTitle:@"图集" forState:UIControlStateNormal];
                
                //  _bigLeixing addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>
                
                //标示
                
                
                
                //中间的线
                
                
                //            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(44, 128, 5, 1)];
                //            lineView.backgroundColor=[UIColor redColor];
                //            [self.contentView addSubview:lineView];
                
                //右边的button
                
                
                _normalLine.frame=CGRectMake(12, 133.5+4, 320-24, 0.5);
                _normalLine.backgroundColor=RGBCOLOR(223, 223, 223);
                
                
            }
                break;
                
            case CompreTableViewCellStyleText:
            {
                
                
                
                _zanImageV.frame=CGRectMake(0, 0, 22/2, 23/2);

                _zanImageV.center=CGPointMake(286, 66);
                _zanlabel.frame=CGRectMake(286+9,BIGORIGIN+5 , 320-286-10, 11);
                
                
                
                
                
                NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
                [_newmodel NewMainViewModelSetdic:theDic];
                
                _zanlabel.text=_newmodel.comment;
                
                
                
//                if (_newmodel.likes.length>2) {
//                    _zanImageV.center=CGPointMake(286, 66);
//                    _zanlabel.frame=CGRectMake(286,BIGORIGIN+4 , 320-286-10, 11);
//                    
//                }

                
                
                _leftImageV.frame=CGRectMake(12, 13, 90, 60);
                if (_newmodel.photo.count) {
                    [_leftImageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:0]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
                    
                }
                
                _bigLabel.frame=CGRectMake(100+10, 13, 320-100-12-10, 16);
                _bigLabel.font=[UIFont systemFontOfSize:16];
                _bigLabel.text=_newmodel.title;
                _bigLabel.textColor=RGBCOLOR(49, 49, 49);
                _bigLabel.backgroundColor=[UIColor whiteColor];
                _bigLabel.textAlignment=NSTextAlignmentLeft;
//                [self.contentView addSubview:_bigLabel];
                
                
                _textBigLabel.frame=CGRectMake(100+10, 34, 320-100-12-10, 16);
                _textBigLabel.font=[UIFont systemFontOfSize:11];
                _textBigLabel.text=_newmodel.stitle;
                _textBigLabel.textColor=[UIColor lightGrayColor];
                _textBigLabel.textAlignment=NSTextAlignmentLeft;
                _textBigLabel.textColor=RGBCOLOR(124, 124, 124);
                
                
                
                _fenGeLine.frame=CGRectMake(132+10, BIGORIGIN+7, 5, 1);
                
                
                //底部的线
                
                _normalLine.frame=CGRectMake(12, 86.5, 320-24, 0.5);
                _normalLine.backgroundColor=RGBCOLOR(223, 223, 223);
                
                
                /**
                 *  大小频道
                 
                 */
                
                
                
                
                if ([_newmodel.type isEqualToString:@"1"]) {
                    _bigLeixing.frame=CGRectMake(100+10, BIGORIGIN, 30, 18);
                    
                    CGSize titleSize = [_newmodel.channel_name sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
                    [_littleLeixing setTitle:_newmodel.channel_name forState:UIControlStateNormal];
                    [_bigLeixing setTitle:@"资讯" forState:UIControlStateNormal];
                    _littleLeixing.frame=CGRectMake(140+10, BIGORIGIN, titleSize.width+2, 18);
                    
                    self.littleAndBigLine.frame=CGRectMake(142, BIGORIGIN+9, 5, 1);
                    
                    
                }else if([_newmodel.type isEqualToString:@"2"]){
                    
                    
                    
                    
                }else if([_newmodel.type isEqualToString:@"3"]){
                    
                    self.littleAndBigLine.frame=CGRectMake(142, BIGORIGIN+9, 5, 1);
                    
                    _bigLeixing.frame=CGRectMake(100+10, BIGORIGIN, 30, 18);
                    
                    CGSize titleSize = [_newmodel.forumname sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
                    [_littleLeixing setTitle:_newmodel.forumname forState:UIControlStateNormal];
                    _littleLeixing.frame=CGRectMake(140+10, BIGORIGIN, titleSize.width+2, 18);
                    
                    [_bigLeixing setTitle:@"论坛" forState:UIControlStateNormal];
                    //[_bigLabel:RGBCOLOR(103, 103, 103)];
                    [_bigLeixing setTitleColor:RGBCOLOR(103, 103, 103) forState:UIControlStateNormal];
                    
                    
                    
                    
                    
                    
                    
                }else if([_newmodel.type isEqualToString:@"4"]){
                    
                    //商城暂时不做
                    
                    //                    _bigLeixing.frame=CGRectMake(12, 100, 30, 25);
                    //
                    //                    CGSize titleSize = [_newmodel.channel_name sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
                    //                    [_littleLeixing setTitle:_newmodel.channel_name forState:UIControlStateNormal];
                    //                    _littleLeixing.frame=CGRectMake(60, 100, titleSize.width, 25);
                    //
                    //                    [_bigLeixing setTitle:@"商城" forState:UIControlStateNormal];
                    
                }
                
                //底部的线
                
                
                
            }
                break;
                
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    
    
}
#pragma mark--普通的用这个





#pragma mark--幻灯专用的，这个

-(void)setDic:(NSDictionary *)theDic cellStyle:(CompreTableViewCellStyle)theStyle thecellbloc:(CompreTableViewCellBloc)thebloc{
    _myDic=theDic;
    
    
    
    _mystyle=theStyle;
    
    _mybloc=thebloc;
    
    
    switch (theStyle) {
            
            
        case CompreTableViewCellStylePictures:
        {
            NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
            [_newmodel NewMainViewModelSetdic:theDic];
            //标题
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12, 12, 320, 16)];
            label.font=[UIFont systemFontOfSize:15];
            label.text=_newmodel.title;
            label.textAlignment=NSTextAlignmentLeft;
            [self.contentView addSubview:label];
            
            //三个图片
            for (int i=0; i<_newmodel.photo.count; i++) {
                AsyncImageView *imageV=[[AsyncImageView alloc] initWithFrame:CGRectMake(12+102*i, 28, 90, 70)];
                [imageV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:i]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
                [self.contentView addSubview:imageV];
                
            }
            
            //标示
            
            UIButton *buttonleft=[[UIButton alloc] initWithFrame:CGRectMake(12, 114, 30, 25)];
            [self.contentView addSubview:buttonleft];
            buttonleft.backgroundColor=RGBCOLOR(244, 244, 244);
            //中间的线
            
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(44, 128, 5, 1)];
            lineView.backgroundColor=[UIColor redColor];
            [self.contentView addSubview:lineView];
            
            //右边的button
            
            
            
            UIButton *rightbutton=[[UIButton alloc] initWithFrame:CGRectMake(52, 114, 30, 20)];
            [self.contentView addSubview:rightbutton];
            rightbutton.backgroundColor=RGBCOLOR(244, 244, 244);
            [rightbutton setTitle:@"资讯" forState:UIControlStateNormal];
            
            
            if ([_newmodel.type isEqualToString:@"0"]) {
                
                [buttonleft setTitle:@"新闻" forState:UIControlStateNormal];
                
            }else if([_newmodel.type isEqualToString:@"1"]){
                
                [buttonleft setTitle:@"图集" forState:UIControlStateNormal];
                
                
            }else if([_newmodel.type isEqualToString:@"2"]){
                
                [buttonleft setTitle:@"论坛" forState:UIControlStateNormal];
                
                
            }else if([_newmodel.type isEqualToString:@"3"]){
                
                [buttonleft setTitle:@"商城" forState:UIControlStateNormal];
                
            }
            
            //底部的线
            
            UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(12, 133.5+4, 320-24, 0.5)];
            viewLine.backgroundColor=RGBCOLOR(223, 223, 223);
            [self.contentView addSubview:viewLine];
            
            
            
            
        }
            break;
            
        case CompreTableViewCellStyleText:
        {
            
            
            
            
            NewMainViewModel *_newmodel=[[NewMainViewModel alloc]init];
            [_newmodel NewMainViewModelSetdic:theDic];
            
            AsyncImageView *normalimgaeV=[[AsyncImageView alloc]initWithFrame:CGRectMake(12, 12, 80, 53)];
            [self.contentView addSubview:normalimgaeV];
            if (_newmodel.photo.count) {
                [normalimgaeV loadImageFromURL:[NSString stringWithFormat:@"%@",[_newmodel.photo objectAtIndex:0]] withPlaceholdImage:[UIImage imageNamed:@"smallimplace.png"]];
                
            }
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 12, 320, 16)];
            label.font=[UIFont boldSystemFontOfSize:15];
            label.text=_newmodel.title;
            label.backgroundColor=[UIColor greenColor];
            label.textAlignment=NSTextAlignmentLeft;
            [self.contentView addSubview:label];
            
            
            UILabel *stitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 34, 320, 16)];
            stitleLabel.font=[UIFont systemFontOfSize:13];
            stitleLabel.text=_newmodel.stitle;
            stitleLabel.textColor=[UIColor lightGrayColor];
            stitleLabel.textAlignment=NSTextAlignmentLeft;
            stitleLabel.textColor=[UIColor blueColor];
            [self.contentView addSubview:stitleLabel];
            
            
            
            UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(12, 191-0.5, 85.5, 0.5)];
            viewLine.backgroundColor=RGBCOLOR(223, 223, 223);
            [self.contentView addSubview:viewLine];
            self.contentView.backgroundColor=[UIColor redColor];
            
        }
            break;
            
        default:
            break;
    }
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
}

+(CGFloat)getHeightwithtype:(CompreTableViewCellStyle)theResourceStyle{
    
    switch (theResourceStyle) {
        case CompreTableViewCellStyleHuandeng:
        {
            
            return 191;
            
        }
            break;
            
        case CompreTableViewCellStylePictures:
        {
            return 134+4;
            
            
        }
            break;
            
        case CompreTableViewCellStyleText:
        {
            return 87;
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}



#pragma mark-SGFocusImageItem的代理
//- (void)newfoucusImageFrame:(NewHuandengView *)imageFrame didSelectItem:(SGFocusImageItem *)item
//{
//    
//    
//    
//    
//    
//    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);
//    
//    self.mybloc(@"big",self.myDic,[NSString stringWithFormat:@"%d",item.tag]);
//    
//    if (com_id_array.count>0) {
//        
//        int type;
//        NSString *string_link_;
//        @try {
//            type=[item.type intValue];
//            
//            string_link_=item.link;
//            
//        }
//        @catch (NSException *exception) {
//            NSLog(@"%@",exception);
//            return;
//            
//        }@finally {
//            switch (type) {
//                case 0:
//                {
//                    
//                    NSLog(@"到新闻的");
//                    
//                }
//                    break;
//                    
//                case 1:{
//                    NSLog(@"到论坛的");
//                    
//                }
//                    break;
//                case 2:{
//                    
//                    NSLog(@"商城的");
//                    
//                }
//                    
//                default:
//                    break;
//            }
//            
//            
//        }
//        
//        
//        
//    }
//    
//}
//
//
//
////- (void)newfoucusImageFrame:(NewHuandengView *)imageFrame currentItem:(int)index;
////{
////    
////    
////    
////    NSLog(@"index===%d",index);
////    
////}
//
//
//
//-(void)huadengcurrentIndex:(int)myindex{
//
//
//    NSLog(@"index===%d",myindex);
//
//
//}


#pragma mark---button点击事件



-(void)clickBigButton:(UIButton *)sender{
    
    
    NSLog(@"xxx===sv");
    
    
    _mybloc(@"big",self.myDic,@"1");
    
    
}


-(void)clickSmallButton:(UIButton *)sender{
    
    self.mybloc(@"small",self.myDic,@"1");
    
    
    
    
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
