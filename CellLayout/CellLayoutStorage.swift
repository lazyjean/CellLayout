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

    let (signal, observer) = Signal<(), NoError>.pipe()

    public var rows = [CellLayoutRow]()

    public func reloadData() {
        self.observer.send(value: ())
    }

    public func createRow(identifier: String, config:((UITableViewCell) -> Void)?) {
        let row = CellLayoutRow(identifier: identifier, config)
        rows.append(row)
    }

    public func invalidRows() {
        rows.removeAll()
    }

    public init() {

    }
}
