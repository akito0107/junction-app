//
//  OpenCVWrapper.h
//  cvdemo
//
//  Created by Akito Ito on 2018/03/24.
//  Copyright © 2018 Akito Ito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject
- (void)createCamera:(UIImageView*)parentView;
- (void)start;
- (int)getCode:(float)x y:(float)y;
@end

