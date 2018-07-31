//
//  ProfileCredentialTableViewCell.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 30.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class ProfileCredentialTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configure(with info: (key: String, value: String?)) {
        keyLabel.text = info.key.capitalized + ":"
        if info.value == nil || (info.value?.isEmpty)! {
            valueLabel.text = "have no data"
            valueLabel.textColor = .gray
        } else if let value = info.value {
            valueLabel.text = value
            valueLabel.textColor = .purple
        }
    }
}
