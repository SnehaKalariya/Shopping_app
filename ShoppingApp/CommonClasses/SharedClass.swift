//
//  SharedClass.swift
//  ShoppingApp
//
//  Created by Greek1 on 2/4/20.
//  Copyright © 2020 Sneha Jarsania. All rights reserved.
//

import Foundation

class SharedClass {
    static let sharedInstance = SharedClass()
    var getCategories : [Category]?
    var getallRankings : [Ranking]?
    
    private init(){
    }
}
