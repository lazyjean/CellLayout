# CellLayout

[![CI Status](http://img.shields.io/travis/LiuZhen/CellLayout.svg?style=flat)](https://travis-ci.org/LiuZhen/CellLayout)
[![Version](https://img.shields.io/cocoapods/v/CellLayout.svg?style=flat)](http://cocoapods.org/pods/CellLayout)
[![License](https://img.shields.io/cocoapods/l/CellLayout.svg?style=flat)](http://cocoapods.org/pods/CellLayout)
[![Platform](https://img.shields.io/cocoapods/p/CellLayout.svg?style=flat)](http://cocoapods.org/pods/CellLayout)

## 说明
iOS开发中，UI的开发是比较费时费力的工作，而storyboard的出现，可以大大的提高生产效率，而且不会带来太多的性能问题。但是storyboard在使用上还是不够的方便，该组件就是针对storyboard设计的，可以方便的构造基于TableView的页面。
## 样便

1. 在storybaord中拖出你想要的UI,并且设置好自动布局信息如下图所示
![](http://git.oschina.net/uploads/images/2016/0504/214026_d85b4ac0_122810.png)

2. 创建自己的ViewModel,代码中如下:

```ObjC
#import "DemoViewModel.h"
#import "CellLayoutStorage.h"
#import "CellLayoutManager.h"
#import "CellLayoutSection.h"
#import "DemoTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <ReactiveCocoa/RACEXTScope.h>
#import "CellLayoutTableHeader.h"

@implementation DemoViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSource = @[
                            @"飞鸟集》是印度诗人泰戈尔的代表作之一，也是世界上最杰出的诗集之一，它包括325首清丽的无标题小诗。白昼和黑夜、溪流和海洋、自由和背叛，都在泰戈尔的笔下合二为一，短小的语句道出了深刻的人生哲理，引领世人探寻真理和智慧的源泉。",
                            @"《飞鸟集》创作于1913年，初版于1916年完成。《飞鸟集》其中的一部分由诗人译自自己的孟加拉文格言诗集《碎玉集》（1899），另外一部分则是诗人1916年造访日本时的即兴英文诗作。诗人在日本居留三月有余，不断有淑女求其题写扇面或纪念册。诗人曾经盛赞日本俳句的简洁，他的《飞鸟集》显然受到了这种诗体的影响。[2] "
                            ];

        self.viewDidLoad = ^(UIViewController *parent) {
            NSLog(@"view did load");
        };
    }
    return self;
}

//通过实现方法里面的布局信息，来定制自己的UI
- (void)buildLayoutStorage {

    @weakify(self);

    CellLayoutStorage *storage = [[CellLayoutStorage alloc] init];


    CellLayoutTableHeader *header = [[CellLayoutTableHeader alloc] init];
    header.height = 500;
    header.configHeader = ^(UIView *view, UIViewController *parent){
        view.backgroundColor = [UIColor colorWithRed:0.6824 green:0.1091 blue:0.1599 alpha:1.0];
    };

    storage.tableHeader = header;

    [storage newSectionWithTitle:@"文章标题" headerHeight:19 footerHeight:1];

    [storage newLayoutManagerWithIdentifier:@"DemoTableViewCell"];

    storage.layoutManager.configCell = ^(__weak UITableViewCell *cell, UIViewController *parent) {
        @strongify(self);
        DemoTableViewCell *c = (DemoTableViewCell *)cell;
        c.dynamicLabel.text = self.dataSource[0];
    };

    [storage newLayoutManagerWithIdentifier:@"DemoTableViewCell"];
    storage.layoutManager.configCell = ^(__weak UITableViewCell *cell, UIViewController *parent) {
        @strongify(self);
        DemoTableViewCell *c = (DemoTableViewCell *)cell;
        c.dynamicLabel.text = self.dataSource[1];
    };

    self.storage = storage;
}

@end
```

3. 然后直接直接构造LayoutController使用，代码如下：

```ObjC
DemoViewModel *model = [[DemoViewModel alloc] init];
 LayoutController *controller = [LayoutController instantiateWithStoryboardName:@"Table" viewModel:model];
 [self.navigationController pushViewController:controller animated:YES];
```
## Requirements
```
需要iOS7.0或更新版本
```
## Installation

CellLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CellLayout"
```

## Author

LiuZhen, lazy66@me.com

## License

CellLayout is available under the MIT license. See the LICENSE file for more info.
