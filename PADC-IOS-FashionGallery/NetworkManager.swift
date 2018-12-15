//
//  NetworkManager.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class NetworkManager {
    
    let rootRef : DatabaseReference!
    
    private init() {
        rootRef = Database.database().reference()
    }
    
    static var shared : NetworkManager =  {
        return sharedNetworkManager
    }()
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func loadShopLists(success : @escaping ([ShopVO]) -> Void, failure : @escaping () -> Void) {
        
        rootRef.child("shop_list").observe(.value) { (dataSnapshot) in
            
            if let shops = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                var shopLists : [ShopVO] = []
                
                for shop in shops {
                    
                    if let value = shop.value as? [String : AnyObject] {
                        shopLists.append(ShopVO.parseToShopListsVO(json: value))
                    }
                }
                
                success(shopLists)
                
            }
            
        }
        
    }
    
    func loadFashionItemList(success : @escaping () -> Void, failure : @escaping (String) -> Void) {
        
        rootRef.child(SharedConstants.FirebaseNode.FASHION_ITEM_LIST).observe(.value) { (dataSnapshot) in
            
            if let items = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                
                var itemList : [FashionItemVO] = []
                
                for item in items {
                    if let value = item.value as? [String : AnyObject] {
                        itemList.append(FashionItemVO.parseToFashionItemVO(json: value))
                    }
                }
                
                DataModel.shared.fashionItemList = itemList
                
                success()
                
            } else {
                failure("Failed to fetch fashion items")
            }
            
        }
        
    }
    
    func loadItemCategoryList(success: @escaping () -> Void, failure : @escaping (String) -> Void) {
        rootRef.child(SharedConstants.FirebaseNode.ITEM_CATEGORY_LIST).observe(.value) { (dataSnapshot) in
            
            if let items = dataSnapshot.children.allObjects as? [DataSnapshot] {
                var itemList : [ItemCategory] = []
                
                for item in items {
                    if let value = item.value as? [String : AnyObject] {
                        itemList.append(ItemCategory.parseToShopListsVO(json: value))
                    }
                }
                
                DataModel.shared.itemCategoryList = itemList
                
                success()
            } else {
                failure("Failed to fetch item category")
            }
        }
    }
    
    
}

