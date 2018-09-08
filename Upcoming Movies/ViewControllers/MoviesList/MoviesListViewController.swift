//
//  MoviesListViewController.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var moviesList: MoviesList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Upcoming Movies"
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MovieDb.requestUpcomingMovies(forPage: 1, andLanguage: "pt-BR", success: { [weak self] (moviesList) in
            self?.moviesList = moviesList
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }, failure: { (error) in
            print(error.message)
        })
    }

}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesList?.movies.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellTitle")
        
        cell.textLabel?.text = self.moviesList?.movies[indexPath.row].title ?? "-"
        
        return cell
    }
}
