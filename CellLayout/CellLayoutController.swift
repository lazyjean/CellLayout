//
//  CellLayoutController.swift
//  CellLayout
//
//  Created by liuzhen on 2017/10/23.
//

import UIKit
import UITableView_FDTemplateLayoutCell

class CellLayoutController: UITableViewController {

    var viewModel = CelllayoutViewModel()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.storage.rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.viewModel.storage.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        if let config = row.config {
            config(cell)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.viewModel.storage.rows[indexPath.row]
        return tableView.fd_heightForCell(withIdentifier: row.identifier, cacheBy: indexPath) { (a) in
            if let config = row.config {
                config(a as! UITableViewCell)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
