//
//  LayoutStorage.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public final class CellLayoutStorage {

    public var rows = [CellLayoutRow]()

    public func createRow(identifier: String, config:((UITableViewCell) -> Void)? = nil, select:(() -> Void)? = nil) {
        let row = CellLayoutRow(identifier: identifier, config:config, select:select)
        rows.append(row)
    }

    public func invalidRows() {
        rows.removeAll()
    }

    public init() {

    }
}
