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
    
    
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTableView.separatorStyle = .none
        userImage.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey: "image") ?? ""), placeholderImage: UIImage(named: "profilepic"))
        userName.text = UserDefaults.standard.string(forKey: "name")
        emailAddress.text = UserDefaults.standard.string(forKey: "email")
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
        CellRegisterUtil.cellRegister(nibName: "PostsTableViewCell", tableView: postTableView)
        
    }

}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
}
