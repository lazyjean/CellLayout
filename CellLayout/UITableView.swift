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
    
    public var scrollsToBottom: BindingTarget<(UITableView.ScrollPosition)> {
        return makeBindingTarget({ (base, args) in
            let sec = base.numberOfSections - 1
            let row = base.numberOfRows(inSection: sec) - 1
            DispatchQueue.main.async {
                base.scrollToRow(at: IndexPath(row: row, section: sec), at: args, animated: true)
            }
        })
    }
}
