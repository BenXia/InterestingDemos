//
//  KSHOverlayView.h
//  MosiacCamera
//
//  Created by 金聖輝 on 14/12/13.
//  Copyright (c) 2014年 kimsungwhee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol KSHPreviewViewDelegate<NSObject>
- (void)tappedToFocusAtPoint:(CGPoint)point;
- (void)tappedToExposeAtPoint:(CGPoint)point;
- (void)tappedToResetFocusAndExposure;
@end

@interface KSHOverlayView : UIView
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) id <KSHPreviewViewDelegate> tapedHandelDelegate;

@property (nonatomic, assign) BOOL tapToFocusEnabled;
@property (nonatomic, assign) BOOL tapToExposeEnabled;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com