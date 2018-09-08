//
//  AnimationView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "FZAnimationView.h"
@interface FZAnimationView()
@property (nonatomic,strong)CAShapeLayer * oneLayer;
@property (nonatomic,strong)CAShapeLayer * twoLayer;
@property (nonatomic,strong)UIBezierPath * startPath;
@property (nonatomic,strong)UIBezierPath * midPath;
@property (nonatomic,strong)UIBezierPath * endPath;
@property (nonatomic,assign)CGFloat layerWidth;
@end

@implementation FZAnimationView


-(void)setupSublayers{
    
    [self.layer addSublayer:self.oneLayer];
    [self.layer addSublayer:self.twoLayer];
}

-(void)startAnimation{
    [self addAnimaiton];
}
-(void)stopAnimaiton{
    [self removeAnimation];
}
-(void)removeAnimation{
    
    [self.oneLayer removeAllAnimations];
    [self.twoLayer removeAllAnimations];
}
-(void)updateWithProgress:(CGFloat)progress isHeader:(BOOL)header{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat centerX = width/2;
    CGFloat centerY = height/2;
    CGFloat layerWidth = 20;
    CGFloat gapping = 30;

    CGFloat y =  centerY  * MIN(1, progress);
    CGFloat oringY = header? (y +  layerWidth/2):(height  - y -  layerWidth/2);
    CGRect onerect = CGRectMake(centerX - gapping - layerWidth ,oringY, layerWidth, layerWidth);
    CGRect twoRect = CGRectMake(centerX  + gapping,oringY, layerWidth,layerWidth);
    self.oneLayer.frame = onerect;
    self.twoLayer.frame = twoRect;
}

-(void)addAnimaiton{

    
    CAKeyframeAnimation * baseAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    baseAniamtion.values = @[@([self endPoint].x),@([self startPoint].x),@([self endPoint].x)];
    baseAniamtion.keyTimes = @[@(0),@(0.5),@(1.0)];
    baseAniamtion.duration = animationTime;
    baseAniamtion.repeatCount = CGFLOAT_MAX;
    [self.oneLayer addAnimation:baseAniamtion forKey:@"ss"];
    
    
    CAKeyframeAnimation * baseAniamtion1 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    baseAniamtion1.values = @[@([self startPoint].x),@([self endPoint].x),@([self startPoint].x)];
    baseAniamtion1.keyTimes = @[@(0),@(0.5),@(1.0)];
    baseAniamtion1.duration = animationTime;
    baseAniamtion1.repeatCount = CGFLOAT_MAX;
    [self.twoLayer addAnimation:baseAniamtion1 forKey:@""];

}



-(void)layoutSubviews{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat centerX = width/2;
    CGFloat centerY = height/2;
    CGFloat layerWidth = 20;
    CGFloat gapping = 30;
    CGRect onerect = CGRectMake(centerX - gapping - layerWidth ,centerY - layerWidth/2, layerWidth, layerWidth);
    CGRect twoRect = CGRectMake(centerX  + gapping,centerY - layerWidth/2, layerWidth,layerWidth);
    self.oneLayer.frame = onerect;
    self.twoLayer.frame = twoRect;
    UIBezierPath * twoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_twoLayer.bounds, 2, 2) cornerRadius:(_twoLayer.bounds.size.height - 2)/2];
    self.twoLayer.path = twoPath.CGPath;
    UIBezierPath * onePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.oneLayer.bounds, 2, 2) cornerRadius:(self.oneLayer.bounds.size.height - 2)/2];
    self.oneLayer.path = onePath.CGPath;
}

-(CGPoint )startPoint{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat centerX = width/2;
    CGFloat centerY = height/2;
    CGFloat layerWidth = 20;
    CGFloat gapping = 30;
    CGPoint point = CGPointMake(centerX  + gapping + layerWidth/2, centerY - layerWidth/2);
    return point;

}

-(CGPoint )endPoint{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat centerX = width/2;
    CGFloat centerY = height/2;
    CGFloat layerWidth = 20;
    CGFloat gapping = 30;
    CGPoint point1 = CGPointMake(centerX - gapping - layerWidth/2,centerY - layerWidth/2);
    return point1;
}

-(CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.lineWidth = 1;
        _oneLayer.fillColor = UIColor.redColor.CGColor;
    }return _oneLayer;
}
-(CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.lineWidth = 1;
        _twoLayer.fillColor = [UIColor greenColor].CGColor;
    }return _twoLayer;
}



@end
