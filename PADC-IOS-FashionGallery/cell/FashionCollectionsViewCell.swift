//
//  FashionCollectionsViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/8/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class FashionCollectionsViewCell: UICollectionViewCell {

    @IBOutlet weak var fashion_image: UIImageView!
    
    @IBOutlet weak var item_name: UILabel!
    
    @IBOutlet weak var item_price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
