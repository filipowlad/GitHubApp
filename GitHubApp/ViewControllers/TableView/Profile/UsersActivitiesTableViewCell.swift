//
//  UsersActivitiesTableViewCell.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 31.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class UsersActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var userActivityLabel: UILabel!
    
    func configure(with activity: String) {
        userActivityLabel.text = activity
    }
}
