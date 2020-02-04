//
//  HomeViewModel.swift
//  ShoppingApp
//
//  Created by Jigar Jarsania on 2/2/20.
//  Copyright © 2020 Sneha Jarsania. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol UpdateHomeViewUIDelegate : AnyObject {
    func showLevel1Categories(allCategories:[Category],l1Categories:[Category])
    
}
class HomeViewModel: NSObject {
    var allCategories = [Category]()
    var allRankings = [Ranking]()
    var level1Categories = [Category]()
    weak var delegate : UpdateHomeViewUIDelegate?
    //MARK: -Api Call For MostRecentData
    func apiCallForShoppingData()  {
        let urlStr = "https://stark-spire-93433.herokuapp.com/json"
        SVProgressHUD.show()
         DispatchQueue.global(qos: .background).async {
            WebServiceHandler.getApiCall_CodableRES(url: urlStr, completion: { (result) in
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    guard let jsonData = result else{
                        return
                    }

                    let jsonDecoder = JSONDecoder()
                    do {
                         let responseObj = try jsonDecoder.decode(ShoppingAPIResponseModel.self, from: jsonData)
                        self.allCategories = responseObj.categories
                        self.allRankings = responseObj.rankings
                        let sharedClass = SharedClass.sharedInstance
                        sharedClass.getCategories = self.allCategories
                        sharedClass.getallRankings = self.allRankings
                        self.findTopCategories()
                        self.delegate?.showLevel1Categories(allCategories: self.allCategories, l1Categories: self.level1Categories)
                    }catch{
                        print("not able to decode \(error.localizedDescription)")

                    }

                }
            }) { (error) in
                DispatchQueue.main.async {

                    print("error --- \(error.localizedDescription)")
                }
            }
        }
    }
    func findTopCategories() {
       let categoriesWithChild = self.allCategories.filter { (catObj) -> Bool in
            return !catObj.childCategories.isEmpty
        }
        print("cate \(categoriesWithChild[0])")
        
        for catObj in categoriesWithChild {
            var addNewCategory = false
            for catObjInner in categoriesWithChild{
                if catObjInner.childCategories.contains(catObj.id){
                    addNewCategory = false
                    break
                }else{
                     addNewCategory = true
                }
            }
            if addNewCategory{
                level1Categories.append(catObj)
            }

        }
    }
}
