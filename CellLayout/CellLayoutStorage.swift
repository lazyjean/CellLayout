//
//  LayoutStorage.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import Foundation
import ReactiveSwift

public final class CellLayoutStorage {

    public var rows = [CellLayoutRow]()

    public func createRow(identifier: String, isOverlay: Bool = false, config:((UITableViewCell, CGFloat) -> Void)? = nil, select:(() -> Void)? = nil) {
        let row = CellLayoutRow(identifier: identifier, isOverlay: isOverlay, config:config, select:select)
        rows.append(row)
    }

    public func invalidRows() {
        rows.removeAll()
    }

    public init() {

    }
}
