//
//  DashboardTitleHeaderView.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit

class DashboardTitleHeaderView: UITableViewHeaderFooterView {
    static let identifier = "DashboardTitleHeaderView"
    @IBOutlet weak var titleLbl: UILabel!
    
    var titleString = "" {
        didSet {
            titleLbl.text = titleString
        }
    } 
}
