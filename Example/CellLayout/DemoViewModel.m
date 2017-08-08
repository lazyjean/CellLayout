//
//  DemoViewModel.m
//  CellLayoutSample
//
//  Created by 刘 真 on 3/3/16.
//  Copyright © 2016 Liu Zhen. All rights reserved.
//

#import "DemoViewModel.h"
#import "CellLayoutStorage.h"
#import "CellLayoutManager.h"
#import "CellLayoutSection.h"
#import "DemoTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <ReactiveCocoa/RACEXTScope.h>
#import "CellLayoutTableHeader.h"
#import "CellLayoutTableFooter.h"

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

- (void)buildLayoutStorage {
    
    @weakify(self);

    //下拉刷新
    self.pullRefreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIRefreshControl *input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    CellLayoutStorage *storage = [[CellLayoutStorage alloc] init];
//    CellLayoutTableHeader *header = [[CellLayoutTableHeader alloc] init];
//    header.height = 128;
//    header.identifier = @"v1";
//    header.configHeader = ^(UIView *view, UIViewController *parent){
//        view.backgroundColor = [UIColor colorWithRed:0.6824 green:0.1091 blue:0.1599 alpha:1.0];
//    };
//    
//    storage.tableHeader = header;
//    
//    CellLayoutTableFooter *footer = [[CellLayoutTableFooter alloc] init];
//    footer.height = 128;
//    footer.identifier = @"v2";
//    footer.configFooter = ^(UIView *view, UIViewController *parent){
//        view.backgroundColor = [UIColor colorWithRed:0.6824 green:0.1091 blue:0.1599 alpha:1.0];
//    };
//    
//    storage.tableFooter = footer;

    
    [storage newSectionWithTitle:@"文章标题" headerHeight:19 footerHeight:1];

    [storage newLayoutManagerWithIdentifier:@"DemoTableViewCell"];
    
    storage.layoutManager.configCell = ^(__weak DemoTableViewCell *cell, UIViewController *parent) {
        @strongify(self);
        cell.dynamicLabel.text = self.dataSource[0];
    };
    
    [storage newLayoutManagerWithIdentifier:@"DemoTableViewCell"];
    storage.layoutManager.configCell = ^(__weak DemoTableViewCell *cell, UIViewController *parent) {
        @strongify(self);
        cell.dynamicLabel.text = self.dataSource[1];
    };
    
    self.storage = storage;
}

@end
