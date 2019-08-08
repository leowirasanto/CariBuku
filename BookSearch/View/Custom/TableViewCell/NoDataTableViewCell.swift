//
//  NoDataTableViewCell.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/8/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit
import Lottie

class NoDataTableViewCell: UITableViewCell {
    static let identifier = "NoDataTableViewCell"
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var animPlaceHolder: UIView!
    var animationView = AnimationView()
    private var animationName = "anim_empty_box"
    var descString = "No Recent Search"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationView.animation = Animation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = true
        animationView.loopMode = LottieLoopMode.loop
        //        animationView.animationSpeed =
        animPlaceHolder.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.leftAnchor.constraint(equalTo: animPlaceHolder.leftAnchor).isActive = true
        animationView.rightAnchor.constraint(equalTo: animPlaceHolder.rightAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: animPlaceHolder.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: animPlaceHolder.bottomAnchor).isActive = true
        animationView.play()
        descLabel.text = descString
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
