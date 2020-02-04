//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by Jigar Jarsania on 2/2/20.
//  Copyright © 2020 Sneha Jarsania. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UpdateHomeViewUIDelegate {
    @IBOutlet weak var tableView: UITableView!
    var homeViewModelRef : HomeViewModel!
    fileprivate var allCategories = [Category]()
    fileprivate var l1Categories = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init(frame: .zero)
        self.navigationController?.navigationBar.topItem?.title = "Shopping App"
        self.homeViewModelRef = HomeViewModel()
        self.homeViewModelRef.delegate = self
        self.homeViewModelRef.apiCallForShoppingData()
    }
    //MARK: - Update HomeView UI Delegate
    func showLevel1Categories(allCategories: [Category], l1Categories: [Category]) {
        self.allCategories = allCategories
        self.l1Categories = l1Categories
        self.tableView.reloadData()
      }
}

extension HomeViewController : UITableViewDataSource,UITableViewDelegate{
    
    //MARK: - UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.l1Categories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.l1Categories[section].childCategories.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
           let headerMainView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 50.0))
           headerMainView.backgroundColor = UIColor.clear
           
           let subView = UIView.init(frame: CGRect(x: 0, y: 0, width: headerMainView.bounds.width, height: 40.0))
           subView.backgroundColor = UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
           headerMainView.addSubview(subView)
           
           let headerTitle = UILabel.init(frame: CGRect(x: 10.0, y: 0.0, width: subView.bounds.width-65.0, height: 40.0))
            headerTitle.text = self.l1Categories[section].name
           headerTitle.textColor = UIColor.white
           headerTitle.backgroundColor = UIColor.clear
           subView.addSubview(headerTitle)
        
           return headerMainView
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50.0
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableCell", for: indexPath) as! HomeViewTableCell
        let category = self.l1Categories[indexPath.section]
        let subCategory = getLevel2Category(cID: category.childCategories[indexPath.row])
        cell.lblTitle.text = subCategory?.name ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = self.l1Categories[indexPath.section]
        let subCategory = getLevel2Category(cID: category.childCategories[indexPath.row])

        if let subCat = subCategory{
            if subCat.childCategories.count > 0{
                let vc = self.storyboard?.instantiateViewController(identifier: "SubCategoryTableViewController") as! SubCategoryTableViewController
                vc.subCategory = subCat
                vc.headerName = subCat.name
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
       
    }
    //MARK: - Get Level2 Category
    private func getLevel2Category(cID:Int) -> Category? {
        for cat in self.allCategories{
            if cat.id == cID{
                return cat
            }
        }
        return nil
    }
}

class HomeViewTableCell: UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    
}
