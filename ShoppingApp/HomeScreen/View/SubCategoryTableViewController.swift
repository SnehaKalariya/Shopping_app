//
//  SubCategoryTableViewController.swift
//  ShoppingApp
//
//  Created by Greek1 on 2/4/20.
//  Copyright © 2020 Sneha Jarsania. All rights reserved.
//

import UIKit

class SubCategoryTableViewController: UITableViewController {
    var subCategory : Category!
    var headerName  = ""
    private var sharedClass = SharedClass.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
    }
    func setupNavigation() {
           
           self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
           self.title = headerName
           
           let image = UIImage(named: "back_white")
           
           let btnLeft = UIButton.init(type: .custom)
           btnLeft.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
           
           btnLeft.backgroundColor = UIColor.clear
           btnLeft.titleLabel?.text = ""
           btnLeft.titleLabel?.textColor = UIColor.clear
           btnLeft.imageView?.contentMode = .scaleAspectFit
           btnLeft.contentMode = .scaleAspectFit
           btnLeft.setImage(image, for: .normal)
           btnLeft.setImage(image, for: .selected)
           btnLeft.setImage(image, for: .highlighted)
           btnLeft.setImage(image, for: .disabled)
           btnLeft.addTarget(self, action: #selector(backClick), for: .touchUpInside)
           
           let leftbarBtn = UIBarButtonItem.init(customView: btnLeft)
           self.navigationItem.leftBarButtonItems = [leftbarBtn]
           
       }
       @objc func backClick(){
           self.navigationController?.popViewController(animated: true)
       }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subCategory.childCategories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        let catObject = getLevel2Category(cID: subCategory.childCategories[indexPath.row])
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = catObject?.name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let catObject = getLevel2Category(cID: subCategory.childCategories[indexPath.row])
        
        if let subCat = catObject{
            let vc = self.storyboard?.instantiateViewController(identifier: "ProductListViewController") as! ProductListViewController
            vc.productType = subCat
            vc.headerName = subCat.name
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    //MARK: - Get Level2 Category
    private func getLevel2Category(cID:Int) -> Category? {
        if let allCategories = self.sharedClass.getCategories{
            for cat in allCategories{
                if cat.id == cID{
                    return cat
                }
            }
        }
        return nil
    }
    
}
