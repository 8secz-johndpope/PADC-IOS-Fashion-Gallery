//
//  ShopVO.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import Foundation
import UIKit

class ShopVO : NSObject {
    
    var shop_id : Int = 0
    
    var shop_name : String? = nil
    
    var shop_contact_no : String? = nil
    
    var shop_contact_email : String? = nil
    
    var shop_contact_address : String? = nil
    
    public static func parseToShopListsVO(json : [String : Any]) -> ShopVO {
        
        let shop = ShopVO()
        shop.shop_id = json["shop_id"] as? Int ?? 0
        shop.shop_contact_no = json["shop_contact_no"] as? String
        shop.shop_contact_email = json["shop_contact_email"] as? String
        shop.shop_contact_address = json["shop_contact_address"] as? String
        shop.shop_name = json["shop_name"] as? String
        return shop
        
    }
    
}
