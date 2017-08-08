//
//  ViewController.m

//
//  Created by Jean on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import "LayoutController.h"
#import "LayoutViewModel.h"
#import "CellLayoutManager.h"
#import "CellLayoutSection.h"
#import "CellLayoutStorage.h"
#import "CellLayoutTableHeader.h"
#import "CellLayoutTableFooter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "UITableView+FDTemplateLayoutCell.h"

@interface CellLayoutStorage (Internal)

- (CellLayoutManager *)layoutManagerForIndexPath:(NSIndexPath *)indexPath;

- (CellLayoutSection *)layoutSectionForSection:(NSInteger)section;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

@end

@interface LayoutController ()

@property (nonatomic, strong) LayoutViewModel *viewModel;

@end

@implementation LayoutController

+ (instancetype)instantiateWithStoryboardName:(NSString *)storyboardName viewModel:(LayoutViewModel *)viewModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    LayoutController *controller = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    controller.viewModel = viewModel;
    return controller;
}

+ (UINavigationController *)instantiateNavWithStoryboardName:(NSString *)storyboardName viewModel:(LayoutViewModel *)viewModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UINavigationController *nav = [storyboard instantiateInitialViewController];
    LayoutController *controller = (LayoutController *)[nav topViewController];
    controller.viewModel = viewModel;
    return nav;
}
+ (instancetype)instantiateWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier viewModel:(LayoutViewModel *)viewModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    LayoutController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    controller.viewModel = viewModel;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.viewModel, @"viewModel对象为空，外部必须传入自己的viewModel地象");
    
    self.viewModel.containerWidth = self.view.frame.size.width;
    
    self.viewModel.controller = self;
    
    //调用viewDidLoad
    if (self.viewModel.viewDidLoad) {
        self.viewModel.viewDidLoad(self);
    }

    [self.viewModel buildLayoutStorage];
    
    @weakify(self);
    [[[RACObserve(self.viewModel, storage) takeUntil:self.rac_willDeallocSignal] ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        //设置导航
        self.navigationItem.leftBarButtonItem = self.viewModel.storage.leftBarButtonItem;
        self.navigationItem.rightBarButtonItem = self.viewModel.storage.rightBarButtonItem;
        
        //设置Table的Header和Footer
        [self configHeaderAndFooter];
        
        //刷新表格
        [self.tableView reloadData];
    }];

    //
    if (self.viewModel.pullRefreshCommand) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.rac_command = self.viewModel.pullRefreshCommand;
    }

    //加载数据接口
    [self.viewModel loadData];
}

- (void)configHeaderAndFooter {
    
    CellLayoutTableHeader *header = self.viewModel.storage.tableHeader;
    
    //配置头信息
    if (header) {
        
        //如果设置了identifier，则优先查找
        if (header.identifier && header.identifier.length > 0) {
            for (UIView *v in self.viewsPool) {
                if ([v.restorationIdentifier isEqualToString:header.identifier]) {
                    self.tableView.tableHeaderView = nil;
                    self.tableView.tableHeaderView = v;
                    break;
                }
            }
        }
        
        //如果没有通过identifier查找到header, 则手工创建一个
        if (!self.tableView.tableHeaderView) {
            self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, header.height)];
        }
        
        //配置高度
        CGRect frame = self.tableView.tableHeaderView.frame;
        frame.size.height = header.height;
        self.tableView.tableHeaderView.frame = frame;
        
        //调用配置方法
        if (header.configHeader) {
            header.configHeader(self.tableView.tableHeaderView, self);
        }
    }
    else {
        self.tableView.tableHeaderView = nil;
    }
    
    CellLayoutTableFooter *footer = self.viewModel.storage.tableFooter;
    
    //配置footer信息
    if (footer) {
        
        //如果设置了identifier，则优先查找
        if (footer.identifier && footer.identifier.length > 0) {
            for (UIView *v in self.viewsPool) {
                if ([v.restorationIdentifier isEqualToString:footer.identifier]) {
                    self.tableView.tableFooterView = nil;
                    self.tableView.tableFooterView = v;
                    break;
                }
            }
        }

        //如果没有通过identifier查找到footer, 则手工创建一个
        if (!self.tableView.tableFooterView) {
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, footer.height)];
        }

        //修改高度
        CGRect frame = self.tableView.tableFooterView.frame;
        frame.size.height = footer.height;
        self.tableView.tableFooterView.frame = frame;
        
        //调用配置方法
        if (footer.configFooter) {
            footer.configFooter(self.tableView.tableFooterView, self);
        }
    }
    else {
        self.tableView.tableFooterView = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewModel.active = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.viewModel.active = NO;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel.storage numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.storage numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellLayoutManager *layoutManager = [self.viewModel.storage layoutManagerForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:layoutManager.identifier];
    cell.accessoryType = layoutManager.didSelect ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = layoutManager.didSelect ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    layoutManager.configCell(cell, self);
    NSAssert(cell, @"cell不能为空");
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellLayoutManager *layoutManager = [self.viewModel.storage layoutManagerForIndexPath:indexPath];
    return [tableView fd_heightForCellWithIdentifier:layoutManager.identifier cacheByIndexPath:indexPath configuration:^(id cell) {
        layoutManager.configCell(cell, self);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CellLayoutSection *layout = [self.viewModel.storage layoutSectionForSection:section];
    return layout.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CellLayoutSection *layout = [self.viewModel.storage layoutSectionForSection:section];
    return layout.footerHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellLayoutManager *layoutManager = [self.viewModel.storage layoutManagerForIndexPath:indexPath];
    @weakify(self);
    if (layoutManager.didSelect) {
        @strongify(self);
        layoutManager.didSelect(self, indexPath);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CellLayoutSection *layout = [self.viewModel.storage layoutSectionForSection:section];
    return layout.title;
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.viewModel prepareForSegue:segue sender:sender];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    [self.viewModel shouldPerformSegueWithIdentifier:identifier sender:sender];
}

@end
