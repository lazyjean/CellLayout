# coding: utf-8
Pod::Spec.new do |s|
  s.name             = "CellLayout"
  s.version          = "3.8.1"
  s.summary          = "Table组件的封装"

  s.description      = <<-DESC
                        这个组件结合storybaord，可以高效的开发Table类型的页面，动态高度可变的Cell
                       DESC
  s.homepage         = "https://github.com/lazyjean/CellLayout"
  s.license          = 'MIT'
  s.author           = { "LiuZhen" => "lazy66@me.com" }
  s.source           = { :git => "https://github.com/lazyjean/CellLayout.git", :tag => "#{s.version}" }
  s.swift_version    = '5'
  s.ios.deployment_target = '9.0'
  s.source_files = 'CellLayout/**/*'
  s.dependency 'ReactiveCocoa', '~> 8.0.2'
  s.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.6'
  s.dependency 'SVPullToRefresh', '~> 0.4'

end
