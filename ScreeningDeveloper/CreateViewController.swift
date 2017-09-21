//
//  CreateViewController.swift
//  ScreeningApp
//
//  Created by Jorge Carbonell O'farrill on 2017-06-29.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit
import Firebase


class CreateViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userPicture: DesignableImageView!
    
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    @IBOutlet weak var nameTextField: HoshiTextField!
    
    @IBOutlet weak var passwordTextField: HoshiTextField!
    
    @IBOutlet weak var confirmTextField: HoshiTextField!

    @IBOutlet weak var createButton: UIButton!


    @objc let picker = UIImagePickerController()
    @objc var userStorage: StorageReference!
    @objc var ref: DatabaseReference!




    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleDone))
        picker.delegate = self
        let storage = Storage.storage().reference(forURL:"gs://screeningdeveloper.appspot.com")
        userStorage = storage.child("users")
        ref = Database.database().reference()

    }

    @objc func handleDone() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectPictureProfile(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.userPicture.image = image
            createButton.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }




    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func createAccountButton(_ sender: Any) {

        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confPassword = confirmTextField.text else {
            let message = "Please verify that all fields are completed. Thanks"
            let alertController = UIAlertController(title: "Ooops you forgot something!", message: message, preferredStyle: .alert)
            let actionItem = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(actionItem)
            self.present(alertController,animated: true,completion: nil)

            return
        }
        if password == confPassword {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)

                } else {
                    let message = "You have successfully created your account.Click Ok to continue"
                    let alertController = UIAlertController(title: "Account Successfully Created", message: message, preferredStyle: .alert)
                    let actionItem = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(actionItem)
                    self.present(alertController, animated: true, completion: {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC")
                        self.present(vc, animated: true, completion: nil)


            })
        }

                if let user = user {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.nameTextField.text!
                    changeRequest?.commitChanges(completion: nil)

                    let imageRef = self.userStorage.child("\(user.uid).JPG")
                    let data = UIImageJPEGRepresentation(self.userPicture.image!, 0.70)
                    let uploadTask = imageRef.putData(data!, metadata: nil, completion: { (metadata, err) in
                        if err != nil {
                            print(err!.localizedDescription)
                        }

                        imageRef.downloadURL(completion: { (url, er) in
                            if er != nil {
                                print(er!.localizedDescription)
                            }
                            if let url = url {
                                let userInfo:[String : Any] = ["uid" : user.uid, "username" : name, "photoURL": url.absoluteString,
                                                               "email":email,"password":password]
                                self.ref.child("users").child(user.uid).setValue(userInfo)
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC")
                                self.present(vc, animated: true, completion: nil)

                            }
                        })
                    })

                    uploadTask.resume()
                }

            })
                

        } else {
            let message = "Please make sure to confirm password and password field"
            let alertController = UIAlertController(title: "Password missmacht", message: message, preferredStyle: .alert)
            let actionItem = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(actionItem)
            self.present(alertController,animated: true,completion: nil)
        }


    }
    

}
