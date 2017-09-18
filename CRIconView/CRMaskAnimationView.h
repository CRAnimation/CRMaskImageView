//
//  CRMaskAnimationView.h
//  CRIconView
//
//  Created by Bear on 2017/9/6.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMaskImageView.h"

@interface CRMaskAnimationView : UIView

@property (assign, nonatomic) NSInteger maxLoopCount;
@property (assign, nonatomic) CGFloat fadeOutAnimationDuring;
@property (assign, nonatomic) CGFloat loopScaleAnimationDuring;
@property (strong, nonatomic, readonly) CRMaskImageView *maskImageView;

- (void)startLoopScaleAnimation;

@end
