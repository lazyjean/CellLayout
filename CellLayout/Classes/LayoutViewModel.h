//
//  RentTableViewModel.h

//
//  Created by Jean on 9/13/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <CoreGraphics/CoreGraphics.h>

@import UIKit;

@class CellLayoutStorage, UITableViewController, RACCommand;

/**
 *  子类在继承该类时，如果需要和SchemeNavigator配合使用，那么需要实现NSCoding方法，将子类需要的参数进行归档即可
 */
@interface LayoutViewModel : RVMViewModel <NSCoding>

@property (nonatomic) CGFloat containerWidth;
@property (nonatomic, strong) CellLayoutStorage *storage;

/**
 *  该方法必须在init方法中调用，因为底层是在viewDidLoad中，buildLayoutStorage之前调用的该block,所以不能在buildLayoutStorage中调用该方法
 */
@property (nonatomic, copy) void(^viewDidLoad)(UITableViewController *controller);

//控制器指针
@property (nonatomic, weak) UITableViewController *controller;

//当下拉刷新错发时，该信号触发
@property (nonatomic, strong) RACCommand *pullRefreshCommand;

- (void)buildLayoutStorage;

/**
 *  生成一个URL, 并将当前viewModel做为参数，填在url后面
 *
 *  @param scheme         scheme名称（？？后续是否要做成自动从plist文件中读取的方式）
 *  @param storyboardName 因为CellLayout方法必须告诉是从哪个storyboard上来的，所以这里必须给一个storyboard名字
 *
 *  @return 指定的url
 */
- (NSURL *)urlForScheme:(NSString *)scheme storyboardName:(NSString *)storyboardName;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
