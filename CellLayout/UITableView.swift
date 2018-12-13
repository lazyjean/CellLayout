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
    
    public var scrollTable: BindingTarget<(UITableView.ScrollPosition?)> {
        return makeBindingTarget({ (base, args) in
            
            guard let scrollPosition = args else {
                return
            }
            
            DispatchQueue.main.async {
                switch scrollPosition {
                case .top:
                    base.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                case .bottom:
                    let sec = base.numberOfSections - 1
                    let row = base.numberOfRows(inSection: sec) - 1
                    if row >= 0, sec >= 0 {
                        base.scrollToRow(at: IndexPath(row: row, section: sec), at: scrollPosition, animated: true)
                    }
                default:
                    break
                }
            }
        })
    }
}
