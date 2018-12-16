//
//  ShopViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/10/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
class ShopViewController: UIViewController {

    @IBOutlet weak var shopTableView: UITableView!
    var shopList : [ShopVO] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        CellRegisterUtil.cellRegister(nibName: "ShopListsTableViewCell", tableView: shopTableView)
        getAllShops()
        
    }
    
    func getAllShops() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        DataModel.shared.getShopLists(success: { (data) in
            UIViewController.removeSpinner(spinner: sv)
            self.shopList.removeAll()
            self.shopList.append(contentsOf: data)
            self.shopTableView.reloadData()
            
        }, failure: {
            UIViewController.removeSpinner(spinner: sv)
        })
    }
    
   
}

extension ShopViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListsTableViewCell", for: indexPath) as! ShopListsTableViewCell
        let shop = self.shopList[indexPath.row]
        cell.shopName.text = shop.shop_name ?? "Unknown"
        cell.shopEmail.text = shop.shop_contact_email ?? "Unknown"
        cell.shopPhone.text = shop.shop_contact_no ?? "Unknown"
        cell.shopAddress.text = shop.shop_contact_address ?? "Unknown"
    
        return cell
    }
    
    
}

extension ShopViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
