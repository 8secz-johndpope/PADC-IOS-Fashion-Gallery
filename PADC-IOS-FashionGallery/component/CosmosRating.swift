//
//  CosmosRating.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/10/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
import Cosmos

class CosmosRating {
    static func initializeRating(ratingview : CosmosView, totalstar: Int, starsize: Double, starmargin : Double, rating : Double){
        ratingview.settings.filledImage = UIImage(named: "RatingStarFilled")?.withRenderingMode(.alwaysOriginal)
        ratingview.settings.emptyImage = UIImage(named: "RatingStarEmpty")?.withRenderingMode(.alwaysOriginal)
        
        ratingview.settings.totalStars = totalstar
        ratingview.settings.starSize = starsize
        ratingview.settings.starMargin = starmargin
        ratingview.settings.fillMode = .half
        ratingview.rating = rating
        //ratingview.text = "Rate me"
        //ratingview.settings.textColor = .red
        //ratingview.settings.textMargin = 10
        ratingview.backgroundColor = .white
        ratingview.settings.filledColor = UIColor.orange
        ratingview.settings.emptyBorderColor = UIColor.orange
        ratingview.settings.filledBorderColor = UIColor.orange
    }
}
