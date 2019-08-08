//
//  Enum.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(NSError)
}
