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
    let storageRef : StorageReference!
    
    private init() {
        rootRef = Database.database().reference()
        storageRef = Storage.storage().reference().child("images")
    }
    
    static var shared : NetworkManager =  {
        return sharedNetworkManager
    }()
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func loadShopLists(success : @escaping ([ShopVO]) -> Void, failure : @escaping () -> Void) {
        
        rootRef.child(SharedConstants.FirebaseNode.SHOP_LIST).observe(.value) { (dataSnapshot) in
            
            if let shops = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                var shopLists : [ShopVO] = []
                
                for shop in shops {
                    
                    if let value = shop.value as? [String : AnyObject] {
                        shopLists.append(ShopVO.parseToShopListsVO(json: value))
                    }
                }
                
                success(shopLists)
                
            } else {
                failure()
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
    

    func addFashionItem(fashionItem : FashionItemVO, success : @escaping () -> Void, failure : @escaping () -> Void) {
        
        rootRef.child(SharedConstants.FirebaseNode.FASHION_ITEM_LIST).child(String(DataModel.shared.fashionItemList.count)).setValue(FashionItemVO.parseToDictionary(item: fashionItem))
        success()
        
    }
    
    func imageUpload(data : Data?, success : @escaping (String) -> Void, failure : @escaping (String) -> Void) {
        
        if let imageData = data {
            
            let uploadImageRef = storageRef.child("\(Date().millisecondsSince1970).png")
            
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                
                print(metadata ?? "NO METADATA")
                print(error ?? "NO ERROR")
                
                uploadImageRef.downloadURL(completion: { (url, error) in
                    
                    if let error = error {
                        print(error)
                    }
                    
                    success(url!.absoluteString)
                    
                })
                
            }
            
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "NO MORE PROGRESS")
            }
            
            uploadTask.resume()
            
        }
        

    func loadCustomerList(success : @escaping ([CustomerVO]) -> Void, failure : @escaping () -> Void){
        rootRef.child(SharedConstants.FirebaseNode.CUSTOMER).observe(.value) { (dataSnapshot) in
            
            if let customers = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                var customerLists : [CustomerVO] = []
                
                for customer in customers {
                    
                    if let value = customer.value as? [String : AnyObject] {
                        customerLists.append(CustomerVO.parseToCustomerVO(json: value))
                    }
                }
                
                success(customerLists)
                
            } else {
                failure()
            }
            
        }

    }
    
    
}

