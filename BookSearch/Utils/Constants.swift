//
//  Constants.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import UIKit

public class Constants {
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let BASE_URL = "https://www.googleapis.com/books/v1"
    static let IMAGE_BASE_URL = "https://books.google.com/books/"
    
    //endpoints
    static let URL_SEARCH_BOOK = "/volumes"

}
