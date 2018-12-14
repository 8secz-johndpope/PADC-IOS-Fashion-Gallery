//
//  ShopListsTableViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/14/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class ShopListsTableViewCell: UITableViewCell {

    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var shopAddress: UILabel!
    
    @IBOutlet weak var shopPhone: UILabel!
    
    @IBOutlet weak var shopEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
