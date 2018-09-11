//
//  UICollectionViewCell+Dequeuable.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol DequeuableCollectionViewCell {
    static func registerCell(forCollectionView collectionView: UICollectionView)
    static func dequeueCell(forCollectionView collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> Self!
}
extension DequeuableCollectionViewCell where Self: UICollectionViewCell {
    static func registerCell(forCollectionView collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: self))
    }
    static func dequeueCell(forCollectionView collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> Self! {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as? Self
    }
}
extension UICollectionViewCell: DequeuableCollectionViewCell { }
