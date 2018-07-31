//
//  ProfileTableViewCell.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layoutIfNeeded()
    }
    
    func configure(with userInfo: UserInfo) {
        userAvatarImageView.setRoundedWith(borderWidth: 2.4, color: UIColor.purple)
        userAvatarImageView.setImageFrom(stringURL: userInfo.avatarURL!)
        userNameLabel.text = userInfo.name
        userLoginLabel.text = userInfo.login
        userBioLabel.text = userInfo.bio ?? "Add your short bio throught 'edit'"
        self.layoutIfNeeded()
    }
}

