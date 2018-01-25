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
    public var config: ((UITableViewCell) -> Void)?
    public var select: (() -> Void)?
    public var isOverlay: Bool = false
    
    init(identifier: String, isOverlay: Bool = false, config:((UITableViewCell) -> Void)? = nil, select:(() -> Void)? = nil) {
        self.identifier = identifier
        self.config = config
        self.select = select
    }
}
