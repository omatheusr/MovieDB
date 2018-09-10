//
//  Dequeuable.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/9/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol DequeuableTableViewCell {
    static func registerCell(forTableView tableView: UITableView)
    static func dequeueCell(forTableView tableView: UITableView) -> Self!
}
extension DequeuableTableViewCell where Self: UITableViewCell {
    static func registerCell(forTableView tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: self))
    }
    static func dequeueCell(forTableView tableView: UITableView) -> Self! {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? Self
    }
}
extension UITableViewCell: DequeuableTableViewCell { }


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
