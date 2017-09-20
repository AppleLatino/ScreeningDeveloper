//
//  ResetViewController.swift
//  ScreeningApp
//
//  Created by Jorge Carbonell O'farrill on 2017-06-29.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

    @IBOutlet weak var emailTextField: HoshiTextField!

    @IBOutlet weak var passwordTextField: HoshiTextField!

    @IBOutlet weak var confirmTextField: HoshiTextField!

    @IBOutlet weak var resetAccountButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleDone))
        handleResetField()

        // Do any additional setup after loading the view.
    }

    func handleResetField() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confPassword = confirmTextField.text else {
            let message = "Please verify that all fields are completed. Thanks"
            let alertController = UIAlertController(title: "Ooops you forgot something!", message: message, preferredStyle: .alert)
            let actionItem = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(actionItem)
            self.present(alertController,animated: true,completion: nil)

            return
        }
        if password == confPassword {

            resetAccountButton.isHidden = false
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleDone() {
        dismiss(animated: true, completion: nil)
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
