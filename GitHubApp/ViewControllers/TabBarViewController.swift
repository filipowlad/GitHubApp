//
//  TabBarViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 27.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var userInfo: UserInfo!
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        for viewController in self.viewControllers! {
            if viewController is ProfileTableViewController {
                guard let profileVC = viewController as? ProfileTableViewController else { return }
                profileVC.userInfo = userInfo
                break
            }
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: EditProfileTableViewController.reuseIdentifier) as? EditProfileTableViewController else { return }
        editVC.userInfo = userInfo
        editVC.token = token
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        CoreDataModel.deleteRecords()
        guard let loginNC = storyboard?.instantiateViewController(withIdentifier: "loginNavigationController") as? UINavigationController else { return }
        UIApplication.shared.keyWindow?.rootViewController = loginNC
    }
}
