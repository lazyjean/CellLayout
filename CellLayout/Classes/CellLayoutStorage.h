//
//  CellLayoutStorage.h

//
//  Created by Liu Zhen on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class CellLayoutManager, CellLayoutSection, CellLayoutTableHeader, CellLayoutTableFooter, UIViewController;

@interface CellLayoutStorage : NSObject <NSCopying>

/**
 *  存储表头的信息
 */
@property (nonatomic, strong) CellLayoutTableHeader *tableHeader;

/**
 *  存储表底的信息
 */
@property (nonatomic, strong) CellLayoutTableFooter *tableFooter;

/**
 *  当前正在布局的section
 */
@property (nonatomic, readonly) CellLayoutSection *layoutSection;

/**
 *  当前正在配置的LayoutManager
 */
@property (nonatomic, readonly) CellLayoutManager *layoutManager;

/**
 *  设置左侧导航按钮
 */
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;

/**
 *  设置右侧导航按钮
 */
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;


- (CellLayoutManager *)layoutManagerForIndexPath:(NSIndexPath *)indexPath;

- (CellLayoutSection *)layoutSectionForSection:(NSInteger)section;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  添加一个section
 *
 *  @param layoutSection section对象
 */
- (void)addLayoutSection:(CellLayoutSection *)layoutSection;

/**
 *  以指定的参数在内部创建一个section, 同时将下在布局的section保存起来, 整个布局完全结束后，请调用
 *
 *  @param title        section的标题
 *  @param headerHeight header的高度
 *  @param footerHeight footer的高度
 */
- (void)newSectionWithTitle:(NSString *)title headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight;

/**
 *  将layoutManager添加到当前正在布局的section中
 *
 *  @param layoutManager 将要添加的layoutManager
 */
- (void)addLayoutManager:(CellLayoutManager *)layoutManager;

/**
 *  在当前的section下面创建一个LayoutManager, 如果当前没有创建Section, 该调用会失败
 *
 *  @param identifier LayoutManager的标识。该标识主要用于Cell的复用ID
 *
 */
- (void)newLayoutManagerWithIdentifier:(NSString *)identifier;

@end
