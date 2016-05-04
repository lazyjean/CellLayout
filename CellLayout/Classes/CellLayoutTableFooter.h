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
@property (nonatomic, copy) void (^configFooter)(UIView *footer);

@end
