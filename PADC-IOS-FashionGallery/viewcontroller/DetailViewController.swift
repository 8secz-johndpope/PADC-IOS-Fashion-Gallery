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
    
    var fashionItem : FashionItemVO? = nil
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if fashionItem != nil {
            bindData(item: fashionItem!)
        }
    }

    
    func bindData(item: FashionItemVO) {
        item_Image.sd_setImage(with: URL(string: item.item_images[0]), placeholderImage: UIImage(named: "profile"))
        item_price.text = "$ \(item.item_price ?? "0")"
        item_Description.text = item.item_description ?? ""
        item_Discount.text = "\(item.item_discount_percentage) %"
        item_Rating.rating = Double(item.item_rating)
        item_brand.text = item.item_brand ?? ""
        
        //TODO - Bind cetegory name
        
        item_releaseddate.text = item.item_released_date ?? ""
        
        //TODO - Bind shop info
        
    }
}
