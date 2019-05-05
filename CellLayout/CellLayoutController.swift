//
//  CellLayoutController.swift
//  CellLayout
//
//  Created by liuzhen on 2017/10/23.
//

import UIKit
import UITableView_FDTemplateLayoutCell
import ReactiveCocoa
import ReactiveSwift
import SVPullToRefresh

open class CellLayoutController<VM:CellLayoutViewModel>: UITableViewController {

    open var viewModel = VM()

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.build()
        tableView.reactive.reloadData <~ self.viewModel.reload
        tableView.reactive.insertRows <~ self.viewModel.insert
        tableView.reactive.scrollToRow <~ self.viewModel.scroll
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.storage.rows.count
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.viewModel.storage.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        if let config = row.config {
            config(cell, tableView.frame.width)
        }
        return cell
    }

    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.viewModel.storage.rows[indexPath.row]
        if row.isOverlay {
            return tableView.frame.height
        }
        
        return tableView.fd_heightForCell(withIdentifier: row.identifier, cacheBy: indexPath) { (a) in
            if let config = row.config {
                config(a as! UITableViewCell, tableView.frame.width)
            }
        }
    }

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.viewModel.storage.rows[indexPath.row]
        row.select?()
    }

    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
