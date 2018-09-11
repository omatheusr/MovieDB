//
//  MovieDetailsView.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieDetailsView: UIViewController {
    
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private let headerView: HeaderImageView = HeaderImageView.instantiate()
    private var feedbackGenerator = UISelectionFeedbackGenerator()

    // MARK: - Data
    private var viewModel: (MovieDetailsViewModelProtocol & MovieFormatter)!
    weak var delegate: MovieDetailsViewDelegate?
    
    // MARK: - Initializers
    required convenience init(with viewModel: MovieDetailsViewModelProtocol & MovieFormatter) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: HeaderImageView.height, left: 0, bottom: 0, right: 0)
        headerView.configure(in: view)
    }
    
    // MARK: - Actions
    private func setupView() {
        headerView.delegate = self
        // Navigation controller
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // TableView
        GenreOverviewCell.registerCell(forTableView: tableView)
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        
        tableView.dataSource = self
        tableView.delegate = self
    }



}

extension MovieDetailsView: MovieDetailsViewModelDelegate {
    
    func movieDetailDidUpdate() {
        headerView.lblTitle.text = viewModel.movieTitle
        headerView.lblTitle.alpha = viewModel.movieTitleOpacity
        
        headerView.lblReleaseDate.text = viewModel.movieReleaseDate
        headerView.lblReleaseDate.alpha = viewModel.movieReleaseDateOpacity
        
        
        viewModel.getPosterImage { [weak self] (image, contentMode) in
            self?.headerView.imgPoster?.transition { [weak self] in
                guard let `self` = self else { return }
                self.headerView.imgPoster?.image = image
                self.headerView.imgPoster?.contentMode = contentMode
            }
        }
        
        viewModel.getBackdropImage { [weak self] (image, contentMode) in
            self?.headerView.imgBack?.transition { [weak self] in
                guard let `self` = self else { return }
                self.headerView.imgBack?.image = image
                self.headerView.imgBack?.contentMode = contentMode
            }
        }
    }
    
}

extension MovieDetailsView: HeaderImageViewDelegate {
    func headerViewShouldExecuteCloseAction() {
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
        delegate?.movieDetailsViewShouldClose()
    }
}

extension MovieDetailsView: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.update(for: scrollView.contentOffset.y)
    }
    
}

extension MovieDetailsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenreOverviewCell! = GenreOverviewCell.dequeueCell(forTableView: tableView)
        cell.configure(with: viewModel)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
