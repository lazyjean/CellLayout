//
//  CellLayoutItem.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import Foundation
import UIKit

public final class CellLayoutRow {

    public var identifier: String
    public var config: ((UITableViewCell, CGFloat) -> Void)?
    public var select: (() -> Void)?
    public var isOverlay: Bool = false
    
    public init(identifier: String, isOverlay: Bool = false, config:((UITableViewCell, CGFloat) -> Void)? = nil, select:(() -> Void)? = nil) {
        self.identifier = identifier
        self.config = config
        self.select = select
        self.isOverlay = isOverlay
    }
}
