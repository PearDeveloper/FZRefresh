//
//  ViewController.m
//  safeArea
//
//  Created by 王欣 on 2018/8/19.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "ViewController.h"
#import "RefreshViewController.h"
@interface ViewController ()
@property (nonatomic,strong)UIButton * tapBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tapBtn];
    
    self.tapBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * CenterX = [NSLayoutConstraint constraintWithItem:self.tapBtn attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0];
    NSLayoutConstraint * CenterY = [NSLayoutConstraint constraintWithItem:self.tapBtn attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeCenterY) multiplier:1 constant:0];
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:self.tapBtn attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeWidth) multiplier:1 constant:120];
    NSLayoutConstraint * Height = [NSLayoutConstraint constraintWithItem:self.tapBtn attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeHeight) multiplier:1 constant:40];
    [self.view addConstraints:@[CenterX,CenterY,width,Height]];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)tapAction:(UIButton*)btn{
    RefreshViewController * control = [[RefreshViewController alloc]initWithNibName:@"RefreshViewController" bundle:nil];
    
    [self.navigationController pushViewController:control animated:YES];
}
-(UIButton *)tapBtn{
    if(!_tapBtn){
        _tapBtn = [[UIButton alloc]init];
        _tapBtn.backgroundColor = [UIColor blackColor];
        [_tapBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_tapBtn setTitle:@"跳转" forState:(UIControlStateNormal)];
        [_tapBtn addTarget:self action:@selector(tapAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }return _tapBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

