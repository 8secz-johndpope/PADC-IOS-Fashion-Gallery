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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FashionCollectionsViewCell", for: indexPath) as! FashionCollectionsViewCell
        return cell
    }
    
}

extension PromotionCollectionViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainView.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
        //let vc = navigationController.viewControllers[0] as! DetailViewController
        self.window?.rootViewController?.present(navigationController, animated : true)
    }
}
