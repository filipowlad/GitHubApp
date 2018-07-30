//
//  ProfileTableViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var userInfo: UserInfo!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSectionType(rawValue: section) else { return 0 }
        switch section {
        case .profileInfo:
            return 1
        case .usersCredentials:
            return userInfo.credentials.count
        case .usersActions:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ProfileSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .profileInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            cell.configure(with: userInfo)
            return cell
        case .usersCredentials:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCredentialTableViewCell.reuseIdentifier, for: indexPath) as? ProfileCredentialTableViewCell else { return UITableViewCell() }
            cell.configure(with: userInfo.credentials[indexPath.row])
            return cell
        case .usersActions:
            return UITableViewCell()
        }
    }
}
