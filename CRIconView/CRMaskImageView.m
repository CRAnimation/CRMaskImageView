//
//  CRMaskImageView.m
//  CRIconView
//
//  Created by Bear on 2017/9/5.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRMaskImageView.h"

@interface CRMaskImageView ()

@property (strong, nonatomic) CALayer *maskLayer;
@property (strong, nonatomic) CAGradientLayer *maskGradientLayer;

@end

@implementation CRMaskImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.gradientSpreadSize = CGSizeZero;
        self.needCutterMask = NO;
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{

}

#pragma mark - Rewrite
- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    
    if (self.image) {
        [self changeMaskImage:self.image];
    }
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    [super setHighlightedImage:highlightedImage];
    
    if (self.highlightedImage) {
        [self changeMaskImage:self.highlightedImage];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        if (self.highlightedImage) {
            [self changeMaskImage:self.highlightedImage];
        }
    }else{
        if (self.image) {
            [self changeMaskImage:self.image];
        }
    }
}

- (void)sizeToFit
{
    [super sizeToFit];
    
    self.maskLayer.frame = self.bounds;
    self.maskGradientLayer.frame = self.bounds;
}

#pragma mark - Method
- (void)changeMaskImage:(UIImage *)image
{
    self.maskLayer.contents = (__bridge id)image.CGImage;
    self.needCutterMask = self.needCutterMask;
    [self spreadMaskGradientLayerFrameWithSpreadSize:self.gradientSpreadSize];
}

- (void)spreadMaskGradientLayerFrameWithSpreadSize:(CGSize)spreadSize
{
    self.maskLayer.frame = CGRectMake(self.maskLayer.frame.origin.x + spreadSize.width,
                                      self.maskLayer.frame.origin.y + spreadSize.height,
                                      self.maskLayer.frame.size.width,
                                      self.maskLayer.frame.size.height);
    self.maskGradientLayer.mask = self.maskLayer;
    
    _maskGradientLayer.frame = CGRectMake(_maskGradientLayer.frame.origin.x - spreadSize.width,
                                          _maskGradientLayer.frame.origin.y - spreadSize.height,
                                          _maskGradientLayer.frame.size.width + 2 * spreadSize.width,
                                          _maskGradientLayer.frame.size.height + 2 * spreadSize.height);
    
}

#pragma mark - GradientLayer
- (void)setGradientLayerFromColor:(UIColor *)fromColor
                          ToColor:(UIColor *)toColor
                             axis:(CRLAYOUT_AXIS)axis
{
    if (!fromColor || !toColor) {
        return;
    }
    
    self.maskGradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                                  (__bridge id)toColor.CGColor
                                  ];
    //从上往下的渐变
    //(I.e. [0,0] is the bottom-left corner of the layer, [1,1] is the top-right corner.)
    switch (axis) {
        case CRLAYOUT_AXIS_Vertical:
        {
            self.maskGradientLayer.startPoint = CGPointMake(0, 0);
            self.maskGradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
            
        case CRLAYOUT_AXIS_Horizontal:
        {
            self.maskGradientLayer.startPoint = CGPointMake(0, 0);
            self.maskGradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter & Getter
- (CALayer *)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.frame = self.bounds;
    }
    
    return _maskLayer;
}

- (CAGradientLayer *)maskGradientLayer
{
    if (!_maskGradientLayer) {
        _maskGradientLayer = [CAGradientLayer layer];
        _maskGradientLayer.frame = self.bounds;
        [self.layer addSublayer:_maskGradientLayer];
    }
    
    return _maskGradientLayer;
}

- (void)setNeedCutterMask:(BOOL)needCutterMask
{
    _needCutterMask = needCutterMask;
    
    if (_needCutterMask) {
        self.layer.mask = self.maskLayer;
    }else{
        self.layer.mask = nil;
    }
}


@end
