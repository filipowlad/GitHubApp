//
//  EditCredentialTableViewCell.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class EditCredentialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var credentialTypeLabel: UILabel!
    @IBOutlet weak var credentialTextField: UITextField!
    var currentText: String! {
        didSet { self.credentialsDelegate.getCredentials(credentialTypeLabel.text!, self.currentText) }
    }
    
    var credentialsDelegate: CredentialsData!

    func configure(with credential: (key: String, value: String?)) {
        credentialTypeLabel.text = credential.key
        credentialTextField.text = credential.value
        currentText = credential.value ?? ""
        credentialTextField.placeholder = ProfileTextFieldsPlaysholders(rawValue: credential.key)?.playsholder
    }
}

extension EditCredentialTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        self.currentText = currentText.replacingCharacters(in: stringRange, with: string)
        return true
    }
}
