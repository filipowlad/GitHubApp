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
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = self.frame.width / borderWidth
        self.clipsToBounds = true
    }
    
    func setImageFrom(stringURL: String) {
        guard let imageURL = URL(string: stringURL) else { return }
        if let imageData: Data = try? Data(contentsOf: imageURL, options: .mappedRead) {
            self.image = UIImage(data: imageData as Data)
        }
    }
}
