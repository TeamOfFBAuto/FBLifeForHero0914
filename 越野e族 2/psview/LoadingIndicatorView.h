//
//  LoadingIndicatorView.h

//  Copyright (c) 2012 __WILLZHANG__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingIndicatorView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UILabel *loadingLabel, *normalLabel;

// type: 1: table footer,  2: view loading, 3: block loading
/**
 *  <#Description#>
 */

@property (nonatomic, assign) int type;

- (void)startLoading;

- (void)stopLoading:(int)loadingType;

@end
