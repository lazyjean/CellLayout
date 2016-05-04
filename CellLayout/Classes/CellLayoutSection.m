//
//  CellLayoutSection.m

//
//  Created by Liu Zhen on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import "CellLayoutSection.h"

@interface CellLayoutSection ()
@property (nonatomic, strong) NSMutableArray *layoutManagers;
@end

@implementation CellLayoutSection

- (instancetype)init {
    if (self) {
        self.layoutManagers = [NSMutableArray array];
    }
    return self;
}

- (void)addLayoutManager:(CellLayoutManager *)layoutManager {
    [self.layoutManagers addObject:layoutManager];
}

- (NSInteger)numberRows {
    return [self.layoutManagers count];
}

- (CellLayoutManager *)layoutManagerForRow:(NSInteger)row {
    return self.layoutManagers[row];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    CellLayoutSection *copy = [[[self class] allocWithZone:zone] init];
    copy.layoutManagers = [self.layoutManagers copy];
    return copy;
}

@end
