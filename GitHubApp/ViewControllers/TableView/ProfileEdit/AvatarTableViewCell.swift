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
        let size: (width: CGFloat, height: CGFloat) = (avatarImageView.frame.width, avatarImageView.frame.height)
        let imagePickerButton = UIButton(frame: CGRect(x: size.width/10, y: size.height/3, width: size.width/1.5, height: size.height/6))
        imagePickerButton.setTitle("Change photo", for: .normal)
        imagePickerButton.setTitleColor(.white, for: .normal)
        imagePickerButton.backgroundColor = .purple
        imagePickerButton.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        avatarImageView.addSubview(imagePickerButton)
    }
    
    @objc func pressed(_ sender: UIButton!) {
        imageSharingDelegate.pickImage()
    }
}

extension AvatarTableViewCell: ImageSetter {
    func setImage(_ image: UIImage) {
        self.avatarImageView.image = image
    }
}
