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
        contentMode = UIViewContentMode.scaleAspectFill
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = color.cgColor
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
    
    func setImageFrom(stringURL: String) {
        guard let imageURL = URL(string: stringURL) else { return }
        if let imageData: Data = try? Data(contentsOf: imageURL, options: .mappedRead) {
            self.image = UIImage(data: imageData as Data)
        }
    }
}
