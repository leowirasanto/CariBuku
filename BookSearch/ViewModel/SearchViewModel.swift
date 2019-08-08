//
//  SearchViewModel.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchViewModel {
    var bookList = [BookItem]()
    
    func searchBook(keyword: String, callback: @escaping(APIResult<Void>) -> Void) {
        var params = [String: Any]()
        params["q"] = keyword
        
        APIHelper.instance.getApi(params: params, endPoint: Constants.URL_SEARCH_BOOK) { (result) in
            switch result {
            case .success(let json) :
                if let items = json["items"].array {
                    self.bookList.removeAll()
                    for item in items {
                        self.bookList.append(BookItem.decode(data: item))
                    }
                    
                    let sorted = self.bookList.sorted(by: { (a, b) -> Bool in
                        (a.volumeInfo.ratingCount, a.volumeInfo.rating) > (b.volumeInfo.ratingCount, b.volumeInfo.rating)
                    })
                    self.bookList.removeAll()
                    self.bookList = sorted
                }
                callback(.success(()))
            case .failure(let error) :
                callback(.failure(error))
            }
        }
    }
}
