//
//  NoMoreDataView.m
//  FZ-Refresh
//
//  Created by 王欣 on 2018/9/8.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "NoMoreDataView.h"
@interface NoMoreDataView()
@property (nonatomic,strong)UILabel * tipLab;

@end
@implementation NoMoreDataView

-(void)setupSublayers{
    [self addSubview:self.tipLab];
    self.tipLab.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint * CenterX = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0];
    NSLayoutConstraint * CenterY = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeCenterY)   relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1 constant:0];
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeWidth) multiplier:0.8 constant:0];
    NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationLessThanOrEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:30];
    [self addConstraints:@[CenterX,CenterY,width,height]];
}

-(UILabel *)tipLab{
    if (!_tipLab) {
        _tipLab = [[UILabel alloc]init];
        _tipLab.textColor = [UIColor darkGrayColor];
        _tipLab.text = @"无更多数据";
        _tipLab.numberOfLines = 0;
        _tipLab.font = [UIFont systemFontOfSize:16];
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }return _tipLab;
}
@end
