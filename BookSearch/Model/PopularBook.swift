//
//  PopularBook.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import UIKit

struct PopularBook {
    var id = 0
    var name = ""
    var colorAccent = UIColor() {
        didSet {
            switch colorAccent {
            case UIColor.purple:
                imageBg = UIImage(named: "img_gradient_purple")!
            case UIColor.blue:
                imageBg = UIImage(named: "img_gradient_blue")!
            default:
                imageBg = UIImage(named: "img_gradent_pink")!
            }
        }
    }
    var imageBg = UIImage()
}

