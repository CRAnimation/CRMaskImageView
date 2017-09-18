//
//  CRShiningAnimationView.m
//  CRIconView
//
//  Created by Bear on 2017/9/7.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRShiningAnimationView.h"
#import <BearSkill/BearDefines.h>
#import <BearSkill/UIView+BearSet.h>
#import <BearSkill/BearConstants.h>

@interface CRShiningAnimationView ()

@property (strong, nonatomic) CRMaskImageView *maskImageView;
@property (strong, nonatomic) CAGradientLayer *maskGradientLayer;
@property (strong, nonatomic) CABasicAnimation *shiningAnimation;

@end

@implementation CRShiningAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.backgroundColor = UIColorFromHEX(0x313340);
    
    _maskImageView = [[CRMaskImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 350)];
    _maskImageView.gradientSpreadSize = CGSizeMake(70, 0);
    _maskGradientLayer = _maskImageView.maskGradientLayer;
    [self addSubview:_maskImageView];
    [_maskImageView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    [self generateGradientLayer];
}

- (void)generateGradientLayer
{
    _maskGradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                                  (__bridge id)[UIColor whiteColor].CGColor,
                                  (__bridge id)[UIColor blackColor].CGColor];
    _maskGradientLayer.locations = @[@0.0, @0.0, @0.25];
    _maskGradientLayer.startPoint = CGPointMake(0, 0.5);
    _maskGradientLayer.endPoint = CGPointMake(1, 0.5);
}

- (void)startShining
{
    [_maskGradientLayer addAnimation:self.shiningAnimation forKey:nil];
}

#pragma mark - Setter & Getter
- (CABasicAnimation *)shiningAnimation
{
    if (!_shiningAnimation) {
        _shiningAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
        _shiningAnimation.fromValue = @[@0.0, @0.0, @0.25];
        _shiningAnimation.toValue = @[@0.75, @1.0, @1.0];
        _shiningAnimation.removedOnCompletion = NO;
        _shiningAnimation.fillMode = kCAFillModeForwards;
        _shiningAnimation.duration = 2.5;
        _shiningAnimation.repeatCount = MAXFLOAT;
    }
    
    return _shiningAnimation;
}

@end
