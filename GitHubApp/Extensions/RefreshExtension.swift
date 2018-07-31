//
//  RefreshExtension.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 31.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

extension Refresh {
    func refreshTable(in vc: UIViewController, with token: String ,complition: @escaping (UserInfo?)->()) {
        vc.displaySpinner()
        GitHubConnectionManager.getUserInfo(with: token) { response in
            vc.removeSpinner()
            complition(response)
        }
    }
}
