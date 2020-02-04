//
//  CustomPopOverMenuVC.swift
//  BajajFinserv
//
//  Created by PRAVIN TEPAN on 01/10/19.
//  Copyright © 2019 Sushant Patil. All rights reserved.
//

import UIKit

@objc protocol CustomPopOverMenuDelegate {
    func customPopOverView(_ tag: Int, didSelectMenuAt index: Int)
}

@objc class CustomPopOverMenuVC: UITableViewController {
    
    var customPopOverDelegate: CustomPopOverMenuDelegate?
    @objc var sourceTag = -1
    
    @objc var menuDataSource = Array<String>()
    
    var cellHeight = 40

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 280, height: self.tableView.contentSize.height)
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.menuDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopOverMenuCell", for: indexPath)

        cell.textLabel?.text = self.menuDataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true) { [weak self] in
            self?.customPopOverDelegate?.customPopOverView(self?.sourceTag ?? -1, didSelectMenuAt: indexPath.row)
        }
    }

}
