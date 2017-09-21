//
//  ViewController.swift
//  ScreeningApp
//
//  Created by Jorge Carbonell O'farrill on 2017-06-28.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit




class LoginViewController: UIViewController {

    @objc let loginButton = FBSDKLoginButton()

    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!





    override func viewDidLoad() {
        super.viewDidLoad()



        //loginButton.frame = CGRect(x: 28, y: 370, width: 260, height: 45)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        view.addSubview((loginButton as UIView))

        loginButton.translatesAutoresizingMaskIntoConstraints = false

        let margin = view.layoutMarginsGuide


        //NSLayoutConstraint.activate([leftC,rightC,topC,heightC])

        margin.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor, constant: -12).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -12).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        


        /*if (FBSDKAccessToken.current() == nil) {
            presentMenueController()
        }*/
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential) { (user, error) in
                if error != nil {
                    if error != nil {
                        print("Hay problemas con fb")
                    } else {

                        if user != nil {

                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC")
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                    }
                }
            }


            print(error.localizedDescription)
            return
        }
        // ...
    }

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.presentMenueController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {

        let email = emailField.text
        let password = passwordField.text




        if (email?.isEmpty)! || (password?.isEmpty)!  {

           

            let alert = UIAlertController(title: "Error", message: "There is some boxes empty", preferredStyle: .alert)
            let actionItem = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionItem)
            self.present(alert,animated: true,completion: nil)

        } else {
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in

                if error != nil {
                    let message = "Please make sure the password or email is correct or contact admin"
                    let alertController = UIAlertController(title: "Oh nooo!!", message: message, preferredStyle: .alert)
                    let actionItem = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(actionItem)
                    self.present(alertController,animated: true,completion: nil)
                } else {

                    if user != nil {

                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC")
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                }
            })
            
        }
        
    }

    @objc func presentMenueController() {
        let menueController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC") as! SWRevealViewController
        self.present(menueController, animated: true, completion: nil)
    }


}
extension LoginViewController: FBSDKLoginButtonDelegate {

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)

        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                if error != nil {
                    print("Hay problemas con fb")
                } else {

                    if user != nil {

                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC")
                        self.present(vc, animated: true, completion: nil)
                    }

                }

            }
        }

        FBSDKGraphRequest(graphPath: "/me", parameters: ["field":"id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Fail to log in fb", err!)

                return
            }
        }

        print(result)
        return
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

        return
    }

    

}

    

