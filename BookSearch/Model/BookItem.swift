//
//  BookItem.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import SwiftyJSON

class BookItem {
    var kind = ""
    var id = ""
    var etag = ""
    var selfLink = ""
    var volumeInfo = Volume() 
    
    class func decode(data: JSON) -> BookItem {
        let result = BookItem()
        
        if let kind = data["kind"].string {
            result.kind = kind
        }
        if let id = data["id"].string {
            result.id = id
        }
        if let etag = data["etag"].string {
            result.etag = etag
        }
        
        if let selfLink = data["selfLink"].string {
            result.selfLink = selfLink
        }
        if data["volumeInfo"].exists() {
            result.volumeInfo = Volume.decode(data: data["volumeInfo"])
        }
        
        return result
    }

}
