//
//  MoviesListViewController.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol MoviesListViewControllerDelegate: class {
    func moviesListViewControllerDidSelectCell(atIndexPath indexPath: IndexPath)
}

final class MoviesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MoviesListViewModel!
    weak var delegate: MoviesListViewControllerDelegate?
    
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    // MARK: - Initializers
    required convenience init(withViewModel viewModel: MoviesListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

    // MARK: - Setup
    private func setupView() {
        title = "Upcoming Movies"
        
        extendedLayoutIncludesOpaqueBars = true
        
        MovieGlanceTableViewCell.registerCell(forTableView: tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        let searchController = UISearchController(searchResultsController: UIViewController())
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchBar.placeholder = "Search Movies"
//        definesPresentationContext = true
//
//        navigationItem.searchController = searchController
    }
    
    private func setupViewModel() {
        viewModel.didUpdate = { [weak self] in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.didFail = { error in
            self.presentError(withTitle: "Ops...", andMessage: error.localizedDescription)
        }
        
        viewModel.loadIfNeeded(forIndex: 0, reset: true)
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
        let cell: MovieGlanceTableViewCell! = MovieGlanceTableViewCell.dequeueCell(forTableView: tableView)
        cell.viewModel = viewModel.getMovieGlanceViewModel(forIndexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 206
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        feedbackGenerator.prepare()
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.moviesListViewControllerDidSelectCell(atIndexPath: indexPath)
        feedbackGenerator.selectionChanged()
    }
    
}

//extension MoviesListViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        print(searchController.searchBar.text)
//    }
//
//}
