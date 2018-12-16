//
//  LoginViewController.swift
//  PADC-IOS-FashionGallery
//
//  Created by Shwe Yi Tun on 12/15/18.
//  Copyright © 2018 padcmyanmar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController : BaseViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error) != nil {
            print("An error occured during Google Authentication")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                self.showAlertDialog(inputMessage: error.localizedDescription)
                return
            }
            print (user.profile.name)
            print (user.profile.email)
            UserDefaults.standard.set(user.profile.name ?? "", forKey: "name")
            UserDefaults.standard.set(user.profile.email ?? "", forKey: "email")
            if user.profile.hasImage
            {
                let pic = user.profile.imageURL(withDimension: 300)
                UserDefaults.standard.set(pic?.absoluteString ?? "" , forKey: "image")
            }
            self.registerToFirebase(name: UserDefaults.standard.string(forKey: "name") ?? "",email: UserDefaults.standard.string(forKey: "email") ?? "",image: UserDefaults.standard.string(forKey: "image") ?? "",type: "google")
            if let tabbar = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as? UITabBarController) {
                self.view.window?.rootViewController = tabbar;
                self.present(tabbar, animated: true, completion: nil)
            }
        }
        
    }
    
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        dismiss(animated: true) {() -> Void in }
    }

    func registerToFirebase(name:String,email:String,image:String,type:String) {
        let user = CustomerVO()
        user.name = name
        user.email = email
        user.image_url = image
        user.login_type = type
        DataModel.shared.register(user: user, success: {
            //self.showAlertDialog(inputMessage: "Account Created")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    @IBAction func facebookLogin(_ sender: CustomButton) {
        facebookLogin()
    }
    
    
    @IBAction func googleLogin(_ sender: CustomButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func facebookLogin() {
        
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { result, error in
            if error != nil {
                print("Process error")
            }else {
                let fbLoginResult: FBSDKLoginManagerLoginResult  = result!
                
                if( result?.isCancelled)!{
                    return }
                
                
                if(fbLoginResult .grantedPermissions.contains("email")){
                    self.getFbId()
                }
            }
            
        })
        
    }
    
    
    func getFbId(){
        if(FBSDKAccessToken.current() != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name , first_name, last_name , email,picture.type(large)"]).start(completionHandler: { (connection, result, error) in
                guard let Info = result as? [String: Any] else { return }
                if let imageURL = ((Info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    //Download image from imageURL
                    print(imageURL)
                    UserDefaults.standard.set(imageURL , forKey: "image")

                }
                print(Info)
                print(Info["name"] as? String ?? "")
                print(Info["email"] as? String ?? "")
                UserDefaults.standard.set(Info["name"] as? String ?? "", forKey: "name")
                UserDefaults.standard.set(Info["email"] as? String ?? "", forKey: "email")

                self.registerToFirebase(name: UserDefaults.standard.string(forKey: "name") ?? "",email: UserDefaults.standard.string(forKey: "email") ?? "",image: UserDefaults.standard.string(forKey: "image") ?? "",type: "facebook")

                if let tabbar = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as? UITabBarController) {
                    self.view.window?.rootViewController = tabbar;
                    self.present(tabbar, animated: true, completion: nil)
                }
                
                if(error == nil){
                    print("result")
                }
                
            })
        }
    }

    

}
