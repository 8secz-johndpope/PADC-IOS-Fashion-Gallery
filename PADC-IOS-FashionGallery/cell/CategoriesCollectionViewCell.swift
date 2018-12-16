//
//  CategoriesCollectionViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/8/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var item_name: UILabel!
    @IBOutlet weak var item_image: UIImageView!
    
    var fashionItem : FashionItemVO? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        if fashionItem != nil {
            bindData(item: fashionItem!)
        }
        
    }
    
    private func bindData(item : FashionItemVO) {
        item_name.text = item.item_name
        item_image.sd_setImage(with: URL(string: item.item_images[0]), placeholderImage: UIImage(named: ""))
    }
}
