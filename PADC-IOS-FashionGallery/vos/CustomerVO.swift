//
//  CustomerVO.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/16/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import Foundation
import UIKit

class CustomerVO : NSObject{
    
    var id : String = UUID.init().uuidString
    var email : String? = nil
    var name : String? = nil
    var image_url : String? = nil
    var login_type : String? = nil

    
    public static func parseToDictionary(user : CustomerVO) -> [String : Any] {
        
        let value = [
            "id" : user.id,
            "email" : user.email ?? "",
            "name" : user.name ?? "",
            "image_url" : user.image_url ?? "",
            "login_type" : user.login_type ?? "",
            ]
        
        return value
        
    }
    
    public static func parseToCustomerVO(json : [String : Any]) -> CustomerVO {
        let user = CustomerVO()
        user.id = json["id"] as! String
        user.email = json["email"] as? String
        user.name = json["password"] as? String
        user.image_url = json["image_url"] as? String
        user.login_type = json["login_type"] as? String
        return user
        
    }
    
}
