//
//  HomeViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/7/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private let imageView = UIImageView(image: UIImage(named: "profilepic"))

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showImage(true)
    }
    
    /// Show or hide the image from NavBar while going to next screen or back to initial screen
    ///
    /// - Parameter show: show or hide the image from NavBar
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = show ? 1.0 : 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageview.image = UIImage(named: "img1.png")
//        imageview.contentMode = UIView.ContentMode.scaleAspectFit
//        imageview.layer.cornerRadius = 20
//        imageview.layer.masksToBounds = true
//        containView.addSubview(imageview)
//        let leftBarButton = UIBarButtonItem(customView: containView)
//        self.navigationItem.leftBarButtonItem = leftBarButton
        
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        imageView.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey: "image") ?? ""), placeholderImage: UIImage(named: "profilepic"))
        setupUI()
        CellRegisterUtil.cellRegister(nibName: "AdsCollectionViewCell", collectionView:
            self.homeCollectionView)
        CellRegisterUtil.cellRegister(nibName: "PopularCollectionViewCell", collectionView:
            self.homeCollectionView)
        CellRegisterUtil.cellRegister(nibName: "PromotionCollectionViewCell", collectionView:
            self.homeCollectionView)
        CellRegisterUtil.cellRegister(nibName: "JustForYouCollectionViewCell", collectionView:
            self.homeCollectionView)
        
        getAllFashionItem()
    }
   
    func getAllFashionItem() {
        DataModel.shared.getFashionItemsList(success: {
            self.homeCollectionView.reloadData()
        }) { (msg) in
            
        }
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        //title = "Large Title"
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }

    @IBAction func onClickPostFashionItem(_ sender: Any) {
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "PostItemViewController") as! UINavigationController
        //let vc = navigationController.viewControllers[0] as! PostItemViewController
        self.present(navigationController, animated: true, completion: nil)
    }
}


private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}


extension HomeViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0 || section == 1 || section == 2) {
            return 1
        }
        return DataModel.shared.discountedFashionItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            cell.popularFashionItemList = DataModel.shared.mostPopularFashionItemList
            return cell
        }else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCollectionViewCell", for: indexPath) as! PromotionCollectionViewCell
            cell.categoryDemoMap = DataModel.shared.categoryItemMap
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JustForYouCollectionViewCell", for: indexPath) as! JustForYouCollectionViewCell
            
            let item = DataModel.shared.discountedFashionItemList[indexPath.row]
            cell.item_image.sd_setImage(with: URL(string: item.item_images[0]), placeholderImage: UIImage(named: "profile"))
            cell.item_price.text = "$ \(item.item_price ?? "0")"
            cell.ratingview.rating = Double(item.item_rating)
            
            return cell
        }
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.frame.width, height: 180)
        }else if indexPath.section == 1 {
            return CGSize(width: self.view.frame.width, height: 230)
        }else if indexPath.section == 2 {
            return CGSize(width: self.view.frame.width, height: 280)
        } else {
            let width = (self.view.frame.width/2 - 4) + 4
            return CGSize(width: width, height: width * 1.4)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 3) {
            let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
            let vc = navigationController.viewControllers[0] as! DetailViewController
            vc.fashionItem = DataModel.shared.discountedFashionItemList[indexPath.row]
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
