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
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.viewModel, @"viewModel对象为空，外部必须传入自己的viewModel地象");
    
    self.viewModel.containerWidth = self.view.frame.size.width;
    
    //调用viewDidLoad
    if (self.viewModel.viewDidLoad) {
        self.viewModel.viewDidLoad(self);
    }

    [self.viewModel buildLayoutStorage];
    
    @weakify(self);
    [[[RACObserve(self.viewModel, storage) takeUntil:self.rac_willDeallocSignal] ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self configHeaderAndFooter];
        [self.tableView reloadData];
    }];
}

- (void)configHeaderAndFooter {
    
    CellLayoutTableHeader *header = self.viewModel.storage.tableHeader;
    
    //配置头信息
    if (header) {
        
        if (!self.tableView.tableHeaderView) {
            self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, header.height)];
        }
        else {
            //修改高度
            CGRect frame = self.tableView.tableHeaderView.frame;
            frame.size.height = header.height;
            self.tableView.tableHeaderView.frame = frame;
        }
        
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
        
        if (!self.tableView.tableFooterView) {
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, footer.height)];
        }
        else {
            
            //修改高度
            CGRect frame = self.tableView.tableFooterView.frame;
            frame.size.height = footer.height;
            self.tableView.tableFooterView.frame = frame;
        }
        
        //调用配置方法
        if (footer.configFooter) {
            footer.configFooter(self.tableView.tableFooterView);
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

@end
