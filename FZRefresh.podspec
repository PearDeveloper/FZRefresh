Pod::Spec.new do |s|
s.name         = 'FZRefresh'
s.version      = '1.5'
s.summary      = '下拉刷新控件,使用简单.支持多种动画类型.支持继承UIScrollview的控件(UITableview,UICollectionview)'
s.homepage     = 'https://github.com/ClingCoder0/FZRefresh'
s.license      = 'MIT'
s.authors      = {'ClingCoder' => 'clingwxin@163.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/ClingCoder0/FZRefresh.git', :tag => s.version}
s.source_files = 'FZ-Refresh/**/*.{h,m}'
s.requires_arc = true
end

