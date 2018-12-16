//
//  ViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Win Than Htike on 12/2/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var emailAddress: UILabel!
    
    
    @IBOutlet weak var userpostCollectionView: UICollectionView!
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewConroller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.view.window?.rootViewController = viewConroller
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey: "image") ?? ""), placeholderImage: UIImage(named: "profilepic"))
        userName.text = UserDefaults.standard.string(forKey: "name")
        emailAddress.text = UserDefaults.standard.string(forKey: "email")
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
        userpostCollectionView.delegate = self
        userpostCollectionView.dataSource = self
        CellRegisterUtil.cellRegister(nibName: "JustForYouCollectionViewCell", collectionView: userpostCollectionView)
        
    }

    @IBAction func onClickRefresh(_ sender: Any) {
        DataModel.shared.filterUserPostedItems()
        userpostCollectionView.reloadData()
    }
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.itemPostedByUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JustForYouCollectionViewCell", for: indexPath) as! JustForYouCollectionViewCell
        let item = DataModel.shared.itemPostedByUser[indexPath.row]
        cell.item_image.sd_setImage(with: URL(string: item.item_images[0]), placeholderImage: UIImage(named: "profilepic"))
        cell.item_price.text = "$ \(item.item_price ?? "0")"
        cell.ratingview.rating = Double(item.item_rating)
        return cell
    }
    
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (self.view.frame.width/2 - 4) + 4
            return CGSize(width: width, height: width * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
            //let vc = navigationController.viewControllers[0] as! DetailViewController
            //vc.fashionItem = DataModel.shared.discountedFashionItemList[indexPath.row]
            self.present(navigationController, animated: true, completion: nil)
    }
}
