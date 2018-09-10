//
//  MovieDetailsViewController.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol MovieDetailsViewControllerDelegate: class {
    func movieDetailsViewControllerDidTapCloseButton()
}

final class MovieDetailsViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MovieDetailsViewModel!
    weak var delegate: MovieDetailsViewControllerDelegate?
    
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    private let headerView: ImageHeaderView = ImageHeaderView.instantiate()
    private let headerHeight: CGFloat = 270

    required convenience init(withViewModel viewModel: MovieDetailsViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.frame = CGRect(x: 0, y: -view.safeAreaInsets.top, width: view.bounds.width, height: headerHeight)
    }
    
    // MARK: - Actions
    func setupView() {
        // Navigation controller
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // TableView
        LabelTableViewCell.registerCell(forTableView: tableView)
        GenresListTableViewCell.registerCell(forTableView: tableView)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        // Header
        view.addSubview(headerView)
        headerView.didClose = { [weak self] in
            guard let `self` = self else { return }
            self.feedbackGenerator.prepare()
            self.feedbackGenerator.selectionChanged()
            
            self.delegate?.movieDetailsViewControllerDidTapCloseButton()
        }
    }
    func setupViewModel() {
        viewModel.didUpdate = { [weak self] in
            guard let `self` = self else { return }
            
            self.viewModel.movieBackdropImage(downloadCompletion: { [weak self] (image) in
                guard let `self` = self else { return }
                self.headerView.imgPoster.transition {
                    self.headerView.imgBack.image = image
                }
            })
            self.viewModel.moviePosterImage(downloadCompletion: { [weak self] (image) in
                guard let `self` = self else { return }
                self.headerView.imgPoster.transition {
                    self.headerView.imgPoster.image = image
                    self.headerView.imgPoster.contentMode = self.viewModel.moviePosterContentMode
                }
            })
            
            self.headerView.lblTitle.text = self.viewModel.movieTitle
            self.headerView.lblReleaseDate.text = self.viewModel.movieReleaseDate
            
            self.tableView.reloadData()
        }
        viewModel.didFail = { error in
            print(error.localizedDescription)
        }
        
        viewModel.update()
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: LabelTableViewCell! = LabelTableViewCell.dequeueCell(forTableView: tableView)
            cell.lblContent.text = viewModel.movieOverview
            return cell
        case 1:
            let cell: GenresListTableViewCell! = GenresListTableViewCell.dequeueCell(forTableView: tableView)
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = headerHeight - (scrollView.contentOffset.y + headerHeight)
        let height = max(y, view.safeAreaInsets.top + 160)
        headerView.frame = CGRect(x: 0, y: -view.safeAreaInsets.top, width: view.bounds.width, height: height)
    }
    
}
