//
//  CellLayoutManager.h

//
//  Created by Liu Zhen on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellLayoutManager : NSObject <NSCopying>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, copy) void(^configCell)(__weak __kindof UITableViewCell *cell, __weak UITableViewController *parent);
@property (nonatomic, copy) void(^didSelect)(__weak UITableViewController *parent,__weak NSIndexPath *indexPath);

@end
