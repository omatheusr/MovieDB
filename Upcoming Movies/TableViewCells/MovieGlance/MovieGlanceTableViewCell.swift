//
//  MovieGlanceTableViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieGlanceTableViewCell: UITableViewCell {
    
    static func dequeueCell(forTableView tableView: UITableView, usingViewModel viewModel: MovieGlanceViewModel) -> MovieGlanceTableViewCell {
        
        var cell: MovieGlanceTableViewCell! = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? MovieGlanceTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: self))
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? MovieGlanceTableViewCell
        }
        
        cell?.viewModel = viewModel
        
        return cell
    }
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    
    var viewModel: MovieGlanceViewModel? {
        didSet {
            viewModel?.didUpdate = { [weak self, weak viewModel] in
                guard let `self` = self, let viewModel = viewModel else { return }
                self.lblTitle?.text = viewModel.movieTitle
                self.lblReleaseDate.text = viewModel.movieReleaseDate
                self.imgPoster.image = viewModel.posterImage
            }
            viewModel?.update()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
    }
    
}
