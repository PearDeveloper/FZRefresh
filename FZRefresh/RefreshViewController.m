//
//  RefreshHeaderViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RefreshViewController.h"
#import "RefreshHeaderView.h"
#import "UIScrollView+Refresh.h"
@interface RefreshViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic,assign)NSInteger rowCount;
@end

@implementation RefreshViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowCount = 4;
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.title = @"刷新";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    RefreshHeaderView * header =  [RefreshHeaderView headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rowCount = 4;
            [weakSelf.tableView.fz_header endRefresh];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.fz_footer ResetNoMoreData];
        });
    } AnimationType:(AnimationTypeIndicatorView)];
    
    
    self.tableView.fz_header = header;
    [header beginRefresh];
    
    //内部需使用弱引用
    RefreshFooterView * footer = [RefreshFooterView FooterWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rowCount += 4;
            [weakSelf.tableView.fz_footer endRefreshingWithNoMoreData];
            [weakSelf.tableView reloadData];
        });
    } AnimationType:(AnimationTypeCustom)];
    self.tableView.fz_footer = footer;
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowCount;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)dealloc{
//    self.[navigationController.navigationBar remove]
    NSLog(@"RefreshHeaderViewController delloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
