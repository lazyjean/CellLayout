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
    let (insert, insertObserver) = Signal<([IndexPath], UITableView.RowAnimation), NoError>.pipe()
    let scrollsToBottom = MutableProperty<UITableView.ScrollPosition>(.bottom)

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
        self.insertObserver.send(value: (indexed, with))
    }
    
    open func scrollToBottom() {
        
    }
}
