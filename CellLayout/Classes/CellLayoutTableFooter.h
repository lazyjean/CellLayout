//
//  CellLayoutTableFooter.h

//
//  Created by Jean on 9/13/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface CellLayoutTableFooter : NSObject

@property (nonatomic) CGFloat height;

/**
 *  如果设置了此属性，则会优先在view的池中寻找对应的header/footer(对应的restoration ID)
 */
@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, copy) void (^configFooter)(__weak id footer, __weak UITableViewController *parent);

@end
