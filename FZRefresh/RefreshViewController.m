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
@property (nonatomic,strong)UIView * backView;
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rowCount = 4;
            [weakSelf.tableView.fz_header endRefresh];
            [weakSelf.tableView reloadData];
        });
    } AnimationType:(AnimationTypeNormal)];
    
    
    self.tableView.fz_header = header;
    [header beginRefresh];
    
    //内部需使用弱引用
    RefreshFooterView * footer = [RefreshFooterView FooterWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rowCount += 4;
            [weakSelf.tableView.fz_footer endRefresh];
            [weakSelf.tableView reloadData];
        });
    } AnimationType:(AnimationTypeCustom)];
    self.tableView.fz_footer = footer;
//    [self setupBarView];
    
}
//-(void)setupBarView{
//    NSArray * sub = self.navigationController.navigationBar.subviews;
//    for (UIView * viw in sub) {
//        if ([viw isMemberOfClass:NSClassFromString(@"_UINavigationBarLargeTitleView")]) {
//            [viw addSubview:self.backView];
//            self.backView.backgroundColor = [UIColor blackColor];
//            self.backView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//            self.backView.frame = CGRectMake(0, 64, viw.bounds.size.width, viw.bounds.size.height);
//        }
//    }
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray * sub = self.navigationController.navigationBar.subviews;
    for (int i = 0; i<sub.count; i++) {
        UIView * vie = sub[i];
        UIColor * color = [UIColor colorWithRed:i * 60/255.0 green:i * 60/255.0 blue:i * 60/255.0 alpha:1];
        vie.backgroundColor = color;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowCount;
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
    }return _backView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)dealloc{
    NSLog(@"RefreshHeaderViewController delloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
