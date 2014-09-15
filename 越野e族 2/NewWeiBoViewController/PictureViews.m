//
//  PictureViews.m
//  FbLife
//
//  Created by soulnear on 13-6-17.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "PictureViews.h"

@implementation PictureViews
{
    
}
@synthesize delegate;
@synthesize isReply = _isReply;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setDelegate:(id<PictureViewsDelegate>)delegate1
{
    delegate = delegate1;
}



-(void)handleImageLayout:(AsyncImageView *)tag
{
    
}


-(void)succesDownLoadWithImageView:(UIImageView *)imageView Image:(UIImage *)image
{
    //    image = [zsnApi fitSmallImage:image withSize:CGSizeMake(150,150)];
    //
    //    imageView.image = image;
}

-(void)seccesDownLoad:(UIImage *)image
{
    
}



-(void)setImageUrls:(NSString *)theUrl withSize:(int)size isjuzhong:(BOOL)juzhong
{
    NSArray * array = [[NSArray alloc] init];
    
    array = [theUrl componentsSeparatedByString:@"|"];
    
    int row = 0;
    
    int number = 0;
    
    
    int iii = 9;
    
    if (array.count < 9)
    {
        iii = array.count;
    }
    
    for (int i = 0;i < array.count;i++)
    {
        AsyncImageView * imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake((size+2.5)*number,(size + 2.5)*row,size,size)];
        
        if (juzhong)
        {
            if (array.count == 1)
            {
                imageView.frame = CGRectMake(self.frame.size.width/2-size/2,(size + 2.5)*row,size,size);
            }else if(array.count == 2)
            {
                imageView.frame = CGRectMake((self.frame.size.width-size*2-4)/2 + (size+2.5)*number,(size + 2.5)*row,size,size);
            }
        }
        
        imageView.tag = i+1;
        imageView.delegate = self;
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor clearColor];
        
        
        NSMutableString * urlString = [NSMutableString stringWithFormat:@"%@",[array objectAtIndex:i]];
        
        
        if ([urlString rangeOfString:@"bbs.fblife.com"].length && ![urlString rangeOfString:@"thumb.jpg"].length)
        {
            [urlString insertString:@".thumb.jpg" atIndex:urlString.length];
        }
        
        
        [imageView loadImageFromURL:urlString withPlaceholdImage:[UIImage imageNamed:@"weibo_implace.png"]];
        [self addSubview:imageView];
        number++;
        
        if (i%3 >= 2)
        {
            row++;
            number = 0;
        }
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [imageView addGestureRecognizer:tap];
    }
    
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    [delegate clickPicture:sender.view.tag-1 WithIsReply:self.isReply];
}


@end
