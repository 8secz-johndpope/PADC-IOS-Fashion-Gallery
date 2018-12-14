//
//  PostsTableViewCell.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/14/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var postText: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    
}
