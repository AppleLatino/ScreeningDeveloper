//
//  MenueViewController.swift
//  ScreeningApp
//
//  Created by Jorge Carbonell O'farrill on 2017-06-30.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class MenueViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImage: DesignableImageView!

    @IBOutlet weak var openSettings: UIBarButtonItem!

    @objc var dataRef: DatabaseReference! {
        return Database.database().reference()
    }

    @objc var storageRef: Storage {
        return Storage.storage()
    }
    
    var user = [UserSettings]()


    


    override func viewDidLoad() {
        super.viewDidLoad()


        openSettings.target = revealViewController()
        openSettings.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
        
        

        checkIfUserIsLoggedIn()


        

        // Do any additional setup after loading the view.
    }
    

    @objc func loadUserInfo() {
        let ref = Database.database().reference()
        
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot.value as! [String : AnyObject]
            
            for (_, value) in users {
                if let uid = value["uid"] as? String {
                    if uid == Auth.auth().currentUser?.uid {
                        var userToShow = UserSettings()
                        if let userName = value["username"] as? String, let imagePath = value["photoURL"] as? String {
                            userToShow.username = userName
                            userToShow.userPhotoURL = imagePath
                            userToShow.useruid = uid
                            self.user.append(userToShow)
                            self.userNameLabel.text = userName
                            self.userImage.downloadImage(from: imagePath)
                            let url = URL(string: imagePath)
                            self.userImage.kf.setImage(with: url)
                            self.userImage.kf.indicatorType = .activity
                            let resource = ImageResource(downloadURL: url!, cacheKey: imagePath)
                            self.userImage.kf.setImage(with: resource)

                            
                        }
                    }
                }
            }
            
        
            
        })
        ref.removeAllObservers()
    
        
        
    }
    
    
    

    @objc func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            self.presentLogingController()
        } else {
            loadUserInfo()
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func presentLogingController() {
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.present(loginController, animated: true, completion: nil)
    }

    @objc func handleLogout() {
        if Auth.auth().currentUser?.uid != nil {
            do {
                try Auth.auth().signOut()
                self.presentLogingController()
            } catch  {
                print("logout")
            }
        }
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    @objc func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string:imgURL)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        
        task.resume()
    
    }
}

