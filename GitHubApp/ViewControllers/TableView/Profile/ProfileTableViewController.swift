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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSectionType(rawValue: section) else { return 0 }
        switch section {
        case .profileInfo:
            let numberOfSections = (userInfo != nil) ? 1 : 0
            return numberOfSections
        case .usersActions:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.configure(with: userInfo)
        // Configure the cell...

        return cell
    }

}
