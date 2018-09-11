//
//  MoviesListView.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MoviesListView: UIViewController {
    
    private var viewModel: MoviesListViewModelProtocol!
    weak var delegate: MoviesListViewDelegate?

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var feedbackGenerator = UISelectionFeedbackGenerator()
    
    // MARK: - Initializers
    required convenience init(with viewModel: MoviesListViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.load()
    }
    
    // MARK: - Setup
    private func setupView() {
        title = "Upcoming Movies"
        
        extendedLayoutIncludesOpaqueBars = true
        
        MovieCardCell.registerCell(forTableView: tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MoviesListView: MoviesListViewModelDelegate {
    
    func movieListViewModelDidReceiveError(_ error: Error) {
        presentError(withTitle: "Ops...", andMessage: error.localizedDescription)
    }
    
    func movieListViewModelDidUpdateData() {
        tableView.reloadData()
    }
    
}

extension MoviesListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        feedbackGenerator.prepare()
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        feedbackGenerator.selectionChanged()
        delegate?.moviesListViewDidSelectCell(at: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(at: indexPath)
    }
    
}

extension MoviesListView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCardCell! = MovieCardCell.dequeueCell(forTableView: tableView)
        cell.viewModel = viewModel.getMovieCardViewModel(for: indexPath)
        return cell
    }
}
