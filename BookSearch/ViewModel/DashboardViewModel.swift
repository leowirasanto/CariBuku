//
//  DashboardViewModel.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/7/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import SwiftyJSON

class DashboardViewModel {
    var popularItemList = [PopularBook]()
    var recentBook = [BookItem]()
    
    init() {
        var pop = PopularBook()
        pop.colorAccent = .blue
        pop.id = 1
        pop.name = "Harry Potter"
        popularItemList.append(pop)
        
        pop.colorAccent = .orange
        pop.id = 2
        pop.name = "Star Wars"
        popularItemList.append(pop)
        
        pop.colorAccent = .purple
        pop.id = 3
        pop.name = "Mockingbird"
        popularItemList.append(pop)
        
        pop.colorAccent = .blue
        pop.id = 4
        pop.name = "Animal Farm"
        popularItemList.append(pop)
        
        pop.colorAccent = .orange
        pop.id = 5
        pop.name = "Romeo and Juliet"
        popularItemList.append(pop)
    }
}
