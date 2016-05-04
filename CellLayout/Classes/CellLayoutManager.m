//
//  CellLayoutManager.m

//
//  Created by Liu Zhen on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import "CellLayoutManager.h"

@implementation CellLayoutManager

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    CellLayoutManager *copy = [[[self class] allocWithZone:zone] init];
    copy.identifier = self.identifier;
    copy.configCell = self.configCell;
    copy.didSelect = self.didSelect;
    return copy;
}

@end
