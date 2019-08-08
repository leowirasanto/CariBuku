//
//  Volume.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Volume { 
    var title = ""
    var author = ""
    var rating: Double = 0.0
    var ratingCount: Double = 0.0
    var description = ""
    var images = ImageLinks()
    
    class func decode(data: JSON) -> Volume {
        let result = Volume()
        
        if let t = data["title"].string {
            result.title = t
        }
        
        if let auth = data["publisher"].string {
            result.author = auth
        }
        
        if let r = data["averageRating"].double {
            result.rating = r
        }
        
        if let c = data["ratingsCount"].double {
            result.ratingCount = c
        }
        
        if let desc = data["description"].string {
            result.description = desc
        }
        
        if data["imageLinks"].exists() {
            result.images = ImageLinks.decode(data: data["imageLinks"])
        }
        
        return result
    }
    
}
