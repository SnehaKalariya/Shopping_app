//
//  ProductListVM.swift
//  ShoppingApp
//
//  Created by Jigar Jarsania on 2/5/20.
//  Copyright © 2020 Sneha Jarsania. All rights reserved.
//

import Foundation

class ProductListVM: NSObject {
    
    var productModel = ProductDataModel()
    //MARK: - Ranking Array Get
    func getRankingArray(){
        if let rankArr = self.productModel.sharedClass.getallRankings as? [Ranking]{
            self.productModel.rankingCategoryArray = rankArr.map { (obj) -> String in
                obj.ranking
            }
        }
    }
}
