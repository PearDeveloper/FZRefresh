# PullToRefresh

## 示例代码
RefreshHeaderView * header =  [RefreshHeaderView headerWithRefreshingBlock:^{
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[weakSelf.tableView.fz_header endRefresh];
});
} AnimationType:(AnimationTypeCustom)];

AnimationType传入不同的动画类型


## 示例图片

![Screenshot](https://github.com/PearDeveloper/FZRefresh/blob/master/%E7%A4%BA%E4%BE%8B%E5%9B%BE%E7%89%87.gif)
![Screenshot](https://github.com/PearDeveloper/FZRefresh/blob/master/%E7%A4%BA%E4%BE%8B%E5%9B%BE%E7%89%871.gif)
![Screenshot](https://github.com/PearDeveloper/FZRefresh/blob/master/%E7%A4%BA%E4%BE%8B%E5%9B%BE%E7%89%872.gif)

