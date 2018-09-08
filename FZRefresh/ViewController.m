//
//  ViewController.m
//  safeArea
//
//  Created by 王欣 on 2018/8/19.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "ViewController.h"
#import "RefreshViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"样式%ld",indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RefreshViewController * control = [[RefreshViewController alloc]initWithNibName:@"RefreshViewController" bundle:nil];
    control.animationType = indexPath.row;
    [self.navigationController pushViewController:control animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

