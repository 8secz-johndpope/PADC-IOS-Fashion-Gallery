//
//  JustForYouCollectionViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/8/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
import Cosmos

class JustForYouCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingview: CosmosView!
    @IBOutlet weak var item_image: UIImageView!
    
    @IBOutlet weak var item_price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        CosmosRating.initializeRating(ratingview: ratingview, totalstar: 5, starsize: 15, starmargin: 3, rating : 3.5)
        
        ratingview.didTouchCosmos = { rating in
            print("Rated: \(rating)")
        }
        
        ratingview.didFinishTouchingCosmos = { rating in
            print("didFinishTouchingCosmos: \(rating)")
        }
    }

}
