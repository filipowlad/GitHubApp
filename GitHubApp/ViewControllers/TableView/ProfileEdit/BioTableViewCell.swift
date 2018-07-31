//
//  BioTableViewCell.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class BioTableViewCell: UITableViewCell {

    @IBOutlet weak var bioTextView: UITextView!
    var currentText: String! {
        didSet { self.bioDelegate.getBio(self.currentText) }
    }
    
    var bioDelegate: BioData!
    
    func configure(with userBioString: String?) {
        bioTextView.text = userBioString
        currentText = userBioString ?? ""
    }
}

extension BioTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        self.currentText = currentText.replacingCharacters(in: stringRange, with: text)
        return true
    }
}
