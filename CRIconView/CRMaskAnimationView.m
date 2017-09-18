//
//  CRMaskAnimationView.m
//  CRIconView
//
//  Created by Bear on 2017/9/6.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRMaskAnimationView.h"
#import <BearSkill/BearDefines.h>
#import <BearSkill/UIView+BearSet.h>
#import <BearSkill/BearConstants.h>

static NSString *kAnimationKey_FadeOutGroup = @"kAnimationKey_FadeOutGroup";
static NSString *kAnimationKey_LoopScale = @"kAnimationKey_LoopScale";

@interface CRMaskAnimationView () <CAAnimationDelegate>
{
    int _loopCount;
    
    CABasicAnimation *_fadeOutScaleAnimation;
    CABasicAnimation *_fadeOutOpacityAnimation;
    CAAnimationGroup *_fadeOutAnimationGroup;
    
    CAKeyframeAnimation *_loopScaleAnimation;
}

@property (strong, nonatomic) CRMaskImageView *maskImageView;

@end

@implementation CRMaskAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initPara];
        [self createUI];
    }
    
    return self;
}

- (void)initPara
{
    self.backgroundColor = UIColorFromHEX(0x313340);
    _maxLoopCount = 2;
    _loopCount = 0;
    
    _fadeOutAnimationDuring = 1.3;
    _fadeOutOpacityAnimation = [CABasicAnimation animation];
    
    _loopScaleAnimationDuring = 3.0;
    _loopScaleAnimation = [CAKeyframeAnimation animation];
}

- (void)createUI
{
    _maskImageView = [[CRMaskImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 350)];
    [self addSubview:_maskImageView];
    [_maskImageView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    [self generateShadow];
    [self changeGradientLayerColorAnim:NO];
}

- (void)generateShadow
{
    _maskImageView.layer.shadowOpacity = 1;
    _maskImageView.layer.shadowColor = [UIColorFromHEX(0xe7f0fd) colorWithAlphaComponent:0.4].CGColor;
    _maskImageView.layer.shadowOffset = CGSizeMake(2, 2);
    _maskImageView.layer.shadowRadius = 3;
}

#pragma mark - Animation
- (void)fadeOutAnimation
{
    _fadeOutScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _fadeOutScaleAnimation.fromValue = @1.0;
    _fadeOutScaleAnimation.toValue = @9.0;
    
    _fadeOutOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    _fadeOutOpacityAnimation.fromValue = @1.0;
    _fadeOutOpacityAnimation.toValue = @0.0;
    
    _fadeOutAnimationGroup = [CAAnimationGroup animation];
    _fadeOutAnimationGroup.animations = [NSArray arrayWithObjects:_fadeOutScaleAnimation, _fadeOutOpacityAnimation, nil];
    _fadeOutAnimationGroup.duration = _fadeOutAnimationDuring;
    _fadeOutAnimationGroup.removedOnCompletion = NO;
    _fadeOutAnimationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    _fadeOutAnimationGroup.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:_fadeOutAnimationGroup forKey:kAnimationKey_FadeOutGroup];
}

- (void)startLoopScaleAnimation
{
    CGFloat deltaScale = 0.05;
    
    _loopScaleAnimation.keyPath = @"transform.scale";
    _loopScaleAnimation.values = @[@1.0, @(1.0 - deltaScale), @(1.0 + deltaScale), @1.0];
    _loopScaleAnimation.delegate = self;
    _loopScaleAnimation.removedOnCompletion = NO;
    _loopScaleAnimation.fillMode = kCAFillModeForwards;
    _loopScaleAnimation.duration = _loopScaleAnimationDuring;
    _loopScaleAnimation.beginTime = CACurrentMediaTime() + 0;
    _loopScaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_maskImageView.layer addAnimation:_loopScaleAnimation forKey:kAnimationKey_LoopScale];
}

- (void)changeGradientLayerColorAnim:(BOOL)animation
{
    if (animation) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:_loopScaleAnimationDuring];
    }
    [_maskImageView setGradientLayerFromColor:UIColorFromHEX(0xaccbee)
                                      ToColor:UIColorFromHEX(0xe7f0fd)
                                         axis:CRLAYOUT_AXIS_Vertical];
    
    //[_maskImageView setGradientLayerFromColor:[BearConstants randomColor]
                                     // ToColor:[BearConstants randomColor]
                                       //  axis:CRLAYOUT_AXIS_Vertical];
    if (animation) {
        [CATransaction commit];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

    if ([anim isEqual:[_maskImageView.layer animationForKey:kAnimationKey_FadeOutGroup]]) {
        [self removeFromSuperview];
    }
    else if ([anim isEqual:[_maskImageView.layer animationForKey:kAnimationKey_LoopScale]]) {
        
        _loopCount++;
        
        if (_loopCount < _maxLoopCount) {
            [self startLoopScaleAnimation];
            [self changeGradientLayerColorAnim:YES];
        }else{
            [_maskImageView.layer removeAnimationForKey:kAnimationKey_LoopScale];
            [self fadeOutAnimation];
        }
        
    }
}

@end
