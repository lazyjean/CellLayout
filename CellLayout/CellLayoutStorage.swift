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

final class CellLayoutStorage {

    let (signal, observer) = Signal<(), NoError>.pipe()

    var rows = [CellLayoutRow]()

    func reloadData() {
        self.observer.send(value: ())
    }

    func createRow(identifier: String, config:((UITableViewCell) -> Void)?) {
        let row = CellLayoutRow(identifier: identifier, config)
        rows.append(row)
    }

    func invalidRows() {
        rows.removeAll()
    }
}
