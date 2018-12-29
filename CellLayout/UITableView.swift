//
//  UITableView.swift
//  CellLayout
//
//  Created by 刘真 on 2018/10/26.
//

import ReactiveSwift
import UIKit

extension Reactive where Base: UITableView {
    
    public var insertRows: BindingTarget<([IndexPath], UITableView.RowAnimation)?> {
        return makeBindingTarget({ (base, value) in
            if let (indexes, animation) = value {
                base.insertRows(at: indexes, with: animation)
            }
        })
    }
        
    public var scrollToRow: BindingTarget<(IndexPath, UITableView.ScrollPosition, Bool)?> {
        return makeBindingTarget({ (base, value) in
            if let (index, position, animated) = value {
                base.scrollToRow(at: index, at: position, animated: animated)
            }
        })
    }
}
