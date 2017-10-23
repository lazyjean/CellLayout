//
//  Cell1.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import UIKit

class Cell1: UITableViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cover.sd_setImage(with: nil, completed: nil)
        self.name.text = nil
        self.summary.text = nil
    }
}
