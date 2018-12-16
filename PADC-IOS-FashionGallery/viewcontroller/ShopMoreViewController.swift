//
//  ShopMoreViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/10/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
import CarbonKit

class ShopMoreViewController: UIViewController, CarbonTabSwipeNavigationDelegate {

    @IBAction func backHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateImage(for view: UIView) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
    
    var single: UIImage {
        let button = UIButton()
        let icon = UIImage(named: "single")
        button.setImage(icon, for: .normal)
        //button.setTitle("", for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        //button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.sizeToFit()
        return generateImage(for: button) ?? UIImage()
    }
    var title_name : String = "Fashion Gallery"

    var multi: UIImage {
        let button = UIButton()
        let icon = UIImage(named: "multi")
        button.setImage(icon, for: .normal)
        //button.setTitle("", for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        //button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.sizeToFit()
        return generateImage(for: button) ?? UIImage()
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        if index == 0 {
            let screen = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
            screen.fashionItemList = DataModel.shared.mostPopularFashionItemList
            screen.is_one = true
            return screen
        }else {
            let screen = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
            screen.fashionItemList = DataModel.shared.mostPopularFashionItemList
            screen.is_one = false
            return screen
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = title_name
        let items = [single,multi] as [Any]
        
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        
        carbonTabSwipeNavigation.setTabExtraWidth(30)
        //carbonTabSwipeNavigation.setTabBarHeight(50)
        carbonTabSwipeNavigation.setNormalColor(UIColor.gray)
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.black)
        carbonTabSwipeNavigation.setSelectedColor(UIColor.black)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
    }

}
