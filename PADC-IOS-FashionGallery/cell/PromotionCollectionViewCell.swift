//
//  PromotionCollectionViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/8/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblcollection: UILabel!
    
    @IBOutlet weak var lblshowmoreCollection: UILabel!
    @IBOutlet weak var collectionsview: UICollectionView!
    
    var categoryDemoMap : [Int : FashionItemVO] = [:] {
        didSet {
            collectionsview.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionsview.delegate = self
        collectionsview.dataSource = self
        CellRegisterUtil.cellRegister(nibName: "FashionCollectionsViewCell", collectionView: collectionsview)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClickViewMore))
        tap.numberOfTapsRequired = 1
        lblshowmoreCollection.isUserInteractionEnabled = true
        lblshowmoreCollection.addGestureRecognizer(tap)
    }
    
    @objc func onClickViewMore(sender:UILabel){
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainView.instantiateViewController(withIdentifier: "ShopMoreViewController") as! UINavigationController
        let vc = navigationController.viewControllers[0] as! ShopMoreViewController
        vc.title_name = "Collections"
        self.window?.rootViewController?.present(navigationController, animated : true)
        
    }

}

extension PromotionCollectionViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDemoMap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FashionCollectionsViewCell", for: indexPath) as! FashionCollectionsViewCell
        
        let itemDetail = categoryDemoMap[indexPath.row + 1]
        let itemCategoryName = DataModel.shared.getItemCategoryNameById(categroyId: itemDetail?.item_category_id ?? 0)
        let itemCategoryDesc = DataModel.shared.getItemCategoryDescriptionById(categroyId: itemDetail?.item_category_id ?? 0)
        
        cell.item_name.text = itemCategoryName
        cell.item_price.text = itemCategoryDesc
        cell.fashion_image.sd_setImage(with: URL(string: itemDetail?.item_images[0] ?? ""), placeholderImage: UIImage(named: "profilepic"))
        return cell
    }
    
}

extension PromotionCollectionViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItemCategoryId = categoryDemoMap[indexPath.row]?.item_category_id ?? 0
        let fashionItemListByCategoryId = DataModel.shared.getFashionItemListByCategoryId(categoryId: selectedItemCategoryId)
        
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainView.instantiateViewController(withIdentifier: "ShopMoreViewController") as! UINavigationController
        let vc = navigationController.viewControllers[0] as! ShopMoreViewController
        vc.title_name = "Collections"
        vc.fashionItemList = fashionItemListByCategoryId
        self.window?.rootViewController?.present(navigationController, animated : true)
        
//        var mainView: UIStoryboard!
//        mainView = UIStoryboard(name: "Main", bundle: nil)
//        let navigationController = mainView.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
//        //let vc = navigationController.viewControllers[0] as! DetailViewController
//        self.window?.rootViewController?.present(navigationController, animated : true)
    }
}
