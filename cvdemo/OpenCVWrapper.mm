//
//  OpenCVWrapper.m
//  cvdemo
//
//  Created by Akito Ito on 2018/03/24.
//  Copyright © 2018 Akito Ito. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/aruco.hpp>

#include <iostream>

#import "OpenCVWrapper.h"

using namespace cv;
using namespace std;

@interface OpenCVWrapper() <CvVideoCameraDelegate> {
    CvVideoCamera *cvCamera;
    vector<cv::Rect> subjects;
    vector<int> ids;
}
@end

@implementation OpenCVWrapper

- (void)processImage:(Mat&)image {
    Mat cp;
    Mat image_copy;
    cvtColor(image, image_copy, CV_BGRA2RGB);
    
    Ptr< aruco::Dictionary> markerDictionary = aruco::getPredefinedDictionary(aruco::DICT_4X4_50);
    
    std::vector<int> marker_ids;
    std::vector<std::vector<cv::Point2f>> marker_corners;
    cv::Ptr<cv::aruco::DetectorParameters> parameters = cv::aruco::DetectorParameters::create();
    
    aruco::detectMarkers(image_copy, markerDictionary, marker_corners, marker_ids, parameters);
    cv::aruco::drawDetectedMarkers(image_copy, marker_corners, marker_ids);
    cvtColor(image_copy, image, CV_RGB2BGRA);
    
    subjects.clear();
    ids.clear();
    
    for (auto mc : marker_corners) {
        cv::Rect brect = boundingRect(mc);
        subjects.push_back(brect);
    }
    for (auto i : marker_ids) {
        ids.push_back(i);
    }

    //image.copyTo(cp);
    //Mat image_copy;
    //Mat image_blur;
    //cvtColor(image, image_copy, CV_BGRA2GRAY);
    //GaussianBlur(image_copy, image_blur, cv::Size(11, 11), 0, 0);
    //Mat image_thresh;
    //adaptiveThreshold(image_blur, image_thresh, 255, ADAPTIVE_THRESH_GAUSSIAN_C, THRESH_BINARY_INV, 11, 3);
    //vector<vector<cv::Point> > contours;
    //findContours(image_thresh, contours, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
    
    //double th_area = cp.size().height * cp.size().width / 50;
    //vector<vector<cv::Point>> contours_large;
    //for(auto c : contours) {
    //    if (contourArea(c) > th_area) {
    //        contours_large.push_back(c);
    //    }
    //}
    //subjects.clear();
    //for(auto c : contours_large) {
    //    if(contourArea(c) < 4) {
    //        continue;
    //    }
     //   cv::Rect brect = boundingRect(c);
     //   rectangle(image, cv::Point(brect.x, brect.y), cv::Point(brect.x + brect.width, brect.y + brect.height), Scalar(100, 255, 100), 3);
     //   subjects.push_back(brect);
    //}
}

- (void)createCamera:(UIImageView*)parentView {
    cvCamera = [[CvVideoCamera alloc] initWithParentView:parentView];
    
    cvCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    cvCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    cvCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    cvCamera.defaultFPS = 30;
    cvCamera.grayscaleMode = NO;
    
    cvCamera.delegate = self;
}

- (void) start {
    [cvCamera start];
}

- (int) getCode:(float)x y:(float)y {
    for (int i = 0; i < subjects.size(); i++) {
        NSLog(@"Show Console Log : %d" , subjects[i].x);
        NSLog(@"Show Console Log : %d" , subjects[i].width);
        NSLog(@"Show Console Log : %d" , subjects[i].y);
        NSLog(@"Show Console Log : %d" , subjects[i].height);
        if (subjects[i].x < x && subjects[i].x + subjects[i].width > x && subjects[i].y < y && subjects[i].y + subjects[i].height + 50> y) {
            
            return ids[i];
        }
    }
    
    
    return -1;
}
@end
