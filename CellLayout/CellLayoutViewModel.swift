//
//  CellLayoutViewModel.swift
//  CellLayout
//
//  Created by liuzhen on 2017/10/23.
//

import Foundation
import ReactiveSwift
import Result

open class CellLayoutViewModel: NSObject {

    let (reload, reloadObserver) = Signal<(), NoError>.pipe()
    public let insert = MutableProperty<([IndexPath], UITableView.RowAnimation)?>(nil)
    public let scroll = MutableProperty<(IndexPath, UITableView.ScrollPosition, Bool)?>(nil)

    public func reloadData() {
        self.build()
        self.reloadObserver.send(value: ())
    }
    
    public var storage = CellLayoutStorage()

    func build() {
        self.storage.invalidRows()
        self.buildLayout()
    }

    open func buildLayout() {
        
    }

    required public override init() {
        
    }
    
    open func insertRows(at: [CellLayoutRow], with: UITableView.RowAnimation) {
        var indexed:[IndexPath] = []
        for i in 0..<at.count {
            switch with {
            case .top:
                indexed.insert((IndexPath(row: i, section: 0)), at: i)
                storage.rows.insert(at[i], at: i)
            default:
                indexed.append(IndexPath(row: storage.rows.count, section: 0))
                storage.rows.append(at[i])
            }
        }
        self.insert.value = (indexed, with)
    }
    
    public func scrollsToBottom(animated: Bool = true) {
        if self.storage.rows.count > 0 {
            self.scroll.value = (IndexPath(row: self.storage.rows.count - 1, section: 0), .bottom, animated)
        }
    }
    
    public func scrollsToTop(animated: Bool = true) {
        if self.storage.rows.count > 0 {
            self.scroll.value = (IndexPath(row: 0, section: 0), .top, animated)
        }
    }
}
