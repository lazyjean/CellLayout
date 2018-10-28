//
//  CellTableView.swift
//  CellLayout
//
//  Created by 刘真 on 2018/10/26.
//

import ReactiveSwift
import UIKit

extension Reactive where Base: UITableView {
    public var insertRows: BindingTarget<([CellLayoutRow], UITableViewRowAnimation)> {
        return makeBindingTarget({ base, input in base.insertRows(at: input.0, with: input.1) })
    }
}
