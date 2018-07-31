//
//  AvatarTableViewCell.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class AvatarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    var imageSharingDelegate: ImageGetter!
    
    func configure(with userAvatarString: String) {
        avatarImageView.setImageFrom(stringURL: userAvatarString)
        avatarImageView.setRoundedWith(borderWidth: 2.4, color: UIColor.purple)
    }
    
    @IBAction func changePhotoButtonTapped(_ sender: UIButton) {
        imageSharingDelegate.pickImage()
    }
}

extension AvatarTableViewCell: ImageSetter {
    func setImage(_ image: UIImage) {
        self.avatarImageView.image = image
    }
}
