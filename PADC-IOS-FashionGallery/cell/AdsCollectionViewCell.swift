//
//  AdsCollectionViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/8/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
import ImageSlideshow

class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var slideshow: ImageSlideshow!
    let localSource = [ImageSource(imageString: "img1")!, ImageSource(imageString: "img2")!, ImageSource(imageString: "img3")!, ImageSource(imageString: "img4")!]
    
    let sdWebImageSource = [SDWebImageSource(urlString: "http://www.articlesxpert.com/wp-content/uploads/2017/08/new-season-AF-page-04-1024x400.jpg")!, SDWebImageSource(urlString: "https://tall.life/wp-content/uploads/American-Tall-Black-Friday-1024x400.jpg")!, SDWebImageSource(urlString: "http://bbf.digital/wp-content/uploads/2015/10/Colg-1024x400.jpg")!, SDWebImageSource(urlString: "https://media.juiceonline.com/wp-content/uploads/2014/07/16104417/2.0-bannerJULY13-1024x400.jpg")!, SDWebImageSource(urlString: "https://stylishzoo.com/wp-content/uploads/2018/07/Montage-Ivonne-D-Collection-1024x400.png")!]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 5))
        slideshow.contentScaleMode = UIView.ContentMode.scaleAspectFit
        slideshow.clipsToBounds = true
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(sdWebImageSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
//        var mainView: UIStoryboard!
//        mainView = UIStoryboard(name: "Main", bundle: nil)
//        let navigationController = mainView.instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
//        self.window!.rootViewController = navigationController
    }

}
