//
//  NormalAniationView.m
//  PullToRefresh
//
//  Created by 王欣 on 2018/8/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "NormalAniationView.h"
@interface NormalAniationView()
@property (nonatomic,strong)UILabel *  tipLab;
@property (nonatomic,strong)CAShapeLayer * oneLayer;
@property (nonatomic,strong)CAShapeLayer * twoLayer;
@property (nonatomic,strong)UIBezierPath * startPath;
@property (nonatomic,assign)CGFloat progress;
@end

@implementation NormalAniationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
    }return self;
}
-(void)prepare{
    self.backgroundColor = [UIColor clearColor];
}

//布局子视图
-(void)setupSublayers{
    [self addSubview:self.tipLab];
    [self.layer addSublayer:self.oneLayer];
    [self.layer addSublayer:self.twoLayer];
    self.tipLab.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0];
    NSLayoutConstraint * CenterY = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeCenterY)   relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1 constant:0];
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeRight) multiplier:1 constant:0];
    NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:self.tipLab attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationLessThanOrEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:30];
    [self addConstraints:@[left,CenterY,right,height]];
    
}

-(void)updateWithProgress:(CGFloat)progress isHeader:(BOOL)header{
    self.progress = progress;
    if (progress <1) {
        self.tipLab.text = header? @"下拉刷新":@"上拉加载";
        [self makeNonarmalPathisHeader:header];
    }else if (progress >= 1){
        self.tipLab.text = header? @"释放刷新":@"释放加载";
        [self makeWillRefreshPathisHeader:header];
    }
}
//重新布局
-(void)layoutSubviews{
    [self layOutLayer];
}
//开始动画
-(void)startAnimation{
    self.tipLab.text = @"加载中...";
    [self makeRefreshPath];
    [self addAnimation];
}

-(void)addAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue   = [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = animationTime * 0.8;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.oneLayer addAnimation:animation forKey:nil];
    [self.twoLayer addAnimation:animation forKey:nil];
}


//结束动画
-(void)stopAnimaiton{
   self.tipLab.text = @"结束加载";
    [self.oneLayer removeAllAnimations];
    [self.twoLayer removeAllAnimations];
    
}
-(void)layOutLayer{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGRect rect =  CGRectMake(width * 0.5 - height, 0, height, height);
    self.oneLayer.frame = rect;
    self.twoLayer.frame = rect;
}

-(void)makeNonarmalPathisHeader:(BOOL)header{
    CGFloat height = self.bounds.size.height;
    CGFloat center = height/2;
    CGFloat oneLayerHeigh = 20;
    UIBezierPath * onePath = [UIBezierPath bezierPath];
    CGPoint point = CGPointMake(center, center - oneLayerHeigh/2);
    CGPoint point1 = CGPointMake(center, center + oneLayerHeigh/2);
    [onePath moveToPoint:point];
    [onePath addLineToPoint:point1];
    self.oneLayer.path = onePath.CGPath;
    UIBezierPath * twoPath = [UIBezierPath bezierPath];

    CGPoint twoPoint = header?CGPointMake(center - 6, center + oneLayerHeigh/2 - 8):CGPointMake(center - 6, center - oneLayerHeigh/2 + 8);
    CGPoint twoPoint1 =header? CGPointMake(center, center + oneLayerHeigh/2): CGPointMake(center, center - oneLayerHeigh/2);
    CGPoint twoPoint2 =header? CGPointMake(center + 6, center + oneLayerHeigh/2 -8):CGPointMake(center + 6, center - oneLayerHeigh/2 +8);
    
    [twoPath moveToPoint:twoPoint];
    [twoPath addLineToPoint:twoPoint1];
    [twoPath addLineToPoint:twoPoint2];
    self.twoLayer.path = twoPath.CGPath;
    self.oneLayer.strokeStart = 0;
    self.twoLayer.strokeStart = 0;
    self.twoLayer.strokeEnd = self.progress;
    self.oneLayer.strokeEnd = self.progress;
}

-(void)makeRefreshPath{
    CGRect bouns = self.oneLayer.bounds;
    UIBezierPath * path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(bouns, 15, 15) cornerRadius:10];
    self.oneLayer.path = path1.CGPath;
    self.oneLayer.strokeStart = 0;
    self.oneLayer.strokeEnd = 0.3;
    self.twoLayer.path = path1.CGPath;
    self.twoLayer.strokeStart = 0.5;
    self.twoLayer.strokeEnd = 0.8;
    
}

-(void)makeWillRefreshPathisHeader:(BOOL)header{
    CGFloat height = self.bounds.size.height;
    CGFloat centerY = height/2;
    CGFloat oneLayerHeigh = 20;
    UIBezierPath * onePath = [UIBezierPath bezierPath];
    CGPoint point = CGPointMake(centerY, centerY - oneLayerHeigh/2);
    CGPoint point1 = CGPointMake(centerY, centerY + oneLayerHeigh/2);
    [onePath moveToPoint:point];
    [onePath addLineToPoint:point1];
    self.oneLayer.path = onePath.CGPath;
    UIBezierPath * twoPath = [UIBezierPath bezierPath];
    CGPoint twoPoint = header?CGPointMake(centerY - 6, centerY - oneLayerHeigh/2 + 8):CGPointMake(centerY - 6, centerY + oneLayerHeigh/2 - 8);
    CGPoint twoPoint1 =header? CGPointMake(centerY, centerY - oneLayerHeigh/2): CGPointMake(centerY, centerY + oneLayerHeigh/2);
    CGPoint twoPoint2 =header? CGPointMake(centerY + 6, centerY - oneLayerHeigh/2 + 8):CGPointMake(centerY + 6, centerY + oneLayerHeigh/2  -8);
    [twoPath moveToPoint:twoPoint];
    [twoPath addLineToPoint:twoPoint1];
    [twoPath addLineToPoint:twoPoint2];
    self.twoLayer.path = twoPath.CGPath;
}

-(CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.lineWidth = 2;
        _oneLayer.strokeColor = [UIColor redColor].CGColor;
        _oneLayer.fillColor = UIColor.clearColor.CGColor;
    }return _oneLayer;
}
-(CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.lineWidth = 2;
        _twoLayer.strokeColor = [UIColor redColor].CGColor;
        _twoLayer.fillColor = UIColor.clearColor.CGColor;
        _twoLayer.backgroundColor = [UIColor clearColor].CGColor;
        
    }return _twoLayer;
}
-(UILabel *)tipLab{
    if (!_tipLab) {
        _tipLab = [[UILabel alloc]init];
        _tipLab.textColor = [UIColor darkGrayColor];
        _tipLab.text = @"正在下拉";
        _tipLab.numberOfLines = 0;
        _tipLab.font = [UIFont systemFontOfSize:14];
    }return _tipLab;
}

@end
