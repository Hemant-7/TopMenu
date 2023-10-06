//
//  TopTabCollectionViewCell.swift
//  TopMenu
//
//  Created by Hemant kumar on 04/06/23.
//

import UIKit

class TopTabCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var bottomLineHeightConst: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Helpers
    func configureTitle(title: String?) {
        titleLabel.text = title
    }
    
    func configureColor(isSelected: Bool) {
        if isSelected {
            titleLabel.textColor = UIColor.systemBlue
            bottomLineView.backgroundColor = UIColor.systemBlue
            bottomLineHeightConst.constant = 2
        } else {
            titleLabel.textColor = UIColor.black.withAlphaComponent(0.45)
            bottomLineView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
            bottomLineHeightConst.constant = 1
        }
    }

}
