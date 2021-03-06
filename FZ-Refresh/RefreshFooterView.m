//
//  RefreshFooterView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/18.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RefreshFooterView.h"
#import  <Foundation/Foundation.h>
#import "FZAnimationView.h"
#import "UIScrollView+Custom.h"
@implementation RefreshFooterView

+(RefreshFooterView*)FooterWithRefreshingBlock:(RefreshBlock)refreshingBlock AnimationType:(AnimationType)type{
    RefreshFooterView *cmp = [[self alloc] init];
    cmp.refreshBlock = refreshingBlock;
    cmp.animationType = type;
    return cmp;
}

-(void)prepare{
    [super prepare];
    self.backgroundColor = [UIColor clearColor];
}
-(void)setupFrame{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentSize.height;
    // 表格的高度
    CGRect rect = CGRectMake(0,contentHeight, self.scrollView.bounds.size.width, viewHeight);
    self.frame = rect;
}
//添加
-(void)setupItems{
    
    [self addSubview:self.animationView];
    self.animationView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * CenterX = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0];
    NSLayoutConstraint * Top = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeWidth) multiplier:0.7 constant:0];
    NSLayoutConstraint * Height = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeHeight) multiplier:1 constant:50];
    [self addConstraints:@[CenterX,Top,width,Height]];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (self.state == RefreshStateRefreshing){
        return;
    }
    if (self.scrollView.contentOffset.y <= 0) {
        self.hidden = YES;
        return;
    }
    CGFloat offsetY = 0;
    if ((self.scrollView.contentSize.height - self.scrollView.bounds.size.height) < 0) {
        offsetY = self.scrollView.contentOffset.y;
    }else{
        offsetY   = self.scrollView.contentOffset.y - (self.scrollView.contentSize.height- self.scrollView.bounds.size.height);
    }
    offsetY -= self.scrollView.re_insetB;
    CGFloat offset    = MAX(0, offsetY);    
    self.progress     = MIN(1, offset/viewHeight);
    if (offset <= 0) {
        self.hidden = YES;
        return;
    }
    self.hidden = false;
    if (self.state == RefreshStateNoMoreData) {
        return;
    }
    if (self.progress >= CriticalProgress) {
        self.state = RefreshStateWillRefresh;
    }else if(self.progress <= 0){
        self.state = RefreshStateIdle;
    }
    [self.animationView updateWithProgress:self.progress isHeader:false];
}

-(void)setState:(RefreshState)state{
    if (self.state == state) {
        return;
    }
    [super setState:state];
    if (self.state == RefreshStateIdle) {
        self.hasShake = false;
        self.hidden = YES;
        self.progress = 0;
    }else if (self.state == RefreshStatePulling){
        
    }else if ( self.state == RefreshStateWillRefresh){
        if (!self.hasShake) {
            self.hasShake = YES;
            [self makeShake];
        }
    }else if (self.state == RefreshStateRefreshing ){
        self.hidden = NO;
        [self Refresh];
    }else if (self.state == RefreshStateNoMoreData){
        [super setNoMoreDataView];
        NSLog(@"没有更多数据");
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [self setupFrame];
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
    UIGestureRecognizerState  state = [[change valueForKey:@"new"] integerValue];
    if (state == UIGestureRecognizerStateEnded) {
        if(self.progress >= CriticalProgress){
            if (self.state == RefreshStateWillRefresh) {
                self.state = RefreshStateRefreshing;
            }
        }
    }
}


//开始刷新
-(void)beginRefresh{
    self.state = RefreshStateRefreshing;
}
-(void)Refresh{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [super beginRefresh];
        self.progress = 1.0;
        [self.animationView startAnimation];
        [UIView animateWithDuration:RefreshAnimationTime animations:^{
            CGFloat bottom = self.scrollViewOriginalInset.bottom + viewHeight;
            if (self.scrollView.contentSize.height + bottom < self.scrollView.bounds.size.height ) {
                return;
            }
            self.scrollView.re_insetB = bottom;
            CGPoint offset = self.scrollView.contentOffset;
            offset.y = self.scrollView.contentSize.height - self.scrollView.bounds.size.height + bottom;
            [self.scrollView setContentOffset:offset animated:YES];
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    });
}


//结束刷新
-(void)endRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.state != RefreshStateRefreshing)return;
        
        [UIView animateWithDuration:RefreshAnimationTime animations:^{
            self.scrollView.re_insetB = self.scrollViewOriginalInset.bottom;
        } completion:^(BOOL finished) {
            self.state = RefreshStateIdle;
            [self.animationView stopAnimaiton];
        }];
    });
}

//结束刷新无更多数据
- (void)endRefreshingWithNoMoreData{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.state != RefreshStateRefreshing)return;
        
        [UIView animateWithDuration:RefreshAnimationTime animations:^{
            self.scrollView.re_insetB = self.scrollViewOriginalInset.bottom;
        } completion:^(BOOL finished) {
            self.state = RefreshStateIdle;
            [self.animationView stopAnimaiton];
            self.state = RefreshStateNoMoreData;
        }];
    });
}
- (void)ResetNoMoreData{
    [super setAnimationType:self.animationType];
    self.state = RefreshStateIdle;
}
@end
