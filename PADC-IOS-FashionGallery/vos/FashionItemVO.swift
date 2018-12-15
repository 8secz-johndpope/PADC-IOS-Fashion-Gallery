//
//  FashionItemVO.swift
//  PADC-IOS-FashionGallery
//
//  Created by Thet Htun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import Foundation

class FashionItemVO: NSObject {
    var item_id : String? = nil
    var guid : String? = nil
    var is_item_in_stock : Bool? = nil
    var item_price : String? = nil
    var item_images : [String] = []
    var item_category_id : Int = 0
    var item_rating : Int = 0
    var item_discount_percentage : Int = 0
    var shop_id : [Int] = []
    var available_colors : [String] = []
    var item_brand : String? = nil
    var item_description : String? = nil
    var item_name : String? = nil
    var item_released_date : String? = nil
    var posted_by : String? = nil
    var item_size : String? = nil
    
    
    public static func parseToFashionItemVO(json : [String : Any]) -> FashionItemVO {
        
        let item = FashionItemVO()
        item.item_id = json["item_id"] as? String ?? ""
        item.guid = json["guid"] as? String ?? ""
        item.is_item_in_stock = json["is_item_in_stock"] as? Bool ?? false
        item.item_price = json["item_price"] as? String ?? ""
        item.item_images = json["item_images"] as? [String] ?? []
        item.item_category_id = json["item_category_id"] as? Int ?? 0
        item.item_rating = json["item_rating"] as? Int ?? 0
        item.item_discount_percentage = json["item_discount_percentage"] as? Int ?? 0
        item.shop_id = json["shop_id"] as? [Int] ?? []
        item.available_colors = json["available_colors"] as? [String] ?? []
        item.item_brand = json["item_brand"] as? String ?? ""
        item.item_description = json["item_description"] as? String ?? ""
        item.item_name = json["item_name"] as? String ?? ""
        item.item_released_date = json["item_released_date"] as? String ?? ""
        item.posted_by = json["posted_by"] as? String ?? ""
        item.item_size = json["item_size"] as? String ?? ""

        return item
        
    }
}
