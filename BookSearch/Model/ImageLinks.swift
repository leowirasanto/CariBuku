//
//  ImageLinks.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageLinks {
    var smallThumb = ""
    var thumb = ""
    
    class func decode(data: JSON) -> ImageLinks {
        let result = ImageLinks()
        
        if let small = data["smallThumbnail"].string {
            result.smallThumb = small
        }
        
        if let thumb = data["thumbnail"].string {
            result.thumb = thumb
        }
        
        return result
    }
}
