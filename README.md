# PullToRefresh

## 示例代码
RefreshHeaderView * header =  [RefreshHeaderView headerWithRefreshingBlock:^{
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[weakSelf.tableView.fz_header endRefresh];
});
} AnimationType:(AnimationTypeCustom)];

AnimationType传入不同的动画类型


## 示例图片

![Screenshot](https://github.com/wangxin1991/PullToRefreshView/blob/master/示例图片.gif)
![Screenshot](https://github.com/wangxin1991/PullToRefreshView/blob/master/示例图片1.gif)
![Screenshot](https://github.com/wangxin1991/PullToRefreshView/blob/master/示例图片2.gif)

