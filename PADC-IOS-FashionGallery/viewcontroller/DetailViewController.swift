//
//  DetailViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
import Cosmos

class DetailViewController: UIViewController {

    @IBOutlet weak var item_Image: UIImageView!
    @IBOutlet weak var item_price: UILabel!
    
    @IBOutlet weak var item_Description: UILabel!
    
    @IBOutlet weak var item_Discount: UILabel!
    
    @IBOutlet weak var item_Rating: CosmosView!
    
    @IBOutlet weak var item_name: UILabel!
    
    @IBOutlet weak var item_brand: UILabel!
    
    @IBOutlet weak var category_name: UILabel!
    
    @IBOutlet weak var item_releaseddate: UILabel!
    
    @IBOutlet weak var shop_Address: UILabel!
    
    @IBOutlet weak var shop_contactno: UILabel!
    
    @IBOutlet weak var shop_email: UILabel!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
