//
//  ViewController.m
//  CRIconView
//
//  Created by Bear on 2017/9/5.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "CRMaskAnimationView.h"
#import "CRShiningAnimationView.h"
#import "TestLayerView.h"
#import <BearSkill/UIView+BearSet.h>
#import <BearSkill/BearDefines.h>

@interface ViewController ()
{
    CRMaskAnimationView *_maskAnimationView;
    CRShiningAnimationView *_shiningAnimationView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"homgBg"];
    [self.view addSubview:bgImageView];
    
    //[self createMaskAnimationView];
    [self createShiningAnimationView];
    
//    [self createTestLayerView];
}

- (void)createMaskAnimationView
{
    _maskAnimationView = [[CRMaskAnimationView alloc] initWithFrame:self.view.bounds];
    _maskAnimationView.maskImageView.image = [UIImage imageNamed:@"CRIcon"];
    [self.view addSubview:_maskAnimationView];
    [_maskAnimationView startLoopScaleAnimation];
}

- (void)createShiningAnimationView
{
    _shiningAnimationView = [[CRShiningAnimationView alloc] initWithFrame:self.view.bounds];
    _shiningAnimationView.maskImageView.image = [[UIImage imageNamed:@"CRIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _shiningAnimationView.maskImageView.tintColor = [UIColor brownColor];
    [self.view addSubview:_shiningAnimationView];
    
    [_shiningAnimationView startShining];
}

- (void)createTestLayerView
{
    TestLayerView *testLayerView = [[TestLayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:testLayerView];
}

@end
