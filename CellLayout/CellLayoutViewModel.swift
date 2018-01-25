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

    let (signal, observer) = Signal<(), NoError>.pipe()

    public func reloadData() {
        self.build()
        self.observer.send(value: ())
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
}
