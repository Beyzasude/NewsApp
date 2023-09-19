//
//  CategoriesCollectionViewCell.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 18.09.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImageView.layer.cornerRadius = 10
    }
}
