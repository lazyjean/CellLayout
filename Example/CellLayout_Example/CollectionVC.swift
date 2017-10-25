//
//  Collection.swift
//  NewLayout
//
//  Created by liuzhen on 2017/10/23.
//  Copyright © 2017年 Kingsunsoft Inc. All rights reserved.
//

import UIKit
import ReactiveSwift

private let reuseIdentifier = "Cell"

extension Reactive where Base: CollectionVC {
    var data: BindingTarget<[Int]?> {
        return makeBindingTarget({ (base, value) in
            base.data = value
            base.collectionView?.reloadData()
        })
    }
}

class CollectionVC: UICollectionViewController {

    var data: [Int]?
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.title.text = "\(data![indexPath.row])"
        return cell
    }
}
