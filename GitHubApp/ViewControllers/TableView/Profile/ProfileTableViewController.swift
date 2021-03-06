//
//  ProfileTableViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, Refresh {

    var userInfo: UserInfo!
    var token: String!
    
    var usersActivities = ["Repositories", "Stars", "Followers", "Following"]

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.addSubview(self.customRefreshControl)
        refresh()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func refresh() {
        refreshTableWithBackgroundSpinner(in: self, with: token) { response in
            guard let response = response else { return }
            self.userInfo = response
            self.tableView.reloadData()
        }
    }
    
    lazy var customRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(self.handleRefresh(_:)),
            for: UIControlEvents.valueChanged
        )
        refreshControl.tintColor = UIColor.purple
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshTableWithoutBackgrounSpinner(with: token) { response in
            guard let response = response else { return }
            self.userInfo = response
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSectionType(rawValue: section) else { return 0 }
        if let _ = userInfo {
            switch section {
            case .profileInfo:
                return 1
            case .usersCredentials:
                return userInfo.credentials.count
            case .usersActions:
                return usersActivities.count
            }
        } else {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersActivitiesTableViewCell.reuseIdentifier, for: indexPath) as? UsersActivitiesTableViewCell else { return UITableViewCell() }
            cell.configure(with: usersActivities[indexPath.row])
            return cell
        }
    }
}
