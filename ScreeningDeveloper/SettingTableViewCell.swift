//
//  SettingTableViewCell.swift
//  ScreeningApp
//
//  Created by Jorge Carbonell O'farrill on 2017-07-02.
//  Copyright © 2017 Jorge Carbonell O'farrill. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    

    @IBOutlet weak var settingsLabel: UILabel!

    @IBOutlet weak var cellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
