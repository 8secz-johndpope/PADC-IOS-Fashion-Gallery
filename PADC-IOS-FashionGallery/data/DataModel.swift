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
    
    var itemCategoryList : [ItemCategory] = []
    
    var itemCategoryDescriptionMap : [Int : String] = [:]
    
    var itemCategoryNameMap : [Int : String] = [:]
    
    var shopDetailsMap : [Int : ShopVO] = [:]
    
    var shopList : [ShopVO] = []
    
    static var shared : DataModel = {
        return sharedDataModel
    }()
    
    private static var sharedDataModel: DataModel = {
        let dataModel = DataModel()
        return dataModel
    }()
    
    func getShopLists(success : @escaping ([ShopVO]) -> Void, failure : @escaping () -> Void) {
        
        NetworkManager.shared.loadShopLists(success: { (data) in
            
            self.shopList = data
            
            self.mapShopDetailsById(items: self.shopList)
            
            success(data)
            
        }, failure: {
            failure()
        })
        
    }
    
    func getShopVOByShopId(shopId : Int) -> ShopVO? {
        if shopId > 0 && !shopList.isEmpty {
            return shopDetailsMap[shopId]
        }
        return nil
    }
    
    func mapShopDetailsById(items : [ShopVO]) {
        for item in items {
            shopDetailsMap[item.shop_id] = item
        }
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
    
    func getItemCategoryList(success : @escaping() -> Void, failure : @escaping (String) -> Void) {
        NetworkManager.shared.loadItemCategoryList(success: {
            
            self.mapItemCategoryDescriptionAndNameById(items: self.itemCategoryList)
            
            success()
        }) { (msg) in
            failure(msg)
        }
    }
    
    func mapItemCategoryDescriptionAndNameById(items : [ItemCategory]) {
        for item in items {
            itemCategoryDescriptionMap[item.category_id] = item.category_description
            itemCategoryNameMap[item.category_id] = item.category_name
        }
    }
    
    func getItemCategoryDescriptionById(categroyId : Int) -> String {
        if itemCategoryDescriptionMap.count > 0 &&
            categroyId > 0 {
            return itemCategoryDescriptionMap[categroyId] ?? "Empty Category Description"
        }
        return "Unkonwn Category Description"
    }
    
    func getItemCategoryNameById(categroyId : Int) -> String {
        if itemCategoryDescriptionMap.count > 0 &&
            categroyId > 0 {
            return itemCategoryNameMap[categroyId] ?? "Empty Category Name"
        }
        return "Unkonwn Category Name"
    }
    
}
