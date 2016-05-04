//
//  CellLayoutTableHeader.h

//
//  Created by Jean on 9/13/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface CellLayoutTableHeader : NSObject

@property (nonatomic) CGFloat height;
@property (nonatomic, copy) void (^configHeader)(UIView *header, UIViewController *parent);

@end
