//
//  Table.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell
import SDWebImage
import CellLayout
import ReactiveSwift
import SVPullToRefresh
import ReactiveCocoa

extension Reactive where Base: Table {
    internal var banner: BindingTarget<(UIView, [Int])?> {
        return makeBindingTarget({base, value in
            if let (v,d) = value {
                base.showIn(in: v)
                base.collection.data = d
            }
        })
    }
}
class Table: CellLayoutController<ViewModel> {

    var collection: CollectionVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        collection = self.storyboard!.instantiateViewController(withIdentifier: "collection") as? CollectionVC
        self.reactive.banner <~ self.viewModel.containerData

        tableView.addInfiniteScrolling {
            print("底部加载...")
        }

        refreshControl?.reactive.refresh = CocoaAction(self.viewModel.pull)

        tableView.addInfiniteScrolling {
            self.viewModel.loadData()
        }
    }

    //显示子控制器
    func showIn(in container: UIView) {
        collection.removeFromParentViewController()
        addChildViewController(collection)
        collection.willMove(toParentViewController: self)
        container.addSubview(collection.view)
        collection.didMove(toParentViewController: self)
        collection.view.frame = container.bounds
    }
    
    @IBAction func add(_ sender: Any) {
        let row = CellLayoutRow(identifier: "book")
//        self.viewModel.insertRows(at: [row], with: .top)
        self.viewModel.insertRows(at: [row], with: .bottom)
    }
}
