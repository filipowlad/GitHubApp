//
//  StartViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 27.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .default
        checkUserState()
    }
    
    private func checkUserState() {
        
        CoreDataModel.getRecord { token in
            guard let token = token else {
                goToLogin()
                return
            }
            if  token.isEmpty { goToLogin() }
            else {
                GitHubConnectionManager.getUserInfo(with: token) { response in
                    guard let response = response else {
                        CoreDataModel.deleteRecords()
                        self.goToLogin()
                        return
                    }
                    guard let userTabBarController = self.storyboard?.instantiateViewController(withIdentifier: TabBarViewController.reuseIdentifier) as? TabBarViewController else { return }
                    userTabBarController.userInfo = response
                    userTabBarController.token = token
                    self.navigationController?.pushViewController(userTabBarController, animated: true)
                }
            }
        }
    }
    
    private func goToLogin() {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
}
