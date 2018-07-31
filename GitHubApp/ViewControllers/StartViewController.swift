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
        self.displaySpinner()
        CoreDataModel.getRecord { token in
            guard let token = token else {
                self.removeSpinner()
                goToLogin()
                return
            }
            if  token.isEmpty {
                self.removeSpinner()
                goToLogin() }
            else {
                guard let userTabBarController = self.storyboard?.instantiateViewController(withIdentifier: TabBarViewController.reuseIdentifier) as? TabBarViewController else { return }
                userTabBarController.token = token
                _ = userTabBarController.preferredStatusBarStyle
                self.navigationController?.pushViewController(userTabBarController, animated: true)
            }
        }
    }
    
    private func goToLogin() {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
}
