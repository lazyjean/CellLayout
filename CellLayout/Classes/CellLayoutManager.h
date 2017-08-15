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

//限制一定高度，如果布局的实际高度大于该高度，则按该高度布局(可方便的实现展开收起这种Cell的逻辑), 如果该值为0, 则代表不限制
@property (nonatomic) CGFloat restrictHeigth;

//如果内容实际高度大于限制的高度，则hasMore属性为YES, 否则为NO, 默认为NO
@property (nonatomic) BOOL hasMore;

@property (nonatomic, copy) void(^configCell)(__weak __kindof UITableViewCell *cell, __weak UITableViewController *parent);
@property (nonatomic, copy) void(^didSelect)(__weak UITableViewController *parent,__weak NSIndexPath *indexPath);

@end
