//
//  RecentItemTableViewCell.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/7/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit
import Alamofire
import Hero

class RecentItemTableViewCell: UITableViewCell {
    static let identifier = "RecentItemTableViewCell"
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var simpleDesc: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    var bookItem = BookItem() {
        didSet {
            if let sUrl = bookItem.generatedImageUrl as? String, bookItem.id != "" {
                if let url = URL(string: sUrl) {
                    bookImage.af_setImage(withURL: url)
                    bookImage.hero.id = bookItem.generatedImageUrl
                }
            }
            
            titleLabel.text = bookItem.volumeInfo.title
            simpleDesc.text = bookItem.volumeInfo.description
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImage.rounded(cornerRadius: bookImage.frame.width / 2)
        cardView.rounded(cornerRadius: 8)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        // Configure the view for the selected state
    }
    
}
