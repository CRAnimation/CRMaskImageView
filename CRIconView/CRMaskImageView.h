//
//  CRMaskImageView.h
//  CRIconView
//
//  Created by Bear on 2017/9/5.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CRLAYOUT_AXIS) {
    CRLAYOUT_AXIS_Horizontal,
    CRLAYOUT_AXIS_Vertical,
};

@interface CRMaskImageView : UIImageView

//  是否依据透明程度裁剪layer
@property (assign, nonatomic) BOOL needCutterMask;

//  渐变扩展size
@property (assign, nonatomic) CGSize gradientSpreadSize;

//  依据透明程度裁剪的gradientLayer
@property (strong, nonatomic, readonly) CAGradientLayer *maskGradientLayer;

- (void)setGradientLayerFromColor:(UIColor *)fromColor
                          ToColor:(UIColor *)toColor
                             axis:(CRLAYOUT_AXIS)axis;

@end
