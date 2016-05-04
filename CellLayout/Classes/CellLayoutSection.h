//
//  CellLayoutSection.h

//
//  Created by Liu Zhen on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class CellLayoutManager;

@interface CellLayoutSection : NSObject <NSCopying>

@property (nonatomic, strong) NSString *title;
@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;

- (void)addLayoutManager:(CellLayoutManager *)layoutManager;
- (CellLayoutManager *)layoutManagerForRow:(NSInteger)row;
- (NSInteger)numberRows;

@end
