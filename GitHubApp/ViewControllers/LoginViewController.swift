//
//  LoginViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 25.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {
    
    private var safariAuthenticator: Any? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .default
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.displaySpinner()
        self.safariAuthenticator = SFAuthenticationSession(url: URL(string: GitHubConnectionManager.link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!, callbackURLScheme: GitHubConnectionManager.redirectURL, completionHandler: { (url, error) in
            if let url = url {
                GitHubConnectionManager.handle(redirectURL: url) { token in
                    GitHubConnectionManager.getUserInfo(with: token.accessToken) { response in
                        self.removeSpinner()
                        guard let userTabBarController = self.storyboard?.instantiateViewController(withIdentifier: TabBarViewController.reuseIdentifier) as? TabBarViewController else { return }
                        userTabBarController.token = token.accessToken
                        self.navigationController?.pushViewController(userTabBarController, animated: true)
                    }
                }
            }
        })
        if let svc = self.safariAuthenticator as? SFAuthenticationSession { svc.start() }
    }
}
