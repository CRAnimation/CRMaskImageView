//
//  CRShiningAnimationView.h
//  CRIconView
//
//  Created by Bear on 2017/9/7.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMaskImageView.h"

@interface CRShiningAnimationView : UIView

@property (strong, nonatomic, readonly) CRMaskImageView *maskImageView;

- (void)startShining;

@end
