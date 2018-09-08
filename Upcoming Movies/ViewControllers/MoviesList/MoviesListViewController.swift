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
    
    private var viewModel: MoviesListViewModel!
    
    required convenience init(withViewModel viewModel: MoviesListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Upcoming Movies"
        
        tableView.tableFooterView = UIView()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.didUpdate = { [weak self] in
            guard let `self` = self else { return }
            
            if !self.viewModel.isUpdating {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        
        viewModel.didFail = { error in
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.update(nextPage: true)
    }
    
    @IBAction func didPullToRefresh(refreshControl: UIRefreshControl) {
        viewModel.update(reset: true)
    }

}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.moviesCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewModel.moviesCount - 1)  == indexPath.row && !viewModel.shouldShowLoadingCell {
            let colorCell = UITableViewCell()
            colorCell.backgroundColor = UIColor.red
            return colorCell
        }
        
        return MovieGlanceTableViewCell.dequeueCell(forTableView: tableView, usingViewModel: viewModel.getMovieGlanceViewModel(forIndexPath: indexPath))
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 206
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (viewModel.moviesCount - 1) == indexPath.row {
            viewModel.update(nextPage: true)
        }
    }
    
}
