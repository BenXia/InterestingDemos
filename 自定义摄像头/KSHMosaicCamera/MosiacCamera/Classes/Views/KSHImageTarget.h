//
//  KSHImageTarget.h
//  MosiacCamera
//
//  Created by 金聖輝 on 14/12/14.
//  Copyright (c) 2014年 kimsungwhee.com. All rights reserved.
//
#import <CoreMedia/CoreMedia.h>

@protocol KSHImageTarget <NSObject>
- (void)updateContentImage:(CIImage*)image;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com