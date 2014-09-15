//
//  NewshoucangTableViewCell.m
//  越野e族
//
//  Created by 史忠坤 on 14-7-10.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "NewshoucangTableViewCell.h"

@implementation NewshoucangTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1
        
        _newsView=[[UIView alloc]init];
        [self addSubview:_newsView];
        
        _bigTitleLabel=[[UILabel alloc]init];
        _bigTitleLabel.font=[UIFont systemFontOfSize:16];
        _bigTitleLabel.textAlignment=NSTextAlignmentLeft;
        _bigTitleLabel.numberOfLines=0;
        [_newsView addSubview:_bigTitleLabel];
        
        _pindaoLabel=[[UILabel alloc]init];
        _pindaoLabel.font=[UIFont systemFontOfSize:12];
        _pindaoLabel.textAlignment=NSTextAlignmentLeft;
        _pindaoLabel.textColor=[UIColor grayColor];
        [_newsView addSubview:_pindaoLabel];

        
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.textAlignment=NSTextAlignmentLeft;
        _timeLabel.textColor=[UIColor lightGrayColor];

        [_newsView addSubview:_timeLabel];
        //WithImage:[UIImage imageNamed:@"newcommentpic20_19.png"]
        _commentImagev=[[UIImageView alloc]init];
        [_newsView addSubview:_commentImagev];
        
        
        
        
        _viewline=[[UIView alloc]init];
        _viewline.backgroundColor=RGBCOLOR(225, 225, 225);
        [self addSubview:_viewline];
        
        
        //2
        
        //3
        
        //4

        
    
        
        
        // Initialization code
    }
    return self;
}

-(void)newshoucangTableViewCellSetDic:(NSDictionary *)dic sNewshoucangTableViewCellStyle:(NewshoucangTableViewCellStyle)theStyle thebloc:(NewshoucangTableViewCellBloc)ahabloc{
    
    _mybloc=ahabloc;
    
    _mystyle=theStyle;
    
    switch (theStyle) {
        case NewshoucangTableViewCellStyleNews:
        {
            
            
            _newsView.frame=self.bounds;
            
            _bigTitleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
            _pindaoLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"channel_name"]];
            _timeLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];
            
            UIFont *font = [UIFont systemFontOfSize:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(320-24,MAXFLOAT);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [_bigTitleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            
            _bigTitleLabel.frame=CGRectMake(12, 12, 320-24, labelsize.height);
            
            _pindaoLabel.frame=CGRectMake(12, 12+labelsize.height+12, 200, 15);
            
            _timeLabel.frame=CGRectMake(220, _pindaoLabel.frame.origin.y, 100, 15);


            
        
        }
            break;
            
        case NewshoucangTableViewCellStyleTiezi:
        {
            
            _newsView.frame=self.bounds;
            
            _bigTitleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"subject"]];
            _pindaoLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"forumname"]];
            _timeLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];
            
            UIFont *font = [UIFont systemFontOfSize:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(320-24,MAXFLOAT);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [_bigTitleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            
            _bigTitleLabel.frame=CGRectMake(12, 12, 320-24, labelsize.height);
            
            _pindaoLabel.frame=CGRectMake(12, 12+labelsize.height+12, 200, 15);
            
            _timeLabel.frame=CGRectMake(220, _pindaoLabel.frame.origin.y, 100, 15);

            
            
            
        }
            break;
            
        case NewshoucangTableViewCellStyleBankuai:
        {
            
            
            _newsView.frame=self.bounds;
            
            _bigTitleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

            _bigTitleLabel.frame=CGRectMake(12, 12, 320-24, 20);
            
            
            _timeLabel.text=[NSString stringWithFormat:@"今日新贴 %@",[dic objectForKey:@"postcount"]];
            
            _timeLabel.frame=CGRectMake(200, 12, 320-200-12, 20);
            
            _timeLabel.textAlignment=NSTextAlignmentRight;
            

        }
            break;
            
        case NewshoucangTableViewCellStyleTuji:
        {
            _newsView.frame=self.bounds;
            
            _bigTitleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
          //  _pindaoLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"forumname"]];
            _timeLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];
            
            UIFont *font = [UIFont systemFontOfSize:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(320-24,MAXFLOAT);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [_bigTitleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            
            _bigTitleLabel.frame=CGRectMake(12, 12, 320-24, labelsize.height);
            
            //_pindaoLabel.frame=CGRectMake(12, 12+labelsize.height+12, 200, 15);
            
            _timeLabel.frame=CGRectMake(220, 12+labelsize.height+12, 100, 15);

            _commentImagev.frame=CGRectMake(12, _timeLabel.frame.origin.y+3, 10, 9.5);
            _commentImagev.image=[UIImage imageNamed:@"newcommentpic20_19.png"];
            
            _pindaoLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"comment"]];
            _pindaoLabel.frame=CGRectMake(30, _timeLabel.frame.origin.y, 100, 15);
            
            
        }
            break;
            
            
        case NewshoucangTableViewCellStylemywrite:
        {
            
            _newsView.frame=self.bounds;
            
            _bigTitleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"subject"]];
            _pindaoLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"forumname"]];
            _timeLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];
            
            UIFont *font = [UIFont systemFontOfSize:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(320-24,MAXFLOAT);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [_bigTitleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            
            _bigTitleLabel.frame=CGRectMake(12, 12, 320-24, labelsize.height);
            
            _pindaoLabel.frame=CGRectMake(12, 12+labelsize.height+12, 200, 15);
            
            _timeLabel.frame=CGRectMake(220, _pindaoLabel.frame.origin.y, 100, 15);
            
            
            
        }
            break;

        case NewshoucangTableViewCellStylemycomment:
        {
            
            _newsView.frame=self.bounds;
            
            _bigTitleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"subject"]];
            _pindaoLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"forumname"]];
            _timeLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];
            
            UIFont *font = [UIFont systemFontOfSize:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(320-24,MAXFLOAT);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [_bigTitleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            
            _bigTitleLabel.frame=CGRectMake(12, 12, 320-24, labelsize.height);
            
            _pindaoLabel.frame=CGRectMake(12, 12+labelsize.height+12, 200, 15);
            
            _timeLabel.frame=CGRectMake(220, _pindaoLabel.frame.origin.y, 100, 15);
            
            
            
            
        }
            break;

            
            
            
            
        default:
            break;
    }




}



-(void)layoutSubviews{

    [super layoutSubviews];
    
    _viewline.frame=CGRectMake(12, self.frame.size.height-0.5, 320-24, 0.5);
    //新闻的
    switch (_mystyle) {
        case NewshoucangTableViewCellStyleNews:
        {

            

        }
            break;
            
        case NewshoucangTableViewCellStyleTiezi:
        {
            
            
        }
            break;
            
        case NewshoucangTableViewCellStyleBankuai:
        {
            
            
        }
            break;
            
        case NewshoucangTableViewCellStyleTuji:
        {
            
            
        }
            break;
            
        default:
            break;
    }
    

    

}

+(CGFloat)NewshoucangTableViewCellHeightFromstyle:(NewshoucangTableViewCellStyle)thestyle comstr:(NSString *)thestring
{
    
    
    
    UIFont *font = [UIFont systemFontOfSize:16];
    //设置一个行高上限
    CGSize size = CGSizeMake(320-24,MAXFLOAT);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [thestring sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    


    switch (thestyle) {
        case NewshoucangTableViewCellStyleNews:
        {
            
            return labelsize.height+48;
            
            
            
            NSLog(@"labelsize,geight===%f",labelsize.height);

            
            
        }
            break;
            
        case NewshoucangTableViewCellStyleTiezi:
        {
            return labelsize.height+48;

        }
            break;
            
        case NewshoucangTableViewCellStyleBankuai:
        {
            return 44;

            
        }
            break;
            
        case NewshoucangTableViewCellStyleTuji:
        {
            return labelsize.height+48;
            
            
            

        }
            break;
            
        case NewshoucangTableViewCellStylemywrite:
        {
            return labelsize.height+48;
            
            
            
            
        }
            break;
            
        case NewshoucangTableViewCellStylemycomment:
        {
            return labelsize.height+48;
            
            
            
            
        }
            break;
            
        default:
            return 44;

            break;
    }
    
    

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
