//
//  ItemCategory.swift
//  PADC-IOS-FashionGallery
//
//  Created by Thet Htun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import Foundation

class ItemCategory : NSObject {
    var category_id : Int = 0
    var category_description : String? = ""
    var category_name : String? = ""
    
    static func parseToShopListsVO(json : [String : Any]) -> ItemCategory {
        let vo = ItemCategory()
        vo.category_id = json["category_id"] as? Int ?? 0
        vo.category_description = json["category_description"] as? String ?? ""
        vo.category_name = json["category_name"] as? String ?? ""
        return vo
    }
}
