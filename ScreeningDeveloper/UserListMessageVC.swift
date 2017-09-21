//
//  UserListMessageVC.swift
//  ScreeningApp
//
//  Created by Jorge Carbonell O'farrill on 2017-07-02.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit

class UserListMessageVC: UIViewController {

    

    @objc let usersArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UserListMessageVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userList", for: indexPath) as! UserListTableViewCell
        cell.userName.text = usersArray[indexPath.row]
        

        return cell

    }
}
