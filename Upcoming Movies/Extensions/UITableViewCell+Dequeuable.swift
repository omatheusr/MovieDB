//
//  UITableViewCell+Dequeuable.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
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
