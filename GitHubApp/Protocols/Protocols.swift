//
//  Protocols.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 31.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

protocol CredentialsData {
    func getCredentials(_ key: String, _ value: String)
}

protocol BioData {
    func getBio(_ value: String)
}

protocol ImageGetter {
    func pickImage()
}

protocol ImageSetter {
    func setImage(_ image: UIImage)
}

protocol Refresh {
    func refreshTableWithBackgroundSpinner(in vc: UIViewController, with token: String ,complition: @escaping (UserInfo?)->())
    func refreshTableWithoutBackgrounSpinner(with token: String ,complition: @escaping (UserInfo?)->())
}
