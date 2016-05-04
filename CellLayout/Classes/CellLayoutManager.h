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
@property (nonatomic, copy) void(^configCell)(__weak UITableViewCell *cell, __weak UIViewController *parent);
@property (nonatomic, copy) void(^didSelect)(__weak UIViewController *parent,__weak NSIndexPath *indexPath);

@end
