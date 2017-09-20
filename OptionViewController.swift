//
//  OptionViewController.swift
//  ScreeningDeveloper
//
//  Created by Jorge Carbonell O'farrill on 2017-08-05.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit



class OptionViewController: UIViewController{


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.presentLogingController))

    }

    func presentLogingController() {
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.present(loginController, animated: true, completion: nil)
    }

    func goToMenue()  {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menueVC")
        self.present(vc, animated: true, completion: nil)
    }




}
