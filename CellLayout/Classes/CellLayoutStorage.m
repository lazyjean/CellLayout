//
//  CellLayoutStorage.m

//
//  Created by Liu Zhen on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import "CellLayoutStorage.h"
#import "CellLayoutSection.h"
#import "CellLayoutManager.h"

@import UIKit;

@interface CellLayoutStorage ()

/**
 *  所有布局好的section
 */
@property (nonatomic, strong) NSMutableArray *sections;

/**
 *  当前正在布局的section
 */
@property (nonatomic, strong) CellLayoutSection *layoutSection;

/**
 *  当前正在配置的LayoutManager
 */
@property (nonatomic, strong) CellLayoutManager *layoutManager;

@end

@implementation CellLayoutStorage

- (instancetype)init {
    if (self) {
        self.sections = [NSMutableArray array];
    }
    return self;
}

- (CellLayoutManager *)layoutManagerForIndexPath:(NSIndexPath *)indexPath {
    CellLayoutSection *section = self.sections[indexPath.section];
    return [section layoutManagerForRow:indexPath.row];
}

- (CellLayoutSection *)layoutSectionForSection:(NSInteger)section {
    return self.sections[section];
}

- (void)addLayoutSection:(CellLayoutSection *)layoutSection {
    [self.sections addObject:layoutSection];
}

- (NSInteger)numberOfSections {
    return [self.sections count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    CellLayoutSection *layout = self.sections[section];
    return [layout numberRows];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    CellLayoutStorage *copy = [[[self class] allocWithZone:zone] init];
    copy.sections = [self.sections copy];
    return copy;
}

#pragma mark - 新的构造Seciton, Manager的函数
- (void)newSectionWithTitle:(NSString *)title headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight {
    
    //重新起一个新的section
    self.layoutSection = [[CellLayoutSection alloc] init];
    self.layoutSection.title = title;
    self.layoutSection.headerHeight = headerHeight;
    self.layoutSection.footerHeight = footerHeight;
    
    [self addLayoutSection:self.layoutSection];
}

- (void)addLayoutManager:(CellLayoutManager *)layoutManager {
    NSAssert(self.layoutSection, @"当前没有正在布局的Section, 请先调用newSectionWithTitle:headerHeight:footerHeight方法，起一个secion");
    [self.layoutSection addLayoutManager:layoutManager];
}

- (void)newLayoutManagerWithIdentifier:(NSString *)identifier {
    self.layoutManager = [[CellLayoutManager alloc] init];
    self.layoutManager.identifier = identifier;
    [self addLayoutManager:self.layoutManager];
}

@end
