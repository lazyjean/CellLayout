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

class Table: UITableViewController {

    var storage: CellLayoutStorage?

    var collection: CollectionVC!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.storage = CellLayoutStorage()

        //创建section
        self.storage?.createRow(identifier: "book", config: { (cell) in
            let c = cell as! Cell1
            c.name.text = "时间简史"
            c.cover.sd_setImage(with: URL(string: "https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=5dbf2f9377cf3bc7fc0dc5beb069d1c4/0bd162d9f2d3572c2b694f428d13632763d0c3a1.jpg"), completed: nil)
            c.summary.text = "在这部书中，霍金带领读者遨游外层空间奇异领域，对遥远星系、黑洞、夸克、“带味”粒子和“自旋”粒子、反物质、“时间箭头”等进行了深入浅出的介绍，并对宇宙是什么样的、空间和时间以及相对论等古老问题做了阐述，使读者初步了解狭义相对论以及时间、宇宙的起源等宇宙学的奥妙"
        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "container", config: { [weak self](cell) in
            let c = cell as! Cell2

            self?.collection.removeFromParentViewController()
            self?.addChildViewController(self!.collection)
            self?.willMove(toParentViewController: self)
            c.container.addSubview(self!.collection.view)
            self?.didMove(toParentViewController: self)

            self?.collection.view.frame = c.container.bounds
        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "book", config: { (cell) in

        })

        self.storage?.createRow(identifier: "book", config: { (cell) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })

        self.storage?.createRow(identifier: "book", config: { (cell) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })

        self.storage?.createRow(identifier: "book", config: { (cell) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })

        self.storage?.createRow(identifier: "book", config: { (cell) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })
        
        collection = self.storyboard!.instantiateViewController(withIdentifier: "collection") as! CollectionVC
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storage?.rows.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.storage?.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row!.identifier, for: indexPath)
        if let config = row?.config {
            config(cell)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.storage?.rows[indexPath.row]
        return tableView.fd_heightForCell(withIdentifier: row?.identifier, cacheBy: indexPath) { (a) in
            if let config = row?.config {
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
