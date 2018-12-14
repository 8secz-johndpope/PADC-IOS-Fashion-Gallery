//
//  PopularCollectionViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/8/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var popularcollectionview: UICollectionView!
    @IBOutlet weak var popularshopmore: UILabel!
    @IBOutlet weak var lbl_popular: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        popularcollectionview.delegate = self
        popularcollectionview.dataSource = self
        CellRegisterUtil.cellRegister(nibName: "CategoriesCollectionViewCell", collectionView: popularcollectionview)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClickViewMore))
        tap.numberOfTapsRequired = 1
        popularshopmore.isUserInteractionEnabled = true
        popularshopmore.addGestureRecognizer(tap)

    }
    
    @objc func onClickViewMore(sender:UILabel){
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainView.instantiateViewController(withIdentifier: "ShopMoreViewController") as! UINavigationController
        let vc = navigationController.viewControllers[0] as! ShopMoreViewController
        vc.title_name = "Most Popular"
        self.window?.rootViewController?.present(navigationController, animated : true)
        
    }

}

extension PopularCollectionViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        return cell
    }
    
}

extension PopularCollectionViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 220)
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = mainView.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
            //let vc = navigationController.viewControllers[0] as! DetailViewController
            self.window?.rootViewController?.present(navigationController, animated : true)
        }
}
