//
//  BaseAnimationView.m
//  PullToRefresh
//
//  Created by 王欣 on 2018/8/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "BaseAnimationView.h"

@implementation BaseAnimationView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
        [self setupSublayers];
    }return self;
}
-(void)prepare{
    self.backgroundColor = [UIColor clearColor];
}
-(void)setupSublayers{
    
}
//更新进度
-(void)updateWithProgress:(CGFloat)progress isHeader:(BOOL)header{
    
}
//开始动画
-(void)startAnimation{
    
}

//结束动画
-(void)stopAnimaiton{
    
}
-(void)noMoreData:(BOOL)noMoreData{
    
}

@end
