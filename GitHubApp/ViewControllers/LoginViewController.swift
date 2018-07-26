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
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.safariAuthenticator = SFAuthenticationSession(url: URL(string: GitHubConnectionManager.link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!, callbackURLScheme: GitHubConnectionManager.redirectURL, completionHandler: { (url, error) in
            if let url = url {
                GitHubConnectionManager.handle(redirectURL: url) { response in
                    GitHubConnectionManager.getUserInfo(with: response.accessToken) { response in
                        print(response)
                        guard let userTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else { return }
                        for viewController in userTabBarController.viewControllers! {
                            if viewController is ProfileTableViewController {
                                guard let profileVC = viewController as? ProfileTableViewController else { return }
                                profileVC.profileInfo = response
                                break
                            }
                        }
                        self.navigationController?.pushViewController(userTabBarController, animated: true)
                    }
                }
            }
        })
        if let svc = self.safariAuthenticator as? SFAuthenticationSession { svc.start() }
    }
}
