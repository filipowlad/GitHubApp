//
//  UIImageViewExtension.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

extension UIImageView {
    func setRoundedWith(borderWidth: CGFloat, color: UIColor) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = color.cgColor
        layer.cornerRadius = self.frame.width / borderWidth
        clipsToBounds = true
    }
}
