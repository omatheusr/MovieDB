//
//  LabelTableViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/9/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
