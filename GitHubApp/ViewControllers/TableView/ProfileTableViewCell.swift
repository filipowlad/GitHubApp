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
    @IBOutlet weak var credentialsStackView: UIStackView!
    
    func configure(with userInfo: UserInfo) {
        userAvatarImageView.setRoundedWith(borderWidth: 2.4, color: UIColor.purple)
        userNameLabel.text = userInfo.name
        userLoginLabel.text = userInfo.login
        userBioLabel.text = userInfo.bio
        guard let imageURL = URL(string: userInfo.avatarURL!) else { return }
        if let imageData: Data = try? Data(contentsOf: imageURL, options: .mappedRead) {
            userAvatarImageView.image = UIImage(data: imageData as Data)
        }
        userInfo.credentials.forEach { info in
            if let value = info.value {
                let textLabel = UILabel()
                textLabel.widthAnchor.constraint(equalToConstant: self.credentialsStackView.frame.width).isActive = true
                textLabel.text = info.key + " : " + value
                textLabel.textAlignment = .left
                textLabel.lineBreakMode = .byCharWrapping
                textLabel.numberOfLines = 0
                self.credentialsStackView.addArrangedSubview(textLabel)
            }
        }
    }
}
