# coding: utf-8
Pod::Spec.new do |s|
  s.name             = "CellLayout"
  s.version          = "2.0.0-alpha4"
  s.summary          = "Table组件的封装"

  s.description      = <<-DESC
                        这个组件结合storybaord，可以高效的开发Table类型的页面，动态高度可变的Cell
                       DESC
  s.homepage         = "https://gitee.com/leeszi/CellLayout"
  s.license          = 'MIT'
  s.author           = { "LiuZhen" => "lazy66@me.com" }
  s.source           = { :git => "git@gitee.com:leeszi/CellLayout.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '9.0'
  s.source_files = 'CellLayout/**/*'
  s.dependency 'ReactiveCocoa', '~> 6.0'
  s.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.6'
  s.dependency 'SVPullToRefresh', '~> 0.4'
end
