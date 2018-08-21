//
//  BaseAnimationView.h
//  PullToRefresh
//
//  Created by 王欣 on 2018/8/20.
//  Copyright © 2018年 王欣. All rights reserved.
//
#define animationTime 1.2
#import <UIKit/UIKit.h>

@interface BaseAnimationView : UIView
@property (nonatomic,assign)BOOL isHeader;
-(void)startAnimation;
-(void)stopAnimaiton;
-(void)prepare;
-(void)setupSublayers;
-(void)updateWithProgress:(CGFloat)progress isHeader:(BOOL)header;
@end
