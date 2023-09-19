//
//  SearchTableViewCell.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 14.09.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
