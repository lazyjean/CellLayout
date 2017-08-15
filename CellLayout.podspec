# coding: utf-8
Pod::Spec.new do |s|
  s.name             = "CellLayout"
  s.version          = "1.4.0"
  s.summary          = "Table组件的封装"

  s.description      = <<-DESC
                        这个组件结合storybaord，可以高效的开发Table类型的页面，动态高度可变的Cell
                       DESC
  s.homepage         = "http://git.oschina.net/leeszi/CellLayout"
  s.license          = 'MIT'
  s.author           = { "LiuZhen" => "lazy66@me.com" }
  s.source           = { :git => "https://git.oschina.net/leeszi/CellLayout.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '8.0'
  s.source_files = 'CellLayout/Classes/**/*'
  s.public_header_files = 'CellLayout/Classes/*.h'
  s.dependency 'ReactiveCocoa', '~> 2.5'
  s.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.6'
  s.dependency 'ReactiveViewModel', '~> 0.3'
  s.dependency 'SVPullToRefresh', '~> 0.4'
end
