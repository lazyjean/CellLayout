//
//  ViewModel.swift
//  CellLayout_Example
//
//  Created by liuzhen on 2017/10/25.
//  Copyright © 2017年 LiuZhen. All rights reserved.
//

import Foundation
import CellLayout
import ReactiveSwift

class ViewModel: CellLayoutViewModel {

    var containerData = MutableProperty<(UIView, [Int])?>(nil)

    var pull: Action<(), (), Swift.Error> {
        return Action(execute: { () -> SignalProducer<(), Swift.Error> in
            return SignalProducer { observer,_ in
                print("pulling...")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10, execute: {
                    print("pulling finished")
                    observer.sendCompleted()
                })
            }
        })
    }

    
    override func buildLayout() {

        self.storage.createRow(identifier: "book", config: { (cell, _) in
            let c = cell as! Cell1
            c.name.text = "时间简史"
            c.cover.sd_setImage(with: URL(string: "https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=5dbf2f9377cf3bc7fc0dc5beb069d1c4/0bd162d9f2d3572c2b694f428d13632763d0c3a1.jpg"), completed: nil)
            c.summary.text = "在这部书中，霍金带领读者遨游外层空间奇异领域，对遥远星系、黑洞、夸克、“带味”粒子和“自旋”粒子、反物质、“时间箭头”等进行了深入浅出的介绍，并对宇宙是什么样的、空间和时间以及相对论等古老问题做了阐述，使读者初步了解狭义相对论以及时间、宇宙的起源等宇宙学的奥妙"
        })

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "container", config: {
            let cell = $0 as! Cell2
            let _ = $1
            self.containerData.value = (cell.container, [1,3,7,2,3,7,5,8,4,9,8])
        })

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "book")

        self.storage.createRow(identifier: "book", config: { (cell, _) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })

        self.storage.createRow(identifier: "book", config: { (cell, _) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })

        self.storage.createRow(identifier: "book", config: { (cell, _) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })

        self.storage.createRow(identifier: "book", config: { (cell, _) in
            let c = cell as! Cell1
            c.cover.sd_setImage(with: URL(string: "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c559daa417950a7b613846966bb809bc/f31fbe096b63f624e231b8918d44ebf81a4ca330.jpg"), completed: nil)
        })
    }

    func loadData() {
        self.reloadData()
    }
}
