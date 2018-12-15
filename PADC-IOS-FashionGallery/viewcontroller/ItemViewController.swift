//
//  ItemViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/10/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    var is_one : Bool = false
    
    var fashionItemList : [FashionItemVO] = [] {
        didSet {
            if let itemCollectionView = itemCollectionView {
                itemCollectionView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        CellRegisterUtil.cellRegister(nibName: "JustForYouCollectionViewCell", collectionView:
            self.itemCollectionView)
    }

}

extension ItemViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fashionItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JustForYouCollectionViewCell", for: indexPath) as! JustForYouCollectionViewCell
        
        let item = fashionItemList[indexPath.row]
        cell.item_image.sd_setImage(with: URL(string: item.item_images[0]), placeholderImage: UIImage(named: "profile"))
        cell.item_price.text = "$ \(item.item_price ?? "0")"
        cell.ratingview.rating = Double(item.item_rating)
        
        return cell
    }
    
    
}

extension ItemViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (self.is_one == true) {
            print("page 1")
            let width = self.view.frame.width
            return CGSize(width: width, height: width - 100)
        } else {
            print("page 2")
            let width = self.view.frame.width/2
            return CGSize(width: width, height: width * 1.4)
        }
        
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
            let vc = navigationController.viewControllers[0] as! DetailViewController
            vc.fashionItem = fashionItemList[indexPath.row]
            self.present(navigationController, animated: true, completion: nil)
        }
}

