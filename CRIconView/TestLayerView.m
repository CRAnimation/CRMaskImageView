//
//  TestLayerView.m
//  CRIconView
//
//  Created by Bear on 2017/9/9.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "TestLayerView.h"

@interface TestLayerView ()
{
    CAShapeLayer *_layer;
}

@end

@implementation TestLayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createLayer];
    }
    
    return self;
}

- (void)createLayer
{
    UIBezierPath *bezierPath1;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 300, 300)];
    [bezierPath removeAllPoints];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(300, 0)];
    [bezierPath addLineToPoint:CGPointMake(300, 100)];
    [bezierPath addLineToPoint:CGPointMake(200, 400)];
//    [bezierPath addLineToPoint:CGPointMake(0, 0)];
//    [bezierPath closePath];
    
    _layer = [CAShapeLayer layer];
    _layer.masksToBounds = YES;
    _layer.path = bezierPath.CGPath;
    _layer.fillColor = [[UIColor clearColor] colorWithAlphaComponent:0.0].CGColor;
    _layer.lineWidth = 0.5;
    _layer.strokeColor = [UIColor blackColor].CGColor;
    
    _layer.shadowPath = bezierPath.CGPath;
    _layer.shadowColor = [UIColor brownColor].CGColor;
    _layer.shadowOpacity = 1;
    _layer.shadowRadius = 5;
    _layer.shadowOffset = CGSizeMake(0, 0);
    
    _layer.frame = CGRectMake(50, 100, 300, 400);
//    _layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:_layer];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = bezierPath.CGPath;
//    maskLayer.
    _layer.mask = maskLayer;
}

@end
