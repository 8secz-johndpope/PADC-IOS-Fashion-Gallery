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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CellRegisterUtil.cellRegister(nibName: "ShopListsTableViewCell", tableView: shopTableView)
    }

}

extension ShopViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListsTableViewCell", for: indexPath) as! ShopListsTableViewCell
        return cell
    }
    
    
}

extension ShopViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
