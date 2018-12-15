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
    
    var fashionItemList : [FashionItemVO] = []
    
    var mostPopularFashionItemList : [FashionItemVO] = []
    
    var discountedFashionItemList : [FashionItemVO] = []
    
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
    
    func getFashionItemsList(success : @escaping () -> Void, failure : @escaping (String) -> Void) {

        NetworkManager.shared.loadFashionItemList(success: {
            
            for item in self.fashionItemList {
                if item.item_rating > 3 {
                    self.mostPopularFashionItemList.append(item)
                }
                
                if item.item_discount_percentage > 20 {
                    self.discountedFashionItemList.append(item)
                }
            }
            
            success()
        }) { (msg) in
            failure(msg)
        }
        
    
    }
    
}
