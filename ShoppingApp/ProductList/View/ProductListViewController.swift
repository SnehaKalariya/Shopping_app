//
//  ProductListViewController.swift
//  ShoppingApp
//
//  Created by Greek1 on 2/4/20.
//  Copyright © 2020 Sneha Jarsania. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIPopoverPresentationControllerDelegate, CustomPopOverMenuDelegate {
   
    var productType : Category!
    var headerName = ""
    var rightbarBtn : UIBarButtonItem!
    var productListVM = ProductListVM()
    var dataSourceProduct = [CategoryProduct]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSourceProduct = self.productType.products
        self.productListVM.getRankingArray()
        self.setupNavigation()
    }
    //MARK: - SetupNavigation
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
        
        let image1 = UIImage(named: "menu_white")
        
        let btnRight = UIButton.init(type: .custom)
        btnRight.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        
        btnRight.backgroundColor = UIColor.clear
        btnRight.titleLabel?.text = ""
        btnRight.titleLabel?.textColor = UIColor.clear
        btnRight.imageView?.contentMode = .scaleAspectFit
        btnRight.contentMode = .scaleAspectFit
        btnRight.setImage(image1, for: .normal)
        btnRight.setImage(image1, for: .selected)
        btnRight.setImage(image1, for: .highlighted)
        btnRight.setImage(image1, for: .disabled)
        btnRight.addTarget(self, action: #selector(rightMenuView), for: .touchUpInside)
        
        rightbarBtn = UIBarButtonItem.init(customView: btnRight)
        self.navigationItem.rightBarButtonItems = [rightbarBtn]
    }
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func rightMenuView(){
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "CustomPopOverMenuVC") as! CustomPopOverMenuVC
        popoverContent.menuDataSource = self.productListVM.productModel.rankingCategoryArray
        popoverContent.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = popoverContent.popoverPresentationController!
        popover.barButtonItem = rightbarBtn
        popover.delegate = self
        popoverContent.customPopOverDelegate = self
        present(popoverContent, animated: true, completion:nil)
    }
    //MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {

        return UIModalPresentationStyle.none
    }
    func customPopOverView(_ tag: Int, didSelectMenuAt index: Int) {
        let selectedArray = self.productListVM.productModel.sharedClass.getallRankings![index].products
        var filterArray = [CategoryProduct]()
        for obj in selectedArray{
            for innerObj in productType.products{
                if innerObj.id == obj.id{
                    filterArray.append(innerObj)
                    break
                }
            }
        }
        self.dataSourceProduct = filterArray
        self.collectionView.reloadData()
    }
    
    //MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourceProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ProductCell
        cell.lblName.text = dataSourceProduct[indexPath.row].name
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.bounds.width/2)-1, height: (self.collectionView.bounds.width/2)-1)
    }
}

class ProductCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
}
