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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

}
- (IBAction)tapAction:(UIButton *)sender {
    RefreshViewController * control = [[RefreshViewController alloc]initWithNibName:@"RefreshViewController" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

