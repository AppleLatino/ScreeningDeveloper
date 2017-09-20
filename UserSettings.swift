//
//  UserSettings.swift
//  ScreeningDeveloper
//
//  Created by Jorge Carbonell O'farrill on 2017-08-02.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import Foundation
import Firebase

struct UserSettings {
    var username: String!
    var useremail:String!
    var userPhotoURL: String!
    var useruid:String!
    var userStorage: StorageReference!
    var ref: DatabaseReference?
    var key: String?
    var userpassword: String!

    /*init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        username = (snapshot.value! as! NSDictionary)["username"] as! String
        useremail = (snapshot.value! as! NSDictionary)["email"] as! String
        useruid = (snapshot.value! as! NSDictionary)["uid"] as! String
        userpassword = (snapshot.value! as! NSDictionary)["password"] as! String
        userPhotoURL = (snapshot.value! as! NSDictionary)["photoURL"] as! String
        


    }*/

    

}

