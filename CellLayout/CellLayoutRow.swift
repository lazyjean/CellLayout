//
//  CellLayoutItem.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import Foundation
import UIKit

final class CellLayoutRow {
    var identifier: String
    var config: ((UITableViewCell) -> Void)?

    init(identifier: String, _ config:((UITableViewCell) -> Void)?) {
        self.identifier = identifier
        self.config = config
    }
}
