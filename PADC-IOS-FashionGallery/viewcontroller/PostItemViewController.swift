//
//  PostItemViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Thet Htun on 12/16/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit

class PostItemViewController: BaseViewController{

    @IBOutlet weak var ivSampleImage: UIImageView!
    
    @IBOutlet weak var textFieldItemBrand : UITextField!
    
    @IBOutlet weak var textFieldItemDescription : UITextField!
    
    @IBOutlet weak var textFieldItemPrice : UITextField!
    
    @IBOutlet weak var switchHasDiscount : UISwitch!
    
    @IBOutlet weak var textFieldItemSize : UITextField!
    
    @IBOutlet weak var textFieldDiscountPercentage : UITextField!
    
    
    @IBOutlet weak var loadingIndicator : UIActivityIndicatorView!
    let imagePicker = UIImagePickerController()
    
    private var itemSampleImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }

    @IBAction func onClickDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        let fashionItemVO = FashionItemVO()
        fashionItemVO.item_brand = textFieldItemBrand.text ?? ""
        fashionItemVO.item_category_id = Int.random(in: 1 ... 6)
        fashionItemVO.item_description = textFieldItemDescription.text ?? ""
        fashionItemVO.item_discount_percentage = Int(textFieldDiscountPercentage.text ?? "0") ?? 0
        fashionItemVO.item_images = [itemSampleImage]
        fashionItemVO.item_name = textFieldItemBrand.text
        fashionItemVO.item_price = textFieldDiscountPercentage.text ?? "0"
        fashionItemVO.item_size = textFieldItemSize.text ?? "M"
        fashionItemVO.posted_by = DataModel.shared.currentCustomer?.email ?? "0"
        fashionItemVO.shop_id = [Int.random(in: 1 ... 10)]
        
        DataModel.shared.addFashionItem(fashionItem: fashionItemVO, success: {
            
            DataModel.shared.itemPostedByUser.append(fashionItemVO)
            
            self.showAlertDialog(inputMessage: "Item added successfully!")
        }) { (msg) in
            //Do something
        }
    }
    
    @IBAction func onSwitchedHasDiscount(_ sender : UISwitch) {
        if sender.isOn {
            textFieldDiscountPercentage.isHidden = false
        } else {
            textFieldDiscountPercentage.isHidden = true
        }
    }
    
    @IBAction func onClickAddSampleImage(_ sender: Any) {
        chooseUpload(sender as! UIButton, imagePickerControllerDelegate: self)
    }
    
    
}


extension PostItemViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            loadingIndicator.isHidden = false
            DataModel.shared.uploadImage(data: pickedImage.pngData(), success: { (url) in
                self.loadingIndicator.isHidden = true
                self.itemSampleImage = url
                self.ivSampleImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "kabyar-placeholder"))
                
            }) {_ in
                self.loadingIndicator.isHidden = true
                self.showAlertDialog(inputMessage: "Error.")
            }
            
        }
        
    }
    
}
