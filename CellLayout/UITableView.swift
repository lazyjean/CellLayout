//
//  UITableView.swift
//  CellLayout
//
//  Created by 刘真 on 2018/10/26.
//

import ReactiveSwift
import UIKit

extension Reactive where Base: UITableView {
    public var insertRows: BindingTarget<([IndexPath], UITableView.RowAnimation)> {
        return makeBindingTarget({base, args in
            base.insertRows(at: args.0, with: args.1)
        })
    }
}
