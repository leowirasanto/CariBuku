//
//  PopularCollectionViewCell.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardv: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgBg: UIImageView!
    
    var pop = PopularBook() {
        didSet {
            titleLbl.text = pop.name
            cardv.backgroundColor = pop.colorAccent
            imgBg.image = pop.imageBg
        }
    }
    
    
    static let identifier = "PopularCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        cardv.rounded(cornerRadius: 8)
        // Initialization code
    }

}
