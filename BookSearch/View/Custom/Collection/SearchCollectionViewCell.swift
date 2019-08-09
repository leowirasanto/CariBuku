//
//  SearchCollectionViewCell.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
    @IBOutlet weak var bookImg: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bookTitle: UILabel!
    
    //height : 257
    var bookItem = BookItem() {
        didSet {
            if let stringUrl = bookItem.generatedImageUrl as? String, bookItem.id != "" {
                if let url = URL(string: stringUrl) {
                    bookImg.af_setImage(withURL: url)
                }
            }
            bookTitle.text = bookItem.volumeInfo.title
            authorLbl.text = bookItem.volumeInfo.author
            ratingView.rating = bookItem.volumeInfo.rating.rounded()
            ratingView.text = "(\(Int(bookItem.volumeInfo.ratingCount)))"
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.rounded(cornerRadius: 8)
        // Initialization code
    }

}
