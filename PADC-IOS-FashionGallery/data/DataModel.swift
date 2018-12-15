//
//  DataModel.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataModel {
    private init() {}
    var shop : ShopVO? = nil
    
    static var shared : DataModel = {
        return sharedDataModel
    }()
    
    private static var sharedDataModel: DataModel = {
        let dataModel = DataModel()
        return dataModel
    }()
    
    func getShopLists(success : @escaping ([ShopVO]) -> Void, failure : @escaping () -> Void) {
        
        NetworkManager.shared.loadShopLists(success: { (data) in
            
            success(data)
            
        }, failure: {
            failure()
        })
        
    }
    
}
