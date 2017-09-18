//
//  ContourTestView.m
//  CRIconView
//
//  Created by Bear on 2017/9/17.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "ContourTestView.h"
#import "opencv2/highgui/ios.h"

@interface ContourTestView ()
{
    UIImageView *imageView;
}

@end

@implementation ContourTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
//        [self test];
    }
    
    return self;
}

- (void)createUI
{
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self addSubview:imageView];
}

//- (void)test
//{
//    UIImage* image = [UIImage imageNamed:@"CRIcon"];
//    UIImageToMat(image, cvImage);
//    
//    if (!cvImage.empty()) {
//        cv::Mat gray;
//        cv::cvtColor(cvImage, gray, CV_RGBA2GRAY);
//        cv::GaussianBlur(gray, gray,
//                         cv::Size(5, 5), 1.2, 1.2);
//        cv::Mat edges;
//        cv::Canny(gray, edges, 0, 100);
//        // Fill image with white color
//        cvImage.setTo(cv::Scalar::all(255));
//        // Change color on edges
//        cvImage.setTo(cv::Scalar(0, 128, 255, 255), edges);
//        // Convert cv::Mat to UIImage* and show the resulting image
//        imageView.image = MatToUIImage(cvImage);
//        
//        cv::findContours(cvImage, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, cv::Point(0,0));
//        
//        
//        
//        //[self drawPathArray:pathArray];
//    }
//}

@end
